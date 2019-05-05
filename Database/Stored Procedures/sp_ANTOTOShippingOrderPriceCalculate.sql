IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ANTOTOShippingOrderPriceCalculate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ANTOTOShippingOrderPriceCalculate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ANTOTOShippingOrderPriceCalculate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ANTOTOShippingOrderPriceCalculate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ANTOTOShippingOrderPriceCalculate] 
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
	declare @pShippingChannelTypeCodeId int = 0

	declare @pSourceCompanyId int = 0
	declare @pHandlerCompanyId int = 0

	select	@pSourceCompanyId = b.SourceCompanyId,
			@pHandlerCompanyId = b.HandlerCompanyId
	from ShippingOrder a (nolock)
		inner join ShippingOrderCompany b (nolock) on a.Id = b.ShippingOrderId
	where a.Id = @pShippingOrderId

	select	@pShippingChannelId = a.Id,
			@pShippingChannelTypeCodeId = a.ShippingChannelTypeCodeId,
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

	declare @pWeightPackage decimal(10,2) = 0.0
	select @pWeightPackage = a.TotalWeight
	from ShippingOrder a (nolock)
	where a.Id = @pShippingOrderId

	declare @pPrice decimal(10,2) = 0.0
	
	if(isnull(@pWeightPackage, 0.0) = 0.0)
	begin
		return
	end

	if(@pJumpToInt  = 1)
	begin
		select @pWeightPackage = CEILING(CAST (@pWeightPackage AS FLOAT))
	end

	if(@pShippingChannelTypeCodeId = 2)
	begin
		select @pPrice = isnull(z.Price, d.Price)
		from ShippingChannel a (nolock)
			inner join ShippingOrder b (nolock) on a.Id = b.ShippingChannelId
			left join ShippingChannelCompany c (nolock) on a.Id = c.ShippingChannelId and c.SourceCompanyId = @pSourceCompanyId
	 and c.HandlerCompanyId = @pHandlerCompanyId
			inner join ShippingChannelPriceRange d (nolock) on a.Id = d.ShippingChannelId
			left join ShippingChannelPriceRangeCompany z (nolock) on z.ShippingChannelPriceRangeId = d.Id and z.ShippingChannelCompanyId = c.Id and z.Available = 1
		where b.Id = @pShippingOrderId
		and d.WeightMin < @pWeightPackage
		and d.WeightMax >= @pWeightPackage
	end
	else
	begin
		if(@pWeightPackage <= @pWeightFirst)
		begin
			select @pPrice = @pWeightFirst * @pPriceFirstRate
		end
		else
		begin
			select @pPrice = @pWeightFirst * @pPriceFirstRate + (@pWeightPackage - @pWeightFirst) * @pPriceAdditionRate
		end
	end

	


	update a
	set a.Price = isnull(@pPrice,0.0)
	from ShippingOrder a 
	where a.Id = @pShippingOrderId

	exec [dbo].[sp_ANTOTOShippingOrderTaxPriceCalculate] @pShippingOrderId

return

/*

*/



GO


