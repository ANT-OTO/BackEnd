IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemOnSaleResourceUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemOnSaleResourceUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemOnSaleResourceUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemOnSaleResourceUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemOnSaleResourceUpdate] 
	@pItemOnSaleId int,
	@pResourceTypeCodeId int,
	@pFileId int,
	@pIsMain bit,
	@pOrder int,
	@pDescription nvarchar(256),
	@pDescription_2 nvarchar(256),
	@pUserId int,
	@pItemOnSaleDetailId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	select @pItemOnSaleDetailId = 0

	insert into ItemOnSaleResource
	(
		[ItemOnSaleId],
		[ResourceTypeCodeId], --image, video
		[FileId],
		[isMain],
		[Order],
		[Description_1],
		[Description_2],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	@pItemOnSaleId,
			@pResourceTypeCodeId,
			@pFileId,
			@pIsMain,
			@pOrder,
			@pDescription,
			@pDescription_2,
			1,
			@pTime,
			@pTime,
			@pUserId,
			1
	select @pItemOnSaleDetailId = SCOPE_IDENTITY()

/*

*/



GO


