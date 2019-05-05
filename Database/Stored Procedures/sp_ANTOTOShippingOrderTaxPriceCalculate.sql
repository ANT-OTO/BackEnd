IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ANTOTOShippingOrderTaxPriceCalculate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ANTOTOShippingOrderTaxPriceCalculate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ANTOTOShippingOrderTaxPriceCalculate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ANTOTOShippingOrderTaxPriceCalculate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ANTOTOShippingOrderTaxPriceCalculate] 
	@pShippingOrderId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()


	declare @pShippingChannelId int = 0
	declare @pChannelName nvarchar(256) = ''
	declare @pChannelCode nvarchar(256) = '' --BC, CC, EEX
	declare @pTaxRate decimal(10,2) = 0.0 --%
	declare @pPriceFirstRate decimal(10,2) = 0.0
	declare @pPriceAdditionRate decimal(10, 2) = 0.0
	declare @pWeightUnit int = 0 -- lb, kg, g
	declare @pWeightFirst int = 0 --first weight
	declare @pUnitPriceFirst decimal(10,2) = 0.0
	declare @pUnitPriceAddition decimal(10,2) = 0.0
	declare @pJumpToInt bit = 0

	declare @pSourceCompanyId int = 0
	declare @pHandlerCompanyId int = 0

	select	@pSourceCompanyId = b.SourceCompanyId,
			@pHandlerCompanyId = b.HandlerCompanyId
	from ShippingOrder a (nolock)
		inner join ShippingOrderCompany b (nolock) on a.Id = b.ShippingOrderId
	where a.Id = @pShippingOrderId

	select	@pShippingChannelId = a.Id,
			@pChannelName = a.ChannelName,
			@pChannelCode = a.ChannelCode,
			@pTaxRate = a.TaxRate,
			@pPriceFirstRate = a.PriceFirstRate,
			@pPriceAdditionRate = a.PriceAdditionRate,
			@pWeightUnit = a.WeightUnit,
			@pWeightFirst = a.WeightFirst,
			@pUnitPriceFirst = a.[UnitPriceFirst],
			@pUnitPriceAddition = a.[UnitPriceAdditional],
			@pJumpToInt = a.JumpToInt
	from ShippingChannel a (nolock)
		inner join ShippingOrder b (nolock) on a.Id = b.ShippingChannelId
	where b.Id = @pShippingOrderId

	select @pShippingChannelId = a.Id,
			@pChannelName = a.ChannelName,
			@pChannelCode = a.ChannelCode,
			@pTaxRate = c.TaxRate,
			@pPriceFirstRate = c.PriceFirstRate,
			@pPriceAdditionRate = c.PriceAdditionRate,
			@pWeightUnit = c.WeightUnit,
			@pWeightFirst = c.WeightFirst,
			@pUnitPriceFirst = c.[UnitPriceFirst],
			@pUnitPriceAddition = c.[UnitPriceAdditional],
			@pJumpToInt = c.JumpToInt
	from ShippingChannel a (nolock)
		inner join ShippingOrder b (nolock) on a.Id = b.ShippingChannelId
		inner join ShippingChannelCompany c (nolock) on a.Id = c.ShippingChannelId
	where b.Id = @pShippingOrderId
	and c.SourceCompanyId = @pSourceCompanyId
	and c.HandlerCompanyId = @pHandlerCompanyId


	if(isnull(@pShippingChannelId, 0) <= 0)
	begin
		return
	end

	update a
	set a.TaxPrice = @pTaxRate * a.Price / 100.0
	from ShippingOrderItems a
	where a.ShippingOrderId = @pShippingOrderId
	and a.TaxPrice = -1.0

	declare @pTaxPriceTotal decimal(10, 2) = 0.0

	select @pTaxPriceTotal = SUM(isnull(a.TaxPrice , 0.0))
	from ShippingOrderItems a (nolock)
	where a.ShippingOrderId = @pShippingOrderId

	declare @pTaxCurrencyId int = 0
	select @pTaxCurrencyId = a.CurrencyId
	from ShippingOrderItems a (nolock)
	where a.ShippingOrderId = @pShippingOrderId

	declare @pShippingOrderTaxPaymentTypeCodeId int = 1
	select @pShippingOrderTaxPaymentTypeCodeId = a.ShippingOrderTaxPaymentTypeCodeId --select * from CodeList where Category = 'ShippingOrderTaxPaymentType'
	from ShippingOrderAdditionalInfo a (nolock)
	where a.ShippingOrderId = @pShippingOrderId

	insert into [dbo].[ShippingOrderTaxPayment]
	(
		[ShippingOrderId],
		[TaxPaymentMethod], --shipper, receiver 1, 2
		[TaxPrice],
		[CurrencyId],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	a.ShippingOrderId, a.TaxPaymentMethod, a.TaxPrice, a.CurrencyId,
			a.CreateDate, a.LastUpdate, a.LastUpdateBy, a.LastUpdateByType
	from 
	(
		select	@pShippingOrderId as [ShippingOrderId],
				@pShippingOrderTaxPaymentTypeCodeId as [TaxPaymentMethod],
				@pTaxPriceTotal as [TaxPrice],
				@pTaxCurrencyId as [CurrencyId],
				@pTime as [CreateDate],
				@pTime as [LastUpdate],
				1 as [LastUpdateBy], 
				1 as [LastUpdateByType]
	) a 
	left join [dbo].[ShippingOrderTaxPayment] z (nolock) on a.ShippingOrderId = z.ShippingOrderId
	where z.Id is null

	if(@@ROWCOUNT = 0)
	begin
		update a
		set a.TaxPaymentMethod = @pShippingOrderTaxPaymentTypeCodeId,
			a.TaxPrice = @pTaxPriceTotal,
			a.CurrencyId = @pTaxCurrencyId,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = 1,
			a.LastUpdateByType = 1
		from ShippingOrderTaxPayment a 
		where a.ShippingOrderId = @pShippingOrderId
	end
		

return

/*

*/



GO


