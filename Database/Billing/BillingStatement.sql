IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Interview_Cancel]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Interview_Cancel] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Interview_Cancel] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Interview_Cancel] ... ' + convert(varchar, getdate())

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
	declare @CurStatementId int = 0

	select @CurStatementId = max(Id)
	from dbo.BillProviderStatement (nolock)
	where ProviderId = @pProviderId

	-- 2. Set the old Statement to old
	if isnull(@CurStatementId , 0) = 0
	begin
		update dbo.BillProviderStatement
		set EndDate = dateadd(day, 30, StartDate),
			StatementDate = dateadd(day, 30, StartDate),
			IsCurrent = 0
		where Id = @CurStatementId

		-- 3. create a new Statement
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
			a.EndDate,
			null,
			sum(c.TotalValue),
			0,
			1,
			0,
			GETUTCDATE()
		from dbo.BillProviderStatement (nolock) a
			join dbo.BillProviderStatementTransaction (nolock) b on b.BillProviderStatementId = a.Id
			join BillProviderTransaction (nolock) c on c.Id = b.BillProviderTransactionId
		where a.Id = @CurStatementId
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
			GETUTCDATE()
		from (select min (cast(b.PropertyValue as datetime)) as ApprovalDate
			from dbo.ProviderService a (nolock)
			join dbo.ProviderServiceProperty b (nolock) on b.ProviderServiceId = a.Id and b.PropertyType = 'Report' and b.PropertyName = 'ApproveDate'
			where a.ProviderId = @pProviderId) a
	end
	return @CurStatementId
end