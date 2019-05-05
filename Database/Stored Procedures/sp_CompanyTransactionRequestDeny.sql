IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CompanyTransactionRequestDeny]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CompanyTransactionRequestDeny] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CompanyTransactionRequestDeny] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CompanyTransactionRequestDeny] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CompanyTransactionRequestDeny] 
	@pCompanyTransactionRequestId int output,
	@pUserId int,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	update a
	set a.[CompanyTransactionRequestStatusCodeId] = 4,--select * from CodeList where Category = 'CompanyTransactionRequestStatus'
		a.UserId = @pUserId,
		a.LastUpdate = @pTime,
		a.LastUpdateBy = @pLastUpdateBy,
		a.LastUpdateByType = @pLastUpdateByType
	from CompanyTransactionRequest a
	where a.Id = @pCompanyTransactionRequestId
	and a.CompanyTransactionRequestStatusCodeId in (1, 2)



return

/*

*/



GO


