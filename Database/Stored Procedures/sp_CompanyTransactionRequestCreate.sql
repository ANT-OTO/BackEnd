IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CompanyTransactionRequestCreate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CompanyTransactionRequestCreate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CompanyTransactionRequestCreate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CompanyTransactionRequestCreate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CompanyTransactionRequestCreate] 
	@pCompanyTransactionRequestId int output,
	@pSourceCompanyId int,
	@pHandlerCompanyId int,
	@pAmount decimal(10, 2),
	@pCurrencyId int,
	@pDescription nvarchar(256),
	@pUserId int,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	if(not exists(
		select *
		from CompanyLogisticCompany a (nolock)
		where a.CompanyId = @pHandlerCompanyId
		and a.CustomerCompanyId = @pSourceCompanyId
		and a.Available = 1
	)
	and not exists(
		select *
		from CompanyLogisticCompany a (nolock)
		where a.CompanyId = @pSourceCompanyId
	))
	begin
		return
	end

	insert into [dbo].[CompanyTransactionRequest]
	(
		[SourceCompanyId],
		[TargetCompanyId],
		[Amount],
		[CurrencyId],
		[CompanyTransactionRequestStatusCodeId], --select * from CodeList where Category = 'CompanyTransactionRequestStatus'
		[UserId],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	@pSourceCompanyId, @pHandlerCompanyId, @pAmount,
			@pCurrencyId, 1, @pUserId, @pTime, @pTime, @pLastUpdateBy, @pLastUpdateByType

	
	select @pCompanyTransactionRequestId = SCOPE_IDENTITY()



	


return

/*

*/



GO


