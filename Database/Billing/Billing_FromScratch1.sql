

--declare @ProviderId int, @ApprovalDate datetime



--declare cur cursor FAST_FORWARD
--for 
--	select ProviderId, min(convert(datetime, a.PropertyValue)) as ApprovalDate
--	from ProviderServiceProperty a (nolock)
--	inner join ProviderService b (nolock) on a.ProviderServiceId = b.Id 
--	inner join Provider c (nolock) on c.Id = b.ProviderId
--	where PropertyType = 'Report'
--	and PropertyName = 'ApproveDate'
--	and c.PromoCode = ''
--	group by ProviderId


--open cur

--FETCH NEXT FROM cur INTO @ProviderId, @ApprovalDate


declare @DateOffset int = 0
declare @ProviderTable table (ProviderID int Primary Key, ApprovalDate datetime)

insert @ProviderTable
select ProviderId, min(convert(datetime, a.PropertyValue)) as ApprovalDate
from ProviderServiceProperty a (nolock)
inner join ProviderService b (nolock) on a.ProviderServiceId = b.Id 
inner join Provider c (nolock) on c.Id = b.ProviderId
where PropertyType = 'Report'
and PropertyName = 'ApproveDate'
and c.PromoCode = ''
and b.ProviderId not in (select ProviderId from ProviderProperty where PropertyType = 'Setup' and PropertyName = 'China' and PropertyValue = 'Y')
group by ProviderId


