IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CompanyTransactionRequestApprove]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CompanyTransactionRequestApprove] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CompanyTransactionRequestApprove] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CompanyTransactionRequestApprove] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CompanyTransactionRequestApprove] 
	@pCompanyTransactionRequestId int output,
	@pUserId int,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	declare @pSourceCompanyId int = 0
	declare @pHandlerCompanyId int = 0
	declare @pAmount decimal(10,2) = 0.0
	declare @pCurrencyId int = 0
	select	@pSourceCompanyId = a.SourceCompanyId,
			@pHandlerCompanyId = a.TargetCompanyId,
			@pAmount = a.Amount,
			@pCurrencyId = a.CurrencyId
	from CompanyTransactionRequest a (nolock)
	where a.Id = @pCompanyTransactionRequestId

	--check
	if(not exists(
		select *
		from CompanyUser a (nolock)
		where a.CompanyId = @pHandlerCompanyId
		and a.UserId = @pUserId
		and a.Available = 1
	))
	begin
		select @pCompanyTransactionRequestId = 0
		return
	end
	
	declare @pDescription nvarchar(256) = ''
	select @pDescription = N'客户充值$' + convert(nvarchar(256), @pAmount)
	--SourceCompany

	exec [dbo].[sp_CompanyTransactionInsert] 
		@pSourceCompanyId,
		2,
		@pAmount,
		@pCurrencyId,
		@pCompanyTransactionRequestId,
		'CompanyTransactionRequest',
		@pDescription,
		@pUserId,
		@pLastUpdateBy,
		@pLastUpdateByType

	--HandlerCompany
	if(isnull(@pHandlerCompanyId, 0) > 0)
	begin
		exec [dbo].[sp_CompanyTransactionInsert] 
		@pHandlerCompanyId,
		1,
		@pAmount,
		@pCurrencyId,
		@pCompanyTransactionRequestId,
		'CompanyTransactionRequest',
		@pDescription,
		@pUserId,
		@pLastUpdateBy,
		@pLastUpdateByType
	end
	
	update a
	set a.[CompanyTransactionRequestStatusCodeId] = 3,--select * from CodeList where Category = 'CompanyTransactionRequestStatus'
		a.UserId = @pUserId,
		a.LastUpdate = @pTime,
		a.LastUpdateBy = @pLastUpdateBy,
		a.LastUpdateByType = @pLastUpdateByType
	from CompanyTransactionRequest a
	where a.Id = @pCompanyTransactionRequestId



return

/*

*/



GO


