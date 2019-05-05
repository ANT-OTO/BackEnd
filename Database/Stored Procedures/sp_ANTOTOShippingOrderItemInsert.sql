IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ANTOTOShippingOrderItemInsert]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ANTOTOShippingOrderItemInsert] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ANTOTOShippingOrderItemInsert] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ANTOTOShippingOrderItemInsert] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ANTOTOShippingOrderItemInsert] 
	@pShippingOrderId int,
	@pItemId int,
	@pStockItemId int,
	@pItemName nvarchar(256),
	@pQuantity int,
	@pUnit nvarchar(256),
	@pWeight decimal(10,2),
	@pWeightUnit int, --1 lb 2 kg 3 g
	@pPrice decimal(10, 2),
	@pCurrencyId int,
	@pTaxPrice decimal(10,2),
	@pSourceArea nvarchar(64),
	@pGoodCode nvarchar(256), --SKU Number
	@pStateBarCode nvarchar(256), --UPC Number
	@pBrand nvarchar(256),
	@pSpecifications nvarchar(256),
	@pLastUpdateBy int,
	@pLastUpdateByType int,
	@pShippingOrderItemId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	if(not exists(
		select *
		from ShippingOrder a (nolock)
		where a.Id = @pShippingOrderId
		and a.ShippingOrderStatusCodeId in (1, 2, 3) --select * from CodeList where Category = 'ShippingOrderStatus'
	))
	begin
		return
	end
	if(@pShippingOrderItemId > 0)
	BEGIN
		update a
		set a.ItemId = @pItemId,
			a.StockItemId = @pStockItemId,
			a.ItemName = @pItemName,
			a.[Quantity] = @pQuantity,
			a.[Unit] = @pUnit,
			a.[Weight] = isnull(@pWeight, 0),
			a.WeightUnit = isnull(@pWeightUnit, 1), --1 lb 2 kg 3 g
			a.[Price] = isnull(@pPrice, 0.0),
			a.[CurrencyId] = isnull(@pCurrencyId, 114),--select * from Currency
			a.[TaxPrice] = isnull(@pTaxPrice, 0.0),
			a.[SourceArea] = isnull(@pSourceArea, ''),
			a.[GoodCode] = isnull(@pGoodCode, ''), --SKU Number
			a.[StateBarCode] = isnull(@pStateBarCode, ''), --UPC Number
			a.[Brand] = isnull(@pBrand, ''),
			a.[Specifications] = isnull(@pSpecifications, ''),
			a.[LastUpdate] = @pTime,
			a.[LastUpdateBy] = @pLastUpdateBy,
			a.[LastUpdateByType] = @pLastUpdateByType
		from ShippingOrderItems a
		where a.Id = @pShippingOrderItemId
	END
	ELSE
	BEGIN
		insert into [dbo].[ShippingOrderItems]
		(
			[ShippingOrderId],
			[ItemId],
			[StockItemId],
			[ItemName],
			[Quantity],
			[Unit],
			[Weight],
			[WeightUnit], --1 lb 2 kg 3 g
			[Price],
			[CurrencyId],
			[TaxPrice],
			[SourceArea],
			[GoodCode], --SKU Number
			[StateBarCode], --UPC Number
			[Brand],
			[Specifications],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	@pShippingOrderId, @pItemId, @pStockItemId, @pItemName, @pQuantity, @pUnit, isnull(@pWeight, 0), isnull(@pWeightUnit, 1), isnull(@pPrice, 0.0),
				isnull(@pCurrencyId, 114), isnull(@pTaxPrice, 0.0), isnull(@pSourceArea, ''), isnull(@pGoodCode, ''), isnull(@pStateBarCode, ''), isnull(@pBrand, ''), isnull(@pSpecifications, ''),
				@pTime, @pTime, @pLastUpdateBy, @pLastUpdateByType

		select @pShippingOrderItemId = SCOPE_IDENTITY()
	END 

	

	
	
	

	


return

/*

*/



GO