while 0 = 0
begin

			-- calculate the adjustment based on Term 2
		insert BillProviderTransaction
			(ProviderId,
			ProviderBillingTypeCodeId,
			BillProviderPayTermRateId,
			Quantity,
			UnitValue,
			TotalValue,
			TransactionDate,

			SourceTableId,
			SourceTable,
			CreateDate)

		select 
			a.ProviderId,
			1,
			a.BillProviderPayTermRateId,
			1,
			a.Rate,
			a.AdjustValue,
			a.TranDate,

			null,
			null,
			GETUTCDATE()
		from  ( select a.ProviderId,
				DATEADD(minute, 30*24*60-1, a.StartDate) as TranDate,
				case when c.AdjustValue is null then b.Rate when c.AdjustValue < b.Rate then b.Rate - c.AdjustValue else 0 end as AdjustValue,
				b.Id as BillProviderPayTermRateId,
				b.Rate
				from BillProviderStatement a
				join BillProviderPayTermRate b on b.ProviderId = a.ProviderId and b.BillPayTermId = 2
				left join (select a.BillProviderStatementId,
							sum (b.TotalValue) as AdjustValue, b.ProviderId
							from BillProviderStatementTransaction a
							join BillProviderTransaction b on b.Id = a.BillProviderTransactionId
							join BillProviderPayTermRate c on c.Id = b.BillProviderPayTermRateId and c.BillPayTermId = 1
							group by a.BillProviderStatementId, b.ProviderId) c on c.BillProviderStatementId = a.Id
				where a.IsCurrent = 1 and (c.AdjustValue is null or c.AdjustValue < b.Rate) and DATEADD(day, 30, a.StartDate)<GETUTCDATE()
		) a

		insert [BillProviderStatementTransaction](
			[BillProviderStatementId],
			[BillProviderTransactionId],
			[CreateDate])
		select a.Id as [BillProviderStatementId],
			b.Id as [BillProviderTransactionId],
			GETUTCDATE()
		from BillProviderStatement  a
		join BillProviderTransaction b on a.ProviderId = b.ProviderId
		left join [BillProviderStatementTransaction] c on c.BillProviderTransactionId = b.Id
		where c.Id is null 
		and a.IsCurrent = 1

	-- About Statement

	update c
	set EndDate = DATEADD(day, 30, StartDate),
		StatementDate = DATEADD(day, 30, StartDate),
		IsCurrent = 0,
		Approved = case when DATEADD(day, 30, StartDate) < dateadd(day, -15, GETUTCDATE()) then 1 else 0 end
	from BillProviderStatement c
	where DATEADD(day, 30, StartDate) < GETUTCDATE()
	and IsCurrent = 1

	insert BillProviderStatement (
		ProviderId,
		StatementDate,
		StartDate,
		EndDate,
		PayableAmount,
		PaidAmount,
		IsCurrent,
		Approved,
		CreateDate)
	select a.ProviderId,
		b.EndDate,
		isnull(b.EndDate, a.ApprovalDate),
		null,
		isnull(b.Payable,0),
		isnull(b.Paid,0),
		1,
		0,
		GETUTCDATE()
	from @ProviderTable a
		left join (
					select max(a.StatementId) as StatementId,
						a.ProviderId,
						dateadd(day, 30, max(z.StartDate)) as EndDate,
						sum (isnull(case when x.ProviderBillingTypeCodeId in (1) then x.TotalValue else 0 end, 0)) + isnull(max(z.PayableAmount),0) - isnull(max(z.PaidAmount),0) as Payable,
						sum (isnull(case when x.ProviderBillingTypeCodeId in (2) then x.TotalValue else 0 end, 0)) as Paid
					 from (select max(Id) as StatementId, ProviderId
							from BillProviderStatement
							group by ProviderId) a
					left join BillProviderStatement z on z.Id = a.StatementId
					left join BillProviderStatementTransaction y on y.BillProviderStatementId = z.Id
					left join BillProviderTransaction x on x.Id = y.BillProviderTransactionId and x.TransactionDate < z.EndDate
					--left join BillProviderTransactionRequest w on x.SourceTable = 'BillProviderTransactionRequest' and w.Id = x.SourceTableId and dateadd(second, w.ServiceSeconds, w.AcceptedTime) < z.EndDate
					group by a.ProviderId)  b on b.ProviderId = a.ProviderID
		where isnull(b.EndDate, dateadd(day, -1, getutcdate())) < GETUTCDATE()

		if @@ROWCOUNT = 0
			break


		insert [BillProviderTransactionRequest] (
				ProviderId,
				RequestId,
				PersonId,
				ServiceSeconds,
				AcceptedTime,
				OffsetTime,
				CreateDate
			)
			select a.ProviderId,
				a.RequestId,
				a.PersonId,
			case when a.EndTime = '1/1/2000' then 60 
				when a.RequestStatusCodeId in (5, 6) and a.StartTime = a.EndTime then 60
				when a.RequestStatusCodeId <> 3 and  datediff(second, a.StartTime, a.EndTime) < 60 then 60
				when a.RequestStatusCodeId <> 3 then datediff(second, a.StartTime, a.EndTime) else a.RequestLogTime end as ServiceSeconds,
			a.AcceptedTime,
			0,
			GETUTCDATE()
		from ( select b.RequestStatusCodeId,
				datediff(second, b.CreateDate, b.LastUpdate) as RequestLogTime, 
				case
					when isnull(y.StartTime, GETUTCDATE()) <= isnull(x.StartDate, GETUTCDATE()) then isnull(y.StartTime, GETUTCDATE())
					else isnull(x.StartDate, GETUTCDATE())
				end as StartTime,
				case
					when isnull(y.FinishTime, '1/1/2000') >= isnull(x.FinishDate, '1/1/2000') then isnull(y.FinishTime, '1/1/2000')
					else isnull(x.FinishDate, '1/1/2000')
				end as EndTime,
				DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), a.AcceptedTime) AS AcceptedTimeLocal,
				b.Id as RequestId,
				a.Id as RequestProviderId,
				a.ProviderId,
				c.Id as PersonId,
				isnull(a.AcceptedTime,w.CreateDate) as AcceptedTime
			from BillProviderStatement a1 (nolock) 
				inner join RequestProvider a on a1.ProviderId  = a.ProviderId
				inner join Request b on a.requestId = b.Id
				inner join Person c on b.PersonId = c.Id
				left join ProviderOpenTaskAcceptLog as w on w.RequestProviderId = a.Id
				left join TextSession z on a.RequestId = z.RequestId
				left join (
					select a.Id as TextSessionId, case when isnull(z.StartDate, GETUTCDATE()) <= isnull(y.StartDate, GETUTCDATE()) and isnull(z.StartDate, GETUTCDATE()) <= isnull(x.StartDate, GETUTCDATE()) 
										then isnull(z.StartDate, GETUTCDATE())
									when isnull(y.StartDate, GETUTCDATE()) <= isnull(z.StartDate, GETUTCDATE()) and isnull(y.StartDate, GETUTCDATE()) <= isnull(x.StartDate, GETUTCDATE()) 
										then isnull(y.StartDate, GETUTCDATE())
									else isnull(x.StartDate, GETUTCDATE()) end as StartTime,
									case when isnull(z.FinishDate, GETUTCDATE()) >= isnull(y.FinishDate, '1/1/2000') and isnull(z.FinishDate, GETUTCDATE()) >= isnull(x.FinishDate, '1/1/2000') 
										then isnull(z.FinishDate, GETUTCDATE())
									when isnull(y.FinishDate, GETUTCDATE()) >= isnull(z.FinishDate, '1/1/2000') and isnull(y.FinishDate, GETUTCDATE()) >= isnull(x.FinishDate, '1/1/2000') 
										then isnull(y.FinishDate, GETUTCDATE())
									else isnull(x.FinishDate, GETUTCDATE()) end as FinishTime
					from TextSession a (nolock)
						left join (
							select b.TextSessionId, min(a.CreateDate) as StartDate, max(a.CreateDate) as FinishDate  from TextBlockText a (nolock) inner join TextBlock b (nolock) on a.TextBlockId = b.Id
							where FromCaller = 0 and Msg <> ''
							group by b.TextSessionId
						) z on a.Id = z.TextSessionId
						left join (
							select b.TextSessionId, min(a.CreateDate) as StartDate, max(a.CreateDate) as FinishDate  from TextBlockAudio a (nolock) inner join TextBlock b (nolock) on a.TextBlockId = b.Id
							where FromCaller = 0 
							group by b.TextSessionId
							) y on a.Id = y.TextSessionId
						left join (
							select b.TextSessionId, min(a.CreateDate) as StartDate, max(a.CreateDate) as FinishDate  from TextBlockImage a (nolock) inner join TextBlock b (nolock) on a.TextBlockId = b.Id
							where FromCaller = 0 
							group by b.TextSessionId
						) x on a.Id = x.TextSessionId
				) y on z.Id = y.TextSessionId
				left join (
					select RequestId, min(CreateDate) as StartDate, max(LastUpdate) as FinishDate
					from RequestCall 
					group by RequestId) x on a.RequestId = x.RequestId
			where a1.IsCurrent =1 and  (w.Id is not null and w.CreateDate > a1.StartDate and  w.CreateDate < DATEADD (day, 30, a1.StartDate)  --and a.RequestId = 11963
			or (a.AcceptedTime > a1.StartDate and a.AcceptedTime < DATEADD (day, 30, a1.StartDate) )) --and a.RequestId = 11963
			) a
		left join [BillProviderTransactionRequest] z on z.RequestId = a.RequestId
		where a.AcceptedTime is not null
		and z.Id is null
		order by ProviderId, RequestId  --511


		insert BillProviderTransaction
		(	ProviderId,
			ProviderBillingTypeCodeId,
			BillProviderPayTermRateId,
			Quantity,
			UnitValue,
			TotalValue,
			TransactionDate,

			SourceTableId,
			SourceTable,
			CreateDate)
		select 
			a.ProviderId,
			1,
			a.RateId,
			a.ServiceMinutes,
			a.Rate/60.0,
			cast (round(a.ServiceMinutes*(a.Rate/60.0), 2) as decimal(8,2)),
			a.AcceptedTime,

			a.Id,
			'BillProviderTransactionRequest',
			GETUTCDATE()
		from  (select a.Id as Id,
			a.ProviderId,
			a.ServiceSeconds/60 + case when  (a.ServiceSeconds/60.0 - a.ServiceSeconds/60) > 0 then 1 else 0 end as ServiceMinutes,
			a.ProviderServiceId,
			a.AcceptedTime,
			b.Rate,
			a.RateId
			from 
				(select a.Id,
					a.ProviderId,
					a.ServiceSeconds,
					a.AcceptedTime,
					max(c.Id) as ProviderServiceId,
					max (d.Id) as RateId
				from BillProviderTransactionRequest a
				join RequestProvider b on b.RequestId = a.RequestId and b.ProviderId = a.ProviderId	
				join ProviderService c on c.Id = b.ProviderServiceId
				join BillProviderPayTermRate d on d.ProviderId = a.ProviderId and d.BillPayTermId = 1
												and (d.ProviderServiceId = c.Id or d.ProviderServiceId is null)
												and a.AcceptedTime between d.StartDate and isnull(d.EndDate, dateadd(year, 1, getutcdate()))
				group by a.Id, a.ProviderId, a.ServiceSeconds, a.AcceptedTime
				) as a
			join BillProviderPayTermRate b on b.Id = a.RateId
			left join BillProviderTransaction w on w.SourceTableId = a.Id
		where w.Id is null)a

		insert [BillProviderStatementTransaction](
			[BillProviderStatementId],
			[BillProviderTransactionId],
			[CreateDate])
		select a.Id as [BillProviderStatementId],
			b.Id as [BillProviderTransactionId],
			GETUTCDATE()
		from BillProviderStatement a
		join BillProviderTransaction b on a.ProviderId = b.ProviderId
		left join [BillProviderStatementTransaction] c on c.BillProviderTransactionId = b.Id
		where a.IsCurrent = 1 and c.Id is null 

		-- Redeem
		insert [BillProviderPaid](
			[ProviderId],

			[BillProviderAcctRefId],
			[BillProviderAcctTable],

			[BillPaymentEngineId],
			[BillPaymentEngineInfoId],
			[BillPaymentEngineInfoTable],

			[BillPaymentEngineLogId],
			[BillPaymentEngineLogTable],
	
			[PaidDate],

			[CreateDate]
		)
		select 
			a.ProviderId,

			b.Id,
			'BillProviderAcctPaypal',


			1,
			1,
			'BillProviderPayGateway_Paypal',

			isnull((select max(Id) from BillProviderPayGateway_PayPalManualLog),0),
			'BillProviderPayGateway_PayPalManualLog',

			a.PaidDate,
			GETUTCDATE()
		from BillProviderStatement a1
		join TempPaymentData a on a.ProviderId = a1.ProviderId and a.PaidDate >= a1.StartDate and a.PaidDate < dateadd(day, 30, a1.StartDate)
		join BillProviderAcctPaypal b on b.ProviderId = a.ProviderId
		--left join [BillProviderPaid] z on z.ProviderId = a.ProviderId
		where a1.IsCurrent = 1
		--and z.Id is null
