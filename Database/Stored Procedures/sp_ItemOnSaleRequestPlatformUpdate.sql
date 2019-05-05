IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemOnSaleRequestPlatformUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemOnSaleRequestPlatformUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemOnSaleRequestPlatformUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemOnSaleRequestPlatformUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemOnSaleRequestPlatformUpdate] 
	@pPlatformName nvarchar(256),
	@pUserId int,
	@pAvailable bit,
	@pItemOnSaleRequestPlatformInfoId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	update a
	set a.LastUpdate = @pTime,
		a.LastUpdateBy = @pUserId,
		a.LastUpdateByType = 1,
		a.PlatformName = @pPlatformName
	from ItemOnSaleRequestPlatformInfo a
	where a.Id = @pItemOnSaleRequestPlatformInfoId



return

/*

*/



GO


