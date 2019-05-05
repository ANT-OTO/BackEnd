IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Customer_OrderPriceCalculate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Customer_OrderPriceCalculate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Customer_OrderPriceCalculate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Customer_OrderPriceCalculate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Customer_OrderPriceCalculate] 
	@pCustomer_OrderId int,
	@pPromoCode nvarchar(256)
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	declare @pTotalAmount decimal(10,2) = 0.0

	select @pTotalAmount = SUM(isnull(a.TotalAmount, 0.0)) 
	from Customer_Order_Items a (nolock)
	where a.Customer_OrderId = @pCustomer_OrderId
	and a.Quantity > 0


	update a
	set a.TotalPriceAmount = @pTotalAmount,
		a.CustomerOrderStatusCodeId = 2,  --select * from CodeList where Category = 'CustomerOrderStatus'
		a.LastUpdate = @pTime,
		a.LastUpdateBy = 1,
		a.LastUpdateByType = 1
	from Customer_Orders a
	where a.Id = @pCustomer_OrderId
	


return

/*

*/



GO