--select  *from TempPaymentData
--select * from BillProviderAcctPaypal
--select * from BillProviderStatement
--select * from [BillProviderPaid]

		insert BillProviderTransaction
			(ProviderId,
			ProviderBillingTypeCodeId,
			BillProviderPayTermRateId,
			Quantity,
			UnitValue,
			TotalValue,
			TransactionDate,

			SourceTableId,
			SourceTable,
			CreateDate)

		select 
			a.ProviderId,
			2,
			null,
			1,
			b.Amount,
			b.Amount,
			b.PaidDate,

			a.Id,
			'BillProviderPaid',
			GETUTCDATE()
		from dbo.[BillProviderPaid] a
		join TempPaymentData b on a.ProviderId = b.ProviderId and a.PaidDate = b.PaidDate
		left join BillProviderTransaction z on z.SourceTable = 'BillProviderPaid'  and z.SourceTableId = a.Id
		where z.Id is null


		insert [BillProviderStatementTransaction](
			[BillProviderStatementId],
			[BillProviderTransactionId],
			[CreateDate])
		select a.StatId as [BillProviderStatementId],
			b.Id as [BillProviderTransactionId],
			GETUTCDATE()
		from (select max(Id) as StatId,ProviderId  from BillProviderStatement where IsCurrent = 1 group by ProviderId)  a
		join BillProviderTransaction b on a.ProviderId = b.ProviderId
		left join [BillProviderStatementTransaction] c on c.BillProviderTransactionId = b.Id
		where c.Id is null 
		and b.ProviderBillingTypeCodeId = 2



		select @DateOffset = @DateOffset + 30

