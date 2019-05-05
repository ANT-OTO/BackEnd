IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Customer_OrderPay]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Customer_OrderPay] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Customer_OrderPay] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Customer_OrderPay] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Customer_OrderPay] 
	@pCustomerPaymentMethodCodeId int,
	@pTotalAmount decimal(10,2),
	@pCurrencyId int,
	@pDetail nvarchar(max),
	@pCustomer_OrderId int,
	@pCustomer_OrderPaymentId int output
AS

SET NOCOUNT ON

	declare @pTime datetime = getutcdate()

	declare @pRemainingAmount decimal(10,2) = 0.0
	declare @pPaidAmount decimal(10,2) = 0.0
	select @pPaidAmount = SUM(a.TotalAmount)
	from Customer_Order_Payment a (nolock)
	where a.Customer_OrderId = @pCustomer_OrderId

	select @pRemainingAmount = a.TotalPriceAmount - @pPaidAmount
	from Customer_Orders a (nolock)
	where a.Id = @pCustomer_OrderId

	if(@pTotalAmount <= @pRemainingAmount)
	begin
		insert into Customer_Order_Payment
		(
			[Customer_OrderId],
			[Customer_Order_PaymentMethodCodeId], --Wechat pay, alipay, card, directPay
			[TotalAmount],
			[CurrencyId],
			[Detail],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	@pCustomer_OrderId, 
				@pCustomerPaymentMethodCodeId,
				@pTotalAmount,
				@pCurrencyId,
				@pDetail,
				@pTime,
				@pTime,
				1,1
		select @pCustomer_OrderPaymentId = SCOPE_IDENTITY()
	end
	else
	begin
		select @pCustomer_OrderPaymentId = 0
	end

	
	
	
	


return

/*

*/



GO


