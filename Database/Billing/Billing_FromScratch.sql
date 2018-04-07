select  *from ProviderProperty

-- Support ProviderProductCodeId {Request, Interview, DPT}
-- Support BillActionTimeCodeId {Instant, onStatementGenerate}

-- 1. Create First Statement for all providers
insert BillProviderStatement (ProviderId,
	StatementDate,
	StartDate,
	EndDate,
	PayableAmount,
	PaidAmount,
	IsCurrent,
	Approved,
	CreateDate)
select a.ProviderId,
	null,
	a.ApprovalDate,
	null,
	0,
	0,
	1,
	1,
	GETUTCDATE()
from 
	(select ProviderId, min(convert(datetime, a.PropertyValue)) as ApprovalDate
			from ProviderServiceProperty a (nolock)
			inner join ProviderService b (nolock) on a.ProviderServiceId = b.Id 
			inner join Provider c (nolock) on c.Id = b.ProviderId
			where PropertyType = 'Report'
			and PropertyName = 'ApproveDate'
			and c.PromoCode = ''
			group by ProviderId
		) a
	--group by a.ProviderId, a.ApprovalDate


-- Beginning of the Test
DECLARE	@return_value int,
		@pProviderPropertyId int

declare @pTime datetime

select @pTime = getutcdate()

EXEC	@return_value = [dbo].[sp_ProviderProperty_Set]
		@pProviderId = 96,
		@pPropertyType = N'Setup',
		@pPropertyName = N'Test',
		@pPropertyValue = N'Y',
		@pTime = @pTime,
		@pProviderPropertyId = @pProviderPropertyId OUTPUT

SELECT	@pProviderPropertyId as N'@pProviderPropertyId'

SELECT	'Return Value' = @return_value

select	@return_value = 0,
		@pProviderPropertyId =0


EXEC	@return_value = [dbo].[sp_ProviderProperty_Set]
		@pProviderId = 336,
		@pPropertyType = N'Setup',
		@pPropertyName = N'Test',
		@pPropertyValue = N'Y',
		@pTime = @pTime,
		@pProviderPropertyId = @pProviderPropertyId OUTPUT

SELECT	@pProviderPropertyId as N'@pProviderPropertyId'

SELECT	'Return Value' = @return_value

select	@return_value = 0 ,
		@pProviderPropertyId  = 0


EXEC	@return_value = [dbo].[sp_ProviderProperty_Set]
		@pProviderId = 344,
		@pPropertyType = N'Setup',
		@pPropertyName = N'Test',
		@pPropertyValue = N'Y',
		@pTime = @pTime,
		@pProviderPropertyId = @pProviderPropertyId OUTPUT

SELECT	@pProviderPropertyId as N'@pProviderPropertyId'

SELECT	'Return Value' = @return_value

select	@return_value = 0 ,
		@pProviderPropertyId = 0


EXEC	@return_value = [dbo].[sp_ProviderProperty_Set]
		@pProviderId = 349,
		@pPropertyType = N'Setup',
		@pPropertyName = N'Test',
		@pPropertyValue = N'Y',
		@pTime = @pTime,
		@pProviderPropertyId = @pProviderPropertyId OUTPUT

SELECT	@pProviderPropertyId as N'@pProviderPropertyId'

SELECT	'Return Value' = @return_value

select	@return_value = 0,
		@pProviderPropertyId = 0

EXEC	@return_value = [dbo].[sp_ProviderProperty_Set]
		@pProviderId = 358,
		@pPropertyType = N'Setup',
		@pPropertyName = N'Test',
		@pPropertyValue = N'Y',
		@pTime = @pTime,
		@pProviderPropertyId = @pProviderPropertyId OUTPUT

SELECT	@pProviderPropertyId as N'@pProviderPropertyId'

SELECT	'Return Value' = @return_value

select	@return_value = 0 ,
		@pProviderPropertyId = 0