end




select * from BillProviderStatement order by ProviderId, StartDate

select * from BillProviderStatement where PaidAmount>0  order by ProviderId, StartDate

select * from BillProviderTransaction order by ProviderId, StartDate

sp_help BillProviderStatement

select b.Id, a.ProviderId
from Request a, Request b where a.Id = b.Id
group by  a.ProviderId, b.Id
having b.Id = max(a.Id)

select count(*)
from Request

12
71
114
147
194

select max(a.StatementId) as StatementId,
	a.ProviderId,
	dateadd(day, 30, max(z.StartDate)) as EndDate,
	sum (isnull(case when x.ProviderBillingTypeCodeId in (1) then x.TotalValue else 0 end, 0)) + isnull(max(z.PayableAmount),0) - isnull(max(z.PaidAmount),0) as Payable,
	sum (isnull(case when x.ProviderBillingTypeCodeId in (2) then x.TotalValue else 0 end, 0)) as Paid
	from (select max(Id) as StatementId, ProviderId
		from BillProviderStatement
		where isCurrent = 0
		group by ProviderId) a
left join BillProviderStatement z on z.Id = a.StatementId
left join BillProviderStatementTransaction y on y.BillProviderStatementId = z.Id
left join BillProviderTransaction x on x.Id = y.BillProviderTransactionId and x.TransactionDate < z.EndDate
--left join BillProviderTransactionRequest w on x.SourceTable = 'BillProviderTransactionRequest' and w.Id = x.SourceTableId and dateadd(second, w.ServiceSeconds, w.AcceptedTime) < z.EndDate

