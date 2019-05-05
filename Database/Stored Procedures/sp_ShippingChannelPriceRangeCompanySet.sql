IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingChannelPriceRangeCompanySet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingChannelPriceRangeCompanySet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingChannelPriceRangeCompanySet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingChannelPriceRangeCompanySet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
Alter procedure [dbo].[sp_ShippingChannelPriceRangeCompanySet] 
	@pShippingChannelId int,
	@pCompanyId int,
	@pShippingChannelPriceRangeId int,
	@pPrice decimal(10, 2),
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	
	if(not exists(
		select * 
		from ShippingChannel a (nolock)
			inner join ShippingChannelCompany b (nolock) on a.Id = b.ShippingChannelId
		where a.Id = @pShippingChannelId
		and b.SourceCompanyId = @pCompanyId
	))
	begin
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
		select	a.Id, @pCompanyId, b.LogisticCompanyId, a.TaxRate, a.PriceFirstRate, a.PriceAdditionRate,
				a.WeightUnit, a.WeightFirst, a.UnitPriceFirst, a.UnitPriceAdditional, a.JumpToInt,
				a.TaxPaymentMethodAvailable, 1, @pTime, @pTime, @pLastUpdateBy, @pLastUpdateByType
		from ShippingChannel a (nolock)
			inner join ShippingChannelLogisticCompany b (nolock) on a.Id = b.ShippingChannelId
		where a.Id = @pShippingChannelId
	end
	
	if(exists(
		select *
		from ShippingChannelPriceRangeCompany a (nolock)
			inner join ShippingChannelCompany b (nolock) on a.ShippingChannelCompanyId = b.Id
			inner join ShippingChannel c (nolock) on b.ShippingChannelId = c.Id
		where a.ShippingChannelPriceRangeId = @pShippingChannelPriceRangeId
		and b.SourceCompanyId = @pCompanyId
		and b.Available = 1 
		and c.Id = @pShippingChannelId
	))
	begin
		update a
		set a.Price = @pPrice,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = @pLastUpdateBy,
			a.LastUpdateByType = @pLastUpdateByType
		from ShippingChannelPriceRangeCompany a
			inner join ShippingChannelCompany b (nolock) on a.ShippingChannelCompanyId = b.Id
			inner join ShippingChannel c (nolock) on b.ShippingChannelId = c.Id
		where a.ShippingChannelPriceRangeId = @pShippingChannelPriceRangeId
		and b.SourceCompanyId = @pCompanyId
		and b.Available = 1 
		and c.Id = @pShippingChannelId
	end
	else
	begin
		insert into ShippingChannelPriceRangeCompany
		(
			ShippingChannelCompanyId,
			ShippingChannelPriceRangeId,
			[Available],
			Price,
			CreateDate,
			LastUpdate,
			LastUpdateBy,
			LastUpdateByType
		)
		select b.Id, @pShippingChannelPriceRangeId, 1, @pPrice, @pTime, @pTime, @pLastUpdateBy, @pLastUpdateByType
		from ShippingChannelCompany b 
			inner join ShippingChannel c (nolock) on b.ShippingChannelId = c.Id
		where b.SourceCompanyId = @pCompanyId
		and b.Available = 1 
		and c.Id = @pShippingChannelId
	end
	

	
	


return

/*

*/



GO


