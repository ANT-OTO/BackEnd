IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PurchasePoolTaskCancel]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_PurchasePoolTaskCancel] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_PurchasePoolTaskCancel] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_PurchasePoolTaskCancel] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_PurchasePoolTaskCancel] 
	@pReason nvarchar(256),
	@pItemPurchaseTaskId int output
AS

SET NOCOUNT ON
	if(isnull(@pReason, 0) = '')
	begin
		select @pItemPurchaseTaskId = 0
		return
	end
	declare @pTime datetime = getutcdate()
	if(exists(
		select *
		from ItemPurchaseTask a (nolock)
		where a.Id = @pItemPurchaseTaskId
		and a.ItemPurchaseStatusCodeId in (1) -- select* from CodeList where Category = 'ItemPurchaseStatus'
	))
	begin
		update a
		set a.ItemPurchaseStatusCodeId = 3,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = 1,
			a.LastUpdateByType = 1
		from ItemPurchaseTask a 
		where a.Id = @pItemPurchaseTaskId

		update a
		set a.Quantity = a.Quantity + b.UpdateQuantity,
			a.AvailableQuantity = a.AvailableQuantity + b.UpdateQuantity
		from ItemPurchasePool a (nolock)
			inner join ItemPurchaseTask b (nolock) on b.ItemPurchasePoolId = a.Id
		where b.Id = @pItemPurchaseTaskId
		
		select @pItemPurchaseTaskId = a.Id
		from ItemPurchaseTask a 
		where a.Id = @pItemPurchaseTaskId

	end



return

/*

*/



GO


