IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemOnSaleBulletPointClear]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemOnSaleBulletPointClear] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemOnSaleBulletPointClear] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemOnSaleBulletPointClear] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemOnSaleBulletPointClear] 
	@pItemOnSaleId int,
	@pUserId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	update a
	set a.Available = 0,
		a.LastUpdate = @pTime,
		a.LastUpdateBy = @pUserId,
		a.LastUpdateByType = 1
	from ItemOnSaleDetail a
	where a.ItemOnSaleId = @pItemOnSaleId
	and a.Available = 1

/*

*/



GO


