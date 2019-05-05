IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemOnSaleBulletPointUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemOnSaleBulletPointUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemOnSaleBulletPointUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemOnSaleBulletPointUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemOnSaleBulletPointUpdate] 
	@pItemOnSaleId int,
	@pBulletPoint nvarchar(256),
	@pOrder int,
	@pUserId int,
	@pItemOnSaleDetailId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	select @pItemOnSaleDetailId = 0

	insert into ItemOnSaleDetail
	(
		[ItemOnSaleId],
		[BulletPoint],
		[Order],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	@pItemOnSaleId,
			@pBulletPoint,
			@pOrder,
			1,
			@pTime,
			@pTime,
			@pUserId,
			1
	select @pItemOnSaleDetailId = SCOPE_IDENTITY()

/*

*/



GO


