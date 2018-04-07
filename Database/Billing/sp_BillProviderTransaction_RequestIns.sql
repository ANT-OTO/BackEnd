IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_BillProviderTransaction_RequestIns]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_BillProviderTransaction_RequestIns] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_BillProviderTransaction_RequestIns] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_BillProviderTransaction_RequestIns] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER  procedure [dbo].[sp_BillProviderTransaction_RequestIns] 
	@pProviderId int,
	@pRequestId int
AS
set nocount on
begin
	if isnull(@pProviderId, 0 )= 0 or isnull(@pRequestId, 0 )= 0 
	begin
		return 0
	end

	declare @ProviderProductCodeId int = 1, @ProviderBillingTypeCodeId int = 1

	/*if exists (select * from dbo.ProviderProperty (nolock)
				where ProviderId = @pProviderId
				and PropertyType = N'Setup'
				and PropertyName = N'Test'
				and PropertyValue = N'Y')
	*/

	declare @ProviderServiceId int = 0
	declare @TestRequest bit = 0
	declare @BillProviderTransactionRequestId int = 0

	select @ProviderServiceId = b.Id,
			@TestRequest = case when z.Id is null then 0 else 1 end
	from dbo.RequestProvider a (nolock)
	inner join ProviderService b (nolock) on a.ProviderServiceId = b.Id
	left join ProviderServiceProperty z (nolock) on z.ProviderServiceId = a.ProviderServiceId
											and PropertyType = 'Report'
											and PropertyName = 'ApproveDate'
											and a.AcceptedTime > cast(PropertyValue as datetime)
	where a.RequestId = @pRequestId
	and a.ProviderId = @pProviderId


	-- Get Request Details
	insert [BillProviderTransactionRequest] (
		ProviderId,
		RequestId,
		PersonId,
		ServiceSeconds,
		AcceptedTime,
		OffsetTime,
		CreateDate
	)
	select @pProviderId,
			@pRequestId,
			a.PersonId,
			isnull(case
					when EndTime = '1/1/2000' then 60 
					when RequestStatusCodeId in (5, 6) and StartTime = EndTime then 60
					when RequestStatusCodeId <> 3 then datediff(second, StartTime, EndTime) else RequestLogTime end /*as ServiceSeconds*/,60),
			a.AcceptedTime,
			null,
			GETUTCDATE()
	from (
		select b.RequestStatusCodeId,
			datediff(second, b.CreateDate, b.LastUpdate) as RequestLogTime, 
			case
				when isnull(y.StartTime, GETUTCDATE()) <= isnull(x.StartDate, GETUTCDATE()) then isnull(y.StartTime, GETUTCDATE())
				else isnull(x.StartDate, GETUTCDATE())
			end as StartTime,
			case
				when isnull(y.FinishTime, '1/1/2000') >= isnull(x.FinishDate, '1/1/2000') then isnull(y.FinishTime, '1/1/2000')
				else isnull(x.FinishDate, '1/1/2000')
			end as EndTime,
			a.AcceptedTime,
			b.Id as RequestId,
			a.Id as RequestProviderId,
			a.ProviderId,
			c.Id as PersonId
		from Request b
			inner join RequestProvider a on a.RequestId = b.Id
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
		where b.Id = 16163 --@pRequestId
		and a.Id = 21446 --@ProviderServiceId
	) a
