IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemPurchaseTaskResourceUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemPurchaseTaskResourceUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemPurchaseTaskResourceUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemPurchaseTaskResourceUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemPurchaseTaskResourceUpdate] 
	@pItemPurchaseTaskId int,
	@pFileId int,
	@pResourceTypeCodeId int,
	@pOrder int,
	@pDescription nvarchar(256),
	@pDescription_2 nvarchar(256),
	@pUserId int,
	@pItemPurchaseTaskResourceId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	select @pItemPurchaseTaskResourceId = 0

	insert into [ItemPurchaseTaskResource]
	(
		[ItemPurchaseTaskId],
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
	select	@pItemPurchaseTaskId,
			@pResourceTypeCodeId,
			@pFileId,
			@pDescription,
			@pDescription_2,
			1,
			@pTime,
			@pTime,
			@pUserId,
			1

	select @pItemPurchaseTaskResourceId = SCOPE_IDENTITY()

/*

*/



GO


