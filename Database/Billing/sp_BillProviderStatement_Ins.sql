IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_BillProviderStatement_Ins]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_BillProviderStatement_Ins] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_BillProviderStatement_Ins] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_BillProviderStatement_Ins] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER  procedure [dbo].[sp_BillProviderStatement_Ins] 
	@pProviderId int
AS
set nocount on
begin
	if isnull(@pProviderId, 0 )= 0
	begin
		return 0
	end

	-- 1. Get Current Statement
	declare @CurStatementId int = 0,
			@NewStatementId int = 0

	select @CurStatementId = max(Id)
	from dbo.BillProviderStatement (nolock)
	where ProviderId = @pProviderId
	and IsCurrent = 1

	-- 2. Set the old Statement to old
	if isnull(@CurStatementId , 0) > 0
	begin
		update dbo.BillProviderStatement
		set EndDate = dateadd(day, 30, StartDate),
			StatementDate = dateadd(day, 30, StartDate),
			IsCurrent = 0
		where Id = @CurStatementId

		-- 3. create a new Statement
		declare @NewStartTime datetime
		select @NewStartTime = EndDate
		from dbo.BillProviderStatement (nolock) a
		where a.Id = @CurStatementId

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
			@NewStartTime,
			null,
			0,
			0,
			1,
			0,
			getutcdate()

		select @NewStatementId = scope_identity()


		update b
		set b.BillProviderStatementId = @NewStatementId
		from dbo.BillProviderStatement (nolock) a
		join dbo.BillProviderStatementTransaction (nolock) b on b.BillProviderStatementId = a.Id
		join BillProviderTransaction (nolock) c on c.Id = b.BillProviderTransactionId
		left join BillProviderTransactionRequest z (nolock) on c.SourceTable = 'BillProviderTransactionRequest' and  z.Id = c.SourceTableId
		where a.Id = @CurStatementId
		and (case when z.Id is null then c.CreateDate else  DATEADD(second, z.ServiceSeconds, z.AcceptedTime) end) >= a.StartDate

		-- Create on Statement ProviderTransactions
		-- MINMFEE = BillPayTermId = 2

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
			2,
			b.Id, --a.BillProviderPayTermRateId,
			1,
			b.Rate,
			case when c.TotalValue is null then b.Rate when c.TotalValue < b.Rate then b.Rate - c.TotalValue else 0 end, --AdjustValue,
			null,
			null,
			GETUTCDATE()
		from BillProviderStatement a
			join BillProviderPayTermRate b on b.ProviderId = a.ProviderId and b.BillPayTermId = 2
			left join (select a.BillProviderStatementId,
						sum (b.TotalValue) as TotalValue, b.ProviderId
						from BillProviderStatementTransaction a
						join BillProviderTransaction b on b.Id = a.BillProviderTransactionId
						join BillProviderPayTermRate c on c.Id = b.BillProviderPayTermRateId and c.BillPayTermId = 1
						where a.BillProviderStatementId = @CurStatementId
						group by a.BillProviderStatementId, b.ProviderId) c on c.BillProviderStatementId = a.Id
			where c.TotalValue is null or c.TotalValue < b.Rate
			and a.Id = @CurStatementId


		insert [BillProviderStatementTransaction](
			[BillProviderStatementId],
			[BillProviderTransactionId],
			[CreateDate])
		select @CurStatementId,
			a.Id as [BillProviderTransactionId],
			GETUTCDATE()
		from BillProviderTransaction a
		left join [BillProviderStatementTransaction] b on b.BillProviderTransactionId = a.Id
		where a.ProviderId = @pProviderId
		and a.ProviderBillingTypeCodeId = 2
		and b.Id is null 


		update BillProviderStatement
		set PayableAmount = a.PayableAmount,
			PaidAmount = a.PaidAmount
		from (select  
				sum (case when a.ProviderBillingTypeCodeId in (1, 2) then a.TotalValue else 0 end) as PayableAmount, 
				sum (case when a.ProviderBillingTypeCodeId in (3) then a.TotalValue else 0 end) as PaidAmount
				from BillProviderTransaction (nolock) a
				join dbo.BillProviderStatementTransaction (nolock) b on b.BillProviderTransactionId = a.Id
				where b.BillProviderStatementId = @CurStatementId
			) a
		where Id = @NewStatementId

	end
	else -- no previous statement
	begin
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
			getutcdate()
		from (select min (cast(b.PropertyValue as datetime)) as ApprovalDate
			from dbo.ProviderService a (nolock)
			join dbo.ProviderServiceProperty b (nolock) on b.ProviderServiceId = a.Id and b.PropertyType = 'Report' and b.PropertyName = 'ApproveDate'
			where a.ProviderId = @pProviderId) a

		select @NewStatementId = scope_identity()
	end
	return @NewStatementId
end