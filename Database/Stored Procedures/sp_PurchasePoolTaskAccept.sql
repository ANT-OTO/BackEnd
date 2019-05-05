IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PurchasePoolTaskAccept]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_PurchasePoolTaskAccept] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_PurchasePoolTaskAccept] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_PurchasePoolTaskAccept] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_PurchasePoolTaskAccept] 
	@pItemPurchasePoolId int,
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
		from ItemPurchasePool a (nolock)
			inner join ItemPurchasePoolCompany b (nolock) on a.ItemPurchasePoolCompanyId = b.Id
		where a.Id = @pItemPurchasePoolId
		and a.Quantity >= @pQuantity
		and a.ItemId = @pItemId
	))
	begin
		update a
		set a.Quantity = a.Quantity - @pQuantity,
			a.AvailableQuantity = a.AvailableQuantity - @pQuantity
		from ItemPurchasePool a
		where a.Id = @pItemPurchasePoolId

		insert into [dbo].[ItemPurchaseTask]
		(
			[ItemPurchasePoolId],
			[Quantity],
			[ItemPurchaseStatusCodeId], --select * from CodeList where Category = 'ItemPurchaseStatus'
			[UpdateQuantity],
			[Reason],
			[FinalUnitPrice],
			[FinalTotalPrice],
			[CurrencyId],
			[UserId],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	@pItemPurchasePoolId,
				@pQuantity,
				1,
				@pQuantity,
				'',
				NULL,
				NULL,
				a.CurrencyId,
				@pUserId,
				@pTime,
				@pTime,
				1,
				1
		from ItemPurchasePool a (nolock)
		where a.Id = @pItemPurchasePoolId

		select @pItemPurchaseTaskId = SCOPE_IDENTITY()
	end



return

/*

*/



GO