EXEC	@return_value = [dbo].[sp_ProviderProperty_Set]
		@pProviderId = 388,
		@pPropertyType = N'Setup',
		@pPropertyName = N'Test',
		@pPropertyValue = N'Y',
		@pTime = @pTime,
		@pProviderPropertyId = @pProviderPropertyId OUTPUT

SELECT	@pProviderPropertyId as N'@pProviderPropertyId'

SELECT	'Return Value' = @return_value

go -- End of the Test

-- 2. Create Bill Payment Terms
I.
1.BillPayTerm
-- truncate table BillPayTerm

insert BillPayTerm (Name,
	Description,
	ProviderProductCodeId,
	BillActionTimeCodeId,
	RelatedId,
	RelatedTable,
	CurrentlyOffered,
	StartTime,
	EndTime,
	CreateDate,
	LastUpdated)
select 'HOURFEE',
	'Hourly Rate for processing Requests and Interviews based on Payment Agreement',
	1,
	1,
	null,
	null,
	1,
	'7/1/2015',
	null,
	GETUTCDATE(),
	GETUTCDATE()

select * from BillPayTerm


--sp_help BillPayTermDetail

2.BillPayTermDetail

insert BillPayTermDetail(
	BillPayTermId,
	DescTxt,
	UnitTxt,
	QuantityTxt,
	CreateDate)
select 1,
	'Service Fee for #ProductType# (#StartTime# - #EndTime#)',
	'#Rate# per Hour',
	'Minutes',
	GETUTCDATE()

select * from BillPayTermDetail


--sp_help BillProviderPayTermRate
3. BillProviderPayTermRate

insert BillProviderPayTermRate (ProviderId,
	ProviderServiceId,
	BillPayTermId,
	StartDate,
	EndDate,
	Rate,
	CreateDate,
	PMId,
	Active
)
select a.ProviderId,
	null,
	1,
	a.StartDate,
	null,
	45,
	GETUTCDATE(),
	null,
	1
from dbo.BillProviderStatement a
left join dbo.ProviderProperty b on b.ProviderId = a.ProviderId and PropertyType = N'Setup' and PropertyName = N'Test' and PropertyValue = N'Y'
where b.Id is null

insert BillProviderPayTermRate (ProviderId,
	ProviderServiceId,
	BillPayTermId,
	StartDate,
	EndDate,
	Rate,
	CreateDate,
	PMId,
	Active
)
select a.ProviderId,
	null,
	1,
	a.StartDate,
	null,
	0,
	GETUTCDATE(),
	null,
	1
from dbo.BillProviderStatement a
left join dbo.ProviderProperty b on b.ProviderId = a.ProviderId and PropertyType = N'Setup' and PropertyName = N'Test' and PropertyValue = N'Y'
where b.Id is not null



select * from BillProviderPayTermRate

sp_help BillPayTerm
II.
1.BillPayTerm
-- truncate table BillPayTerm
insert BillPayTerm (Name,
	Description,
	ProviderProductCodeId,
	BillActionTimeCodeId,
	RelatedId,
	RelatedTable,
	CurrentlyOffered,
	StartTime,
	EndTime,
	CreateDate,
	LastUpdated)
select 'MINMFEE',
	'Minimum Rate per Month for processing Requests and Interviews, based on Payment Agreement',
	1,
	2,
	null,
	null,
	1,
	'7/1/2015',
	null,
	GETUTCDATE(),
	GETUTCDATE()


select * from BillPayTerm

insert BillProviderPayTermRate (ProviderId,
	ProviderServiceId,
	BillPayTermId,
	StartDate,
	EndDate,
	Rate,
	CreateDate,
	PMId,
	Active
)
select a.ProviderId,
	null,
	2,
	a.StartDate,
	null,
	10,
	GETUTCDATE(),
	null,
	1
from dbo.BillProviderStatement a
left join dbo.ProviderProperty b on b.ProviderId = a.ProviderId and PropertyType = N'Setup' and PropertyName = N'Test' and PropertyValue = N'Y'
where b.Id is null