where z.ProviderId = 458
group by a.ProviderId, x.ProviderBillingTypeCodeId


select a.StatementId as StatementId,
	a.ProviderId,
	dateadd(day, 30, z.StartDate) as EndDate,
	sum (isnull(case when x.ProviderBillingTypeCodeId in (1) then x.TotalValue else 0 end, 0)) + isnull(z.PayableAmount,0) - isnull(z.PaidAmount,0) as Payable,
	sum (isnull(case when x.ProviderBillingTypeCodeId in (2) then x.TotalValue else 0 end, 0)) as Paid
	from (select max(Id) as StatementId, ProviderId
		from BillProviderStatement
		where isCurrent = 0
		group by ProviderId) a
left join BillProviderStatement z on z.Id = a.StatementId
left join BillProviderStatementTransaction y on y.BillProviderStatementId = z.Id
left join BillProviderTransaction x on x.Id = y.BillProviderTransactionId and x.TransactionDate < z.EndDate
--left join BillProviderTransactionRequest w on x.SourceTable = 'BillProviderTransactionRequest' and w.Id = x.SourceTableId and dateadd(second, w.ServiceSeconds, w.AcceptedTime) < z.EndDate

where z.ProviderId = 458
group by a.ProviderId, x.ProviderBillingTypeCodeId




select * from BillProviderTransaction a  join BillProviderStatementTransaction  b on b.BillProviderTransactionId = a.Id where   b.BillProviderTransactionId = 934

select * from BillProviderStatement where Id = 87

select * from BillProviderTransaction where ProviderId = 511 order by TransactionDate

select * from BillProviderStatement where ProviderId = 511 

select * from ProviderServiceProperty where ProviderServiceId in (select Id from ProviderService where ProviderId = 511)

select * from BillProviderPaid where ProviderId = 458

select * from BillProviderStatement  where Id = 35

select a.StatementId as StatementId, y.*, x.*,
						a.ProviderId--,
						--dateadd(day, 30, max(z.StartDate)) as EndDate--,
						--sum (isnull(case when x.ProviderBillingTypeCodeId in (1) then x.TotalValue else 0 end, 0)) + isnull(max(z.PayableAmount),0) - isnull(max(z.PaidAmount),0) as Payable,
						--sum (isnull(case when x.ProviderBillingTypeCodeId in (2) then x.TotalValue else 0 end, 0)) as Paid
					 from (select max(Id) as StatementId, ProviderId
							from BillProviderStatement
							where Id = 35
							group by ProviderId) a
					left join BillProviderStatement z on z.Id = a.StatementId
					left join BillProviderStatementTransaction y on y.BillProviderStatementId = z.Id
					left join BillProviderTransaction x on x.Id = y.BillProviderTransactionId and x.TransactionDate < z.EndDate
					--left join BillProviderTransactionRequest w on x.SourceTable = 'BillProviderTransactionRequest' and w.Id = x.SourceTableId and dateadd(second, w.ServiceSeconds, w.AcceptedTime) < z.EndDate
					group by a.ProviderId

select * from BillProviderStatementTransaction where BillProviderStatementId =99

select * from BillProviderTransaction a  join BillProviderStatementTransaction  b on b.BillProviderTransactionId = a.Id where a.ProviderId = 509
select * from BillProviderTransaction a where  a.ProviderId = 509
					33
69
128
178

select * from BillProviderTransaction a   where ProviderBillingTypeCodeId = 2

select * from BillProviderPaid