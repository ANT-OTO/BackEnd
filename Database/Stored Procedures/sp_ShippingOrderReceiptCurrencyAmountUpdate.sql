IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderReceiptCurrencyAmountUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderReceiptCurrencyAmountUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderReceiptCurrencyAmountUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderReceiptCurrencyAmountUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderReceiptCurrencyAmountUpdate] 
	@pShippingOrderBatchReceiptId int output,
	@pCurrencyId int,
	@pPriceNeedToCharge decimal(10,2),
	@pPricePaid decimal(10,2)
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	insert into ShippingOrderBatchReceiptCurrencyAmount
	(
		ShippingOrderBatchReceiptId,
		CurrencyId,
		PriceNeedToCharge,
		PricePaid,
		CreateDate,
		LastUpdate,
		LastUpdateBy,
		LastUpdateByType
	)
	select	a.ShippingOrderBatchReceiptId, a.CurrencyId, a.PriceNeedToCharge,
			a.PricePaid, a.CreateDate, a.LastUpdate, a.LastUpdateBy,
			a.LastUpdateByType
	from 
	(
		select	@pShippingOrderBatchReceiptId as ShippingOrderBatchReceiptId,
				@pCurrencyId as CurrencyId,
				@pPriceNeedToCharge as PriceNeedToCharge,
				@pPricePaid as PricePaid,
				@pTime as CreateDate,
				@pTime as LastUpdate,
				1 as LastUpdateBy,
				1 as LastUpdateByType
	) a
	left join ShippingOrderBatchReceiptCurrencyAmount z (nolock) on a.ShippingOrderBatchReceiptId = z.ShippingOrderBatchReceiptId and a.CurrencyId = z.CurrencyId
	where z.Id is null

	if(@@ROWCOUNT = 0)
	BEGIN
		update a
		set a.PriceNeedToCharge = @pPriceNeedToCharge,
			a.PricePaid = @pPricePaid,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = 1,
			a.LastUpdateByType = 1
		from ShippingOrderBatchReceiptCurrencyAmount a
		where a.ShippingOrderBatchReceiptId = @pShippingOrderBatchReceiptId
		and a.CurrencyId = @pCurrencyId
	END


return

/*

*/



GO