--sp_help BillPayTermDetail

2.BillPayTermDetail

insert BillPayTermDetail(
	BillPayTermId,
	DescTxt,
	UnitTxt,
	QuantityTxt,
	CreateDate)
select 2,
	'(Min #Rate#)',
	'N/A',
	'N/A',
	GETUTCDATE()

select * from BillPayTermDetail


--sp_help BillProviderPayTermRate

-- Insert Requests
-- b)
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
	where a1.IsCurrent = 1 and  (w.Id is not null and w.CreateDate > a1.StartDate and w.CreateDate < DATEADD (day, 30, a1.StartDate)    --and a.RequestId = 11963
	or (a.AcceptedTime > a1.StartDate and a.AcceptedTime < DATEADD (day, 30, a1.StartDate) )) --and a.RequestId = 11963
	) as a
	where a.AcceptedTime is not null
	order by ProviderId, RequestId  --511



	select * from [BillProviderTransactionRequest] where ServiceSeconds = 0

	select * from RequestProvider where RequestId = 12333
	349

	-- BillProviderTransaction

	sp_help BillProviderTransaction


	insert BillProviderTransaction
	(	ProviderId,
		ProviderBillingTypeCodeId,
		BillProviderPayTermRateId,
		Quantity,
		UnitValue,
		TotalValue,
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
			
--select * from BillProviderTransaction

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



-- calculate the Term 2
insert BillProviderTransaction
	(ProviderId,
	ProviderBillingTypeCodeId,
	BillProviderPayTermRateId,
	Quantity,
	UnitValue,
	TotalValue,
	SourceTableId,
	SourceTable,
	CreateDate)

select 
	a.ProviderId,
	1,
	a.BillProviderPayTermRateId,
	1,
	Rate,
	AdjustValue,
	null,
	null,
	GETUTCDATE()
from  ( select a.ProviderId,
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
		where a.IsCurrent = 1 and (c.AdjustValue is null or c.AdjustValue < b.Rate) and DATEADD(day, 30, a.StartDate) < GETUTCDATE()
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
left join [BillProviderStatementTransaction] c on c.BillProviderStatementId = a.Id and c.BillProviderTransactionId = b.Id
where c.Id is null 
and b.ProviderBillingTypeCodeId = 2
and a.IsCurrent = 1


-- Generate Statement

update c
set EndDate = DATEADD(day, 30, StartDate),
	StatementDate = DATEADD(day, 30, StartDate),
	IsCurrent = 0,
	Approved = case when DATEADD(day, 30, StartDate) < dateadd(day, -15, GETUTCDATE()) then 1 else 0 end
-- select *, case when DATEADD(day, 30, StartDate) < dateadd(day, -15, GETUTCDATE()) then 1 else 0 end
from BillProviderStatement c
where DATEADD(day, 30, StartDate) < GETUTCDATE()
and IsCurrent = 1


-- new statement
insert BillProviderStatement (ProviderId,
	StatementDate,
	StartDate,
	EndDate,
	PayableAmount,
	PaidAmount,
	IsCurrent,
	Approved,
	CreateDate)
select a.ProviderId,
	null,
	isnull(b.EndDate, max(a.ApprovalDate)),
	null,
	isnull(max(isnull(b.Payable,0)), 0),
	0,
	1,
	1,
	GETUTCDATE()
from 
	(select ProviderId, min(convert(datetime, a.PropertyValue)) as ApprovalDate
			from ProviderServiceProperty a (nolock)
			inner join ProviderService b (nolock) on a.ProviderServiceId = b.Id 
			inner join Provider c (nolock) on c.Id = b.ProviderId
			where PropertyType = 'Report'
			and PropertyName = 'ApproveDate'
			and c.PromoCode = ''
			group by ProviderId
		) a
	left join (select max(a.Id) as StatementId, a.ProviderId, dateadd(day, 30, max(StartDate)) as EndDate, sum(c.TotalValue) as Payable
				from BillProviderStatement a
				left join BillProviderStatementTransaction b on b.BillProviderStatementId = a.Id
				left join BillProviderTransaction c on c.Id = b.BillProviderTransactionId
				group by a.ProviderId) b on b.ProviderId = a.ProviderId
	group by a.ProviderId, b.EndDate--,  b.StatementId
	having isnull(b.EndDate, dateadd(day, -1, getutcdate())) < GETUTCDATE()


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
	where a1.IsCurrent =1 and  (w.Id is not null and w.CreateDate > a1.StartDate and  w.CreateDate < DATEADD (day, 60, a1.StartDate)  --and a.RequestId = 11963
	or (a.AcceptedTime > a1.StartDate and a.AcceptedTime < DATEADD (day, 60, a1.StartDate) )) --and a.RequestId = 11963
	) a
	left join [BillProviderTransactionRequest] z on z.RequestId = a.RequestId
	where a.AcceptedTime is not null
	and z.Id is null
	order by ProviderId, RequestId  --511

select * from [BillProviderTransactionRequest]





	insert BillProviderTransaction
	(	ProviderId,
		ProviderBillingTypeCodeId,
		BillProviderPayTermRateId,
		Quantity,
		UnitValue,
		TotalValue,
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
			
--select * from BillProviderTransaction

--select * from  --delete [BillProviderStatementTransaction] where Id >= 565

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

-- calculate the adjustment based on Term 2
insert BillProviderTransaction
	(ProviderId,
	ProviderBillingTypeCodeId,
	BillProviderPayTermRateId,
	Quantity,
	UnitValue,
	TotalValue,
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
	null,
	null,
	GETUTCDATE()
from  ( select a.ProviderId,
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
and b.ProviderBillingTypeCodeId = 2
and a.IsCurrent = 1

-----------------------------------------------------------------------------------------------------------------------
-- new statement
update c
set EndDate = DATEADD(day, 30, StartDate),
	StatementDate = DATEADD(day, 30, StartDate),
	IsCurrent = 0,
	Approved = case when DATEADD(day, 30, StartDate) < dateadd(day, -15, GETUTCDATE()) then 1 else 0 end
-- select *, case when DATEADD(day, 30, StartDate) < dateadd(day, -15, GETUTCDATE()) then 1 else 0 end
from BillProviderStatement c
where DATEADD(day, 30, StartDate) < GETUTCDATE()
and IsCurrent = 1


insert BillProviderStatement (ProviderId,
	StatementDate,
	StartDate,
	EndDate,
	PayableAmount,
	PaidAmount,
	IsCurrent,
	Approved,
	CreateDate)
select a.ProviderId,
	null,
	isnull(b.EndDate, max(a.ApprovalDate)),
	null,
	isnull(max(isnull(b.Payable,0)), 0),
	0,
	1,
	1,
	GETUTCDATE()
from 
	(select ProviderId, min(convert(datetime, a.PropertyValue)) as ApprovalDate
			from ProviderServiceProperty a (nolock)
			inner join ProviderService b (nolock) on a.ProviderServiceId = b.Id 
			inner join Provider c (nolock) on c.Id = b.ProviderId
			where PropertyType = 'Report'
			and PropertyName = 'ApproveDate'
			and c.PromoCode = ''
			group by ProviderId
		) a
	left join (select max(a.Id) as StatementId, a.ProviderId, dateadd(day, 30, max(StartDate)) as EndDate, sum(c.TotalValue) as Payable
				from BillProviderStatement a
				left join BillProviderStatementTransaction b on b.BillProviderStatementId = a.Id
				left join BillProviderTransaction c on c.Id = b.BillProviderTransactionId
				group by a.ProviderId) b on b.ProviderId = a.ProviderId
	group by a.ProviderId, b.EndDate--,  b.StatementId
	having isnull(b.EndDate, dateadd(day, -1, getutcdate())) < GETUTCDATE()
-- Next Statement
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
	where a1.IsCurrent =1 and (w.Id is not null and w.CreateDate > a1.StartDate and  w.CreateDate < DATEADD (day, 90, a1.StartDate)  --and a.RequestId = 11963
	or (a.AcceptedTime > a1.StartDate and a.AcceptedTime < DATEADD (day, 90, a1.StartDate) )) --and a.RequestId = 11963
	) a
	left join [BillProviderTransactionRequest] z on z.RequestId = a.RequestId
	where a.AcceptedTime is not null
	and z.Id is null
	order by ProviderId, RequestId  --511

--select * from [BillProviderTransactionRequest]



	insert BillProviderTransaction
	(	ProviderId,
		ProviderBillingTypeCodeId,
		BillProviderPayTermRateId,
		Quantity,
		UnitValue,
		TotalValue,
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
			
--select * from BillProviderTransaction

--select * from  --delete [BillProviderStatementTransaction] where Id >= 565

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

-- calculate the adjustment based on Term 2
insert BillProviderTransaction
	(ProviderId,
	ProviderBillingTypeCodeId,
	BillProviderPayTermRateId,
	Quantity,
	UnitValue,
	TotalValue,
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
	null,
	null,
	GETUTCDATE()
from  ( select a.ProviderId,
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
and b.ProviderBillingTypeCodeId = 2
and a.IsCurrent = 1




--************************************************************************************
-----------------------------------------------------------------------------------------------------------------------
--- New Statement 
update c
set EndDate = DATEADD(day, 30, StartDate),
	StatementDate = DATEADD(day, 30, StartDate),
	IsCurrent = 0,
	Approved = case when DATEADD(day, 30, StartDate) < dateadd(day, -15, GETUTCDATE()) then 1 else 0 end
-- select *, case when DATEADD(day, 30, StartDate) < dateadd(day, -15, GETUTCDATE()) then 1 else 0 end
from BillProviderStatement c
where DATEADD(day, 30, StartDate) < GETUTCDATE()
and IsCurrent = 1


insert BillProviderStatement (ProviderId,
	StatementDate,
	StartDate,
	EndDate,
	PayableAmount,
	PaidAmount,
	IsCurrent,
	Approved,
	CreateDate)
select a.ProviderId,
	null,
	isnull(b.EndDate, max(a.ApprovalDate)),
	null,
	isnull(max(isnull(b.Payable,0)), 0),
	0,
	1,
	1,
	GETUTCDATE()
from 
	(select ProviderId, min(convert(datetime, a.PropertyValue)) as ApprovalDate
			from ProviderServiceProperty a (nolock)
			inner join ProviderService b (nolock) on a.ProviderServiceId = b.Id 
			inner join Provider c (nolock) on c.Id = b.ProviderId
			where PropertyType = 'Report'
			and PropertyName = 'ApproveDate'
			and c.PromoCode = ''
			group by ProviderId
		) a
	left join (select max(a.Id) as StatementId, a.ProviderId, dateadd(day, 30, max(StartDate)) as EndDate, sum(c.TotalValue) as Payable
				from BillProviderStatement a
				left join BillProviderStatementTransaction b on b.BillProviderStatementId = a.Id
				left join BillProviderTransaction c on c.Id = b.BillProviderTransactionId
				group by a.ProviderId) b on b.ProviderId = a.ProviderId
	group by a.ProviderId, b.EndDate--,  b.StatementId
	having isnull(b.EndDate, dateadd(day, -1, getutcdate())) < GETUTCDATE()


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
	where a1.IsCurrent =1 and (w.Id is not null and w.CreateDate > a1.StartDate and  w.CreateDate < DATEADD (day, 120, a1.StartDate)  --and a.RequestId = 11963
	or (a.AcceptedTime > a1.StartDate and a.AcceptedTime < DATEADD (day, 120, a1.StartDate) )) --and a.RequestId = 11963
	) a
	left join [BillProviderTransactionRequest] z on z.RequestId = a.RequestId
	where a.AcceptedTime is not null
	and z.Id is null
	order by ProviderId, RequestId  --511