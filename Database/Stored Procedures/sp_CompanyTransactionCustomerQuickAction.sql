IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CompanyTransactionCustomerQuickAction]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CompanyTransactionCustomerQuickAction] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CompanyTransactionCustomerQuickAction] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CompanyTransactionCustomerQuickAction] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CompanyTransactionCustomerQuickAction] 
	@pSourceCompanyId int,
	@pHandlerCompanyId int, 
	@pAmount decimal(10,2),
	@pCurrencyId int,
	@pDescription nvarchar(256),
	@pTransactionTypeCodeId int,
	@pUserId int,
	@pLastUpdateBy int,
	@pLastUpdateByType int,
	@pCompanyTransactionId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	--check
	if(not exists(
		select *
		from CompanyUser a (nolock)
		where a.CompanyId = @pHandlerCompanyId
		and a.UserId = @pUserId
		and a.Available = 1
	))
	begin
		select @pCompanyTransactionId = 0
		return
	end

	if(isnull(@pTransactionTypeCodeId, 0) not in (1, 2))
	begin
		select @pCompanyTransactionId = 0
		return
	end
	
	--SourceCompany
	declare @pSourceTransactionTypeCodeId int = case when @pTransactionTypeCodeId = 1 then 1 else 2 end
	declare @pHandlerTransactionTypeCodeId int = case when @pTransactionTypeCodeId = 1 then 2 else 1 end
	exec [dbo].[sp_CompanyTransactionInsert] 
		@pSourceCompanyId,
		@pSourceTransactionTypeCodeId,
		@pAmount,
		@pCurrencyId,
		@pHandlerCompanyId,
		'Company',
		@pDescription,
		@pUserId,
		@pLastUpdateBy,
		@pLastUpdateByType
	exec [dbo].[sp_CompanyTransactionInsert] 
		@pHandlerCompanyId,
		@pHandlerTransactionTypeCodeId,
		@pAmount,
		@pCurrencyId,
		@pSourceCompanyId,
		'Company',
		@pDescription,
		@pUserId,
		@pLastUpdateBy,
		@pLastUpdateByType
	

	select @pCompanyTransactionId = 1

return

/*

*/



GO


