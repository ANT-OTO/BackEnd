IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PurchasePoolTaskChange]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_PurchasePoolTaskChange] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_PurchasePoolTaskChange] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_PurchasePoolTaskChange] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_PurchasePoolTaskChange] 
	@pItemId int,
	@pQuantity int,
	@pUserId int,
	@pItemPurchaseTaskId int output
AS

SET NOCOUNT ON
	if(isnull(@pQuantity, 0) <= 0)
	begin
		select @pItemPurchaseTaskId = 0
		return
	end
	declare @pTime datetime = getutcdate()
	if(exists(
		select *
		from ItemPurchaseTask a (nolock)
		where a.Id = @pItemPurchaseTaskId
		and a.ItemPurchaseStatusCodeId in (1)
		and a.UpdateQuantity > @pQuantity
	))
	begin
		declare @pDiffQuantity int = 0
		select @pDiffQuantity = a.UpdateQuantity - @pQuantity
		from ItemPurchaseTask a (nolock)
		where a.Id = @pItemPurchaseTaskId
		and a.ItemPurchaseStatusCodeId in (1)
		and a.UpdateQuantity > @pQuantity

		update a
		set a.Quantity = a.Quantity + @pDiffQuantity,
			a.AvailableQuantity = a.AvailableQuantity + @pDiffQuantity
		from ItemPurchasePool a
			inner join ItemPurchaseTask b (nolock) on a.Id = b.ItemPurchasePoolId
		where b.Id = @pItemPurchaseTaskId

		update a
		set a.UpdateQuantity = @pQuantity
		from ItemPurchaseTask a
		where a.Id = @pItemPurchaseTaskId

	
	end



return

/*

*/



GO


