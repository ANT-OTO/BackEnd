IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Customer_OrderItemInsert]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Customer_OrderItemInsert] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Customer_OrderItemInsert] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Customer_OrderItemInsert] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Customer_OrderItemInsert] 
	@pCustomer_OrderId int,
	@pItemId int,
	@pUnitAmount decimal(10,2),
	@pQuantity int,
	@pCurrencyId int,
	@pUserId int,
	@pCustomer_Order_ItemId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	insert into [dbo].[Customer_Order_Items]
	(
		[Customer_OrderId],
		[ItemId],
		[UnitAmount],
		[Quantity],
		[TotalAmount],
		[CurrencyId],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	@pCustomer_OrderId, 
			@pItemId,
			@pUnitAmount,
			@pQuantity,
			@pUnitAmount * @pQuantity,
			@pCurrencyId,
			@pTime,
			@pTime,
			@pUserId,
			1 
	
	select @pCustomer_Order_ItemId = SCOPE_IDENTITY()
	


return

/*

*/



GO


