IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemPackageResourceInsert]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemPackageResourceInsert] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemPackageResourceInsert] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemPackageResourceInsert] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemPackageResourceInsert] 
	@pSourceId int,
	@pSourceTable nvarchar(64),
	@pFileId int,
	@pResourceTypeCodeId int,
	@pDescription nvarchar(max),
	@pUserId int,
	@pItemPackageResourceId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	insert into [dbo].[ItemPackageResouce]
	(
		[SourceId],
		[SourceTable],
		[ResourceTypeCodeId], --image, video
		[FileId],
		[Description_1],
		[Description_2],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	@pSourceId, @pSourceTable, @pResourceTypeCodeId, @pFileId, @pDescription, '',
			1, @pTime, @pTime, @pUserId, 1
	select @pItemPackageResourceId = SCOPE_IDENTITY()


return

/*

*/



GO