/*		 
		(w.Id is not null and w.CreateDate > d.ApprovalDate and w.CreateDate < case when DATEADD (day, 60, d.ApprovalDate) <= getutcdate() then DATEADD (day, 60, d.ApprovalDate) else DATEADD (day, 30, d.ApprovalDate) end) --and a.RequestId = 11963
		or (a.AcceptedTime > d.ApprovalDate and a.AcceptedTime < case when DATEADD (day, 60, d.ApprovalDate) <= getutcdate() then DATEADD (day, 60, d.ApprovalDate) else DATEADD (day, 30, d.ApprovalDate) end) --and a.RequestId = 11963
*/

	select @BillProviderTransactionRequestId = SCOPE_IDENTITY()


	-- Get Current Pay Term for the Request and Create Transaction
	if @TestRequest = 1
	begin
		insert BillProviderTransaction(
			ProviderId,
			ProviderBillingTypeCodeId,
			BillProviderPayTermRateId,
			Quantity,
			UnitValue,
			TotalValue,
			SourceTableId,
			SourceTable,
			CreateDate)
		select 
			@pProviderId,
			@ProviderBillingTypeCodeId,
			null,
			a.ServiceSeconds/60 + case when  (a.ServiceSeconds/60.0 - a.ServiceSeconds/60) > 0 then 1 else 0 end, --ServiceMinutes,
			0,
			0,
			a.Id,
			'BillProviderTransactionRequest',
			GETUTCDATE()
		from  BillProviderTransactionRequest a
		where Id = @BillProviderTransactionRequestId
	end
	else
	begin
		insert BillProviderTransaction(
			ProviderId,
			ProviderBillingTypeCodeId,
			BillProviderPayTermRateId,
			Quantity,
			UnitValue,
			TotalValue,
			SourceTableId,
			SourceTable,
			CreateDate)
		select 
			@pProviderId,
			@ProviderBillingTypeCodeId,
			a.BillProviderPayTermRateId,
			a.ServiceMinutes, --ServiceMinutes,
			a.Rate/60.0,
			round(a.ServiceMinutes*(a.Rate/60.0), 2),
			a.BillProviderTransactionRequest,
			'BillProviderTransactionRequest',
			GETUTCDATE()
		from (
			select a.ServiceSeconds/60 + case when  (a.ServiceSeconds/60.0 - a.ServiceSeconds/60) > 0 then 1 else 0 end as ServiceMinutes,
					b.Rate as Rate,
					a.Id as BillProviderTransactionRequest,
					b.Id as BillProviderPayTermRateId
			from  BillProviderTransactionRequest a
			cross apply [dbo].[tfnBillProviderPayTermRate](@pProviderId,
				1,
				1,
				@ProviderServiceId,
				null,
				 1) b
			where a.Id = @BillProviderTransactionRequestId
		) a
	end

	-- Get Statement Id or create new one
	declare @CurStatementId int = 0

	select @CurStatementId = max(Id)
	from dbo.BillProviderStatement (nolock)
	where ProviderId = @pProviderId
	and IsCurrent = 1

	if isnull(@CurStatementId , 0) = 0
	begin
		-- No Current Statement
		insert BillProviderStatement (ProviderId,
			StatementDate,
			StartDate,
			EndDate,
			PayableAmount,
			PaidAmount,
			IsCurrent,
			Approved,
			CreateDate)
		select @pProviderId,
			null,
			a.ApprovalDate,
			null,
			0,
			0,
			1,
			0,
			GETUTCDATE()
		from (select min (cast(b.PropertyValue as datetime)) as ApprovalDate
			from dbo.ProviderService a (nolock)
			join dbo.ProviderServiceProperty b (nolock) on b.ProviderServiceId = a.Id and b.PropertyType = 'Report' and b.PropertyName = 'ApproveDate'
			where a.ProviderId = @pProviderId) a


		select @CurStatementId = SCOPE_IDENTITY()		
	end

	-- Add Transaction to the Statement
	insert [BillProviderStatementTransaction](
		[BillProviderStatementId],
		[BillProviderTransactionId],
		[CreateDate])
	select @CurStatementId,
		a.Id as [BillProviderTransactionId],
		GETUTCDATE()
	from BillProviderTransaction a
	where a.ProviderId = @pProviderId
	and a.SourceTableId = @BillProviderTransactionRequestId
	and SourceTable = 'BillProviderTransactionRequest'	
end