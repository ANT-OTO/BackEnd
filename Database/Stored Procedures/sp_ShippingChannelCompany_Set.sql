IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingChannelCompany_Set]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingChannelCompany_Set] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingChannelCompany_Set] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingChannelCompany_Set] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
Alter procedure [dbo].[sp_ShippingChannelCompany_Set] 
	@pCompanyId int,
	@pShippingChannelId int,
	@pTaxRate decimal(10,2), --%
	@pPriceFirstRate decimal(10,2),
	@pPriceAdditionRate decimal(10,2),
	@pWeightUnit int, -- lb, kg, g
	@pWeightFirst int, --first weight
	@pUnitPriceFirst decimal(10,2),
	@pUnitPriceAdditional decimal(10,2), 
	@pJumpToInt bit,
	@pTaxPaymentMethodAvailable bit,
	@pAvailable bit,
	@pShippingChannelCompanyId int output,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()


	if(not exists(
		select *
		from CompanyLogisticCompany a (nolock)
		where a.CustomerCompanyId = @pCompanyId
	))
	begin
		return
	end
	
	declare @pSourceCompanyId int = @pCompanyId
	declare @pHandlerCompanyId int = 0
	select @pHandlerCompanyId = a.CompanyId
	from CompanyLogisticCompany a (nolock)
	where a.CustomerCompanyId = @pSourceCompanyId
	and a.Available = 1
	
	insert into [dbo].[ShippingChannelCompany]
	(
		[ShippingChannelId],
		[SourceCompanyId],
		[HandlerCompanyId],
		[TaxRate], --%
		[PriceFirstRate],
		[PriceAdditionRate],
		[WeightUnit], -- lb, kg, g
		[WeightFirst], --first weight
		[UnitPriceFirst],
		[UnitPriceAdditional], 
		[JumpToInt],
		[TaxPaymentMethodAvailable],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	a.ShippingChannelId, a.SourceCompanyId, a.HandlerCompanyId, a.TaxRate, a.PriceFirstRate, a.PriceAdditionRate,
			a.WeightUnit, a.WeightFirst, a.UnitPriceFirst, a.UnitPriceAdditional, a.JumpToInt,
			a.TaxPaymentMethodAvailable, a.Available, @pTime, @pTime, @pLastUpdateBy, @pLastUpdateByType
	from 
	(
		select	@pShippingChannelId as [ShippingChannelId], @pSourceCompanyId as [SourceCompanyId],
				@pHandlerCompanyId as [HandlerCompanyId],
				@pTaxRate as [TaxRate], @pPriceFirstRate as [PriceFirstRate],
				@pPriceAdditionRate as [PriceAdditionRate], @pWeightUnit as [WeightUnit],
				@pWeightFirst as [WeightFirst], @pUnitPriceFirst as [UnitPriceFirst],
				@pUnitPriceAdditional as [UnitPriceAdditional], @pJumpToInt as [JumpToInt],
				@pTaxPaymentMethodAvailable as [TaxPaymentMethodAvailable], isnull(@pAvailable, 1) as [Available]
	) a
	left join [ShippingChannelCompany] z (nolock) on a.ShippingChannelId = z.ShippingChannelId and a.SourceCompanyId = z.SourceCompanyId
	and a.HandlerCompanyId = z.HandlerCompanyId
	where z.Id is null

	if(@@ROWCOUNT > 0)
	begin
		select @pShippingChannelCompanyId = SCOPE_IDENTITY()
	end
	else
	begin
		update a
		set a.UnitPriceFirst = @pUnitPriceFirst,
			a.UnitPriceAdditional = @pUnitPriceAdditional,
			a.PriceFirstRate = @pPriceFirstRate,
			a.PriceAdditionRate = @pPriceAdditionRate,
			a.JumpToInt = @pJumpToInt,
			a.WeightFirst = @pWeightFirst,
			a.WeightUnit = @pWeightUnit,
			a.TaxPaymentMethodAvailable = @pTaxPaymentMethodAvailable,
			a.TaxRate = @pTaxRate,
			a.Available = isnull(@pAvailable, 1),
			a.LastUpdate = @pTime,
			a.LastUpdateBy = 1,
			a.LastUpdateByType = 1
		from ShippingChannelCompany a
		where a.Id = @pShippingChannelCompanyId
	end

	
	


return

/*

*/



GO


