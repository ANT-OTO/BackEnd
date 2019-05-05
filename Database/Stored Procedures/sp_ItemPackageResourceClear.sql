IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemPackageResourceClear]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemPackageResourceClear] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemPackageResourceClear] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemPackageResourceClear] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemPackageResourceClear] 
	@pSourceId int,
	@pSourceTable nvarchar(64),
	@pUserId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	update a
	set a.Available = 0,
		a.LastUpdate = @pTime,
		a.LastUpdateBy = @pUserId,
		a.LastUpdateByType = 1
	from ItemPackageResouce a 
	where a.SourceId = @pSourceId
	and a.SourceTable = @pSourceTable
	


return

/*

*/



GO


