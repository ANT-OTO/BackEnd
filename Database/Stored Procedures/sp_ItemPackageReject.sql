IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemPackageReject]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemPackageReject] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemPackageReject] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemPackageReject] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemPackageReject] 
	@pItemSubmitPackageId int output,
	@pCompanyId int,
	@pUserId int,
	@pItemUpdatePackageId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	update a
	set a.ItemPackageStatusCodeId = 98, --select * from CodeList where Category = 'ItemPackageStatus'
		a.LastUpdateBy = @pUserId
	from ItemSubmitPackage a 
	where a.Id = @pItemSubmitPackageId
	and a.CompanyId = @pCompanyId
	if(@@ROWCOUNT > 0)
	BEGIN
		select @pItemSubmitPackageId = 0 
	END

	update a
	set a.ItemPackageStatusCodeId = 98, --select * from CodeList where Category = 'ItemPackageStatus'
		a.LastUpdateBy = @pUserId
	from ItemUpdatePackage a 
	where a.Id = @pItemUpdatePackageId
	and a.CompanyId = @pCompanyId

	if(@@ROWCOUNT > 0)
	BEGIN
		select @pItemUpdatePackageId = 0
	END

return

/*

*/



GO


