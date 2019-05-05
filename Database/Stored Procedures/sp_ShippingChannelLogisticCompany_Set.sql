IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingChannelLogisticCompany_Set]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingChannelLogisticCompany_Set] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingChannelLogisticCompany_Set] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingChannelLogisticCompany_Set] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
Alter procedure [dbo].[sp_ShippingChannelLogisticCompany_Set] 
	@pCompanyId int,
	@pShippingChannelName nvarchar(256),
	@pShippingChannelCode nvarchar(256),
	@pShippingChannelTypeCodeId int,
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
	@pIDCheckBeforeShipping bit,
	@pIDCheckDuplicateBeforeShipping bit,
    @pIDDuplicateNumberLimitation int,
	@pShippingChannelId int output,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	if(not exists(
		select *
		from CompanyLogisticCompany a (nolock)
		where a.CompanyId = @pCompanyId
	))
	begin
		return
	end



	
	if(isnull(@pShippingChannelId, 0) = 0)
	begin
		if(exists(
			select * from ShippingChannel a (nolock)
				inner join ShippingChannelLogisticCompany b (nolock) on a.Id = b.ShippingChannelId
			where B.LogisticCompanyId = @pCompanyId
			and a.ChannelCode = @pShippingChannelCode
			and a.ChannelName = @pShippingChannelName
		))
		begin
			return
		end
		insert into [dbo].[ShippingChannel]
		(
			[ChannelName],
			[ChannelCode], --BC, CC, EEX
			[ShippingChannelTypeCodeId],
			[TaxRate], --%
			[PriceFirstRate],
			[PriceAdditionRate],
			[WeightUnit], -- lb, kg, g
			[WeightFirst], --first weight
			[UnitPriceFirst],
			[UnitPriceAdditional], 
			[JumpToInt],
			[TaxPaymentMethodAvailable],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	a.ChannelName, a.ChannelCode, @pShippingChannelTypeCodeId, a.TaxRate, a.PriceFirstRate, a.PriceAdditionRate,
				a.WeightUnit, a.WeightFirst, a.UnitPriceFirst, a.UnitPriceAdditional, a.JumpToInt,
				a.TaxPaymentMethodAvailable, @pTime, @pTime, @pLastUpdateBy, @pLastUpdateByType
		from 
		(
			select	@pShippingChannelName as [ChannelName], @pShippingChannelCode as [ChannelCode], @pShippingChannelTypeCodeId as [ShippingChannelTypeCodeId],
					isnull(@pTaxRate, 0) as [TaxRate], isnull(@pPriceFirstRate, 0) as [PriceFirstRate],
					isnull(@pPriceAdditionRate, 0) as [PriceAdditionRate], isnull(@pWeightUnit, 1) as [WeightUnit],
					isnull(@pWeightFirst, 0) as [WeightFirst], isnull(@pUnitPriceFirst, 0) as [UnitPriceFirst],
					isnull(@pUnitPriceAdditional, 0) as [UnitPriceAdditional], @pJumpToInt as [JumpToInt],
					isnull(@pTaxPaymentMethodAvailable, 0) as [TaxPaymentMethodAvailable]
		) a
		--left join [ShippingChannel] z (nolock) on a.ChannelCode = z.ChannelCode and a.ChannelName = z.ChannelName
		--where z.Id is null

		if(@@ROWCOUNT > 0)
		begin
			select @pShippingChannelId = SCOPE_IDENTITY()

			if(@pShippingChannelTypeCodeId = 2)
			begin
				insert into ShippingChannelPriceRange
				(
					ShippingChannelId,
					[CurrencyId],
					WeightMin,
					WeightMax,
					Available,
					Price,
					CreateDate,
					LastUpdate,
					LastUpdateBy,
					LastUpdateByType
				)
				select	@pShippingChannelId,
						114,
						0.0,
						10000.0,
						1,
						0,
						@pTime,
						@pTime,
						@pLastUpdateBy,
						@pLastUpdateByType
			end
		end
		else
		begin
			update a
			set a.ChannelName = @pShippingChannelName,
				a.ChannelCode = @pShippingChannelCode,
				a.ShippingChannelTypeCodeId = @pShippingChannelTypeCodeId,
				a.UnitPriceFirst = isnull(@pUnitPriceFirst, 0),
				a.UnitPriceAdditional = isnull(@pUnitPriceAdditional, 0),
				a.PriceFirstRate = @pPriceFirstRate,
				a.PriceAdditionRate = @pPriceAdditionRate,
				a.JumpToInt = @pJumpToInt,
				a.WeightFirst = @pWeightFirst,
				a.WeightUnit = @pWeightUnit,
				a.TaxPaymentMethodAvailable = isnull(@pTaxPaymentMethodAvailable, 0),
				a.TaxRate = @pTaxRate,
				a.LastUpdate = @pTime,
				a.LastUpdateBy = 1,
				a.LastUpdateByType = 1
			from ShippingChannel a
			where a.Id = @pShippingChannelId
		end

		insert into  [dbo].[ShippingChannelLogisticCompany]
		(
			[ShippingChannelId],
			[LogisticCompanyId],
			[Available],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	a.ShippingChannelId, a.LogisticCompanyId, a.Available, a.CreateDate,
				a.LastUpdate, a.LastUpdateBy, a.LastUpdateByType
		from
		(
			select	@pShippingChannelId as [ShippingChannelId],
					@pCompanyId as [LogisticCompanyId],
					isnull(@pAvailable, 1) as [Available],
					@pTime as [CreateDate],
					@pTime as [LastUpdate],
					1 as [LastUpdateBy],
					1 as [LastUpdateByType]
		) a
		left join [dbo].[ShippingChannelLogisticCompany] z (nolock) on a.ShippingChannelId = z.ShippingChannelId
		where z.Id is null
	
		if(@@ROWCOUNT = 0)
		begin
			update a
			set a.LogisticCompanyId = @pCompanyId,
				a.Available = isnull(@pAvailable, 1),
				a.LastUpdate = @pTime,
				a.LastUpdateBy = @pLastUpdateBy,
				a.LastUpdateByType = 1
			from ShippingChannelLogisticCompany a
			where a.ShippingChannelId = @pShippingChannelId
			and a.LogisticCompanyId = @pCompanyId
		end
	end
	else
	begin
		update a
			set a.ChannelName = @pShippingChannelName,
				a.ChannelCode = @pShippingChannelCode,
				a.ShippingChannelTypeCodeId = @pShippingChannelTypeCodeId,
				a.UnitPriceFirst = isnull(@pUnitPriceFirst, 0),
				a.UnitPriceAdditional = isnull(@pUnitPriceAdditional, 0),
				a.PriceFirstRate = @pPriceFirstRate,
				a.PriceAdditionRate = @pPriceAdditionRate,
				a.JumpToInt = @pJumpToInt,
				a.WeightFirst = @pWeightFirst,
				a.WeightUnit = @pWeightUnit,
				a.TaxPaymentMethodAvailable = isnull(@pTaxPaymentMethodAvailable, 0),
				a.TaxRate = @pTaxRate,
				a.LastUpdate = @pTime,
				a.LastUpdateBy = 1,
				a.LastUpdateByType = 1
			from ShippingChannel a
			where a.Id = @pShippingChannelId
		update a
			set a.LogisticCompanyId = @pCompanyId,
				a.Available = isnull(@pAvailable, 1),
				a.LastUpdate = @pTime,
				a.LastUpdateBy = @pLastUpdateBy,
				a.LastUpdateByType = 1
			from ShippingChannelLogisticCompany a
			where a.ShippingChannelId = @pShippingChannelId
			and a.LogisticCompanyId = @pCompanyId
	end
	
	if(isnull(@pShippingChannelId, 0) > 0)
	begin
		declare @pShippingChannelIDCheckId int = 0
		insert into [dbo].[ShippingChannelIDCheck]
		(
			[ShippingChannelId],
			[IDCheckBeforeShipping],
			[IDCheckDuplicateBeforeShipping],
			[IDDuplicateNumberLimitation],
			[Available],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	a.ShippingChannelId, a.IDCheckBeforeShipping, a.IDCheckDuplicateBeforeShipping,
				a.IDDuplicateNumberLimitation, a.Available, a.CreateDate, a.LastUpdate,
				a.LastUpdateBy, a.LastUpdateByType
		from 
		(
			select	@pShippingChannelId as [ShippingChannelId],
					isnull(@pIDCheckBeforeShipping, 0) as [IDCheckBeforeShipping],
					isnull(@pIDCheckDuplicateBeforeShipping, 0) as [IDCheckDuplicateBeforeShipping],
					isnull(@pIDDuplicateNumberLimitation, 0) as [IDDuplicateNumberLimitation],
					1 as [Available],
					@pTime as [CreateDate],
					@pTime as [LastUpdate],
					@pLastUpdateBy as [LastUpdateBy], @pLastUpdateByType as [LastUpdateByType]
		) a
		left join [ShippingChannelIDCheck] z (nolock) on a.ShippingChannelId = z.ShippingChannelId
		where z.Id is null

		if(@@ROWCOUNT > 0)
		begin
			select @pShippingChannelIDCheckId = SCOPE_IDENTITY()
		end
		else
		begin
			update a
			set a.IDCheckBeforeShipping = isnull(@pIDCheckBeforeShipping, 0),
				a.IDCheckDuplicateBeforeShipping = isnull(@pIDCheckDuplicateBeforeShipping, 0),
				a.IDDuplicateNumberLimitation = isnull(@pIDDuplicateNumberLimitation, 0),
				a.LastUpdate = @pTime,
				a.LastUpdateBy = @pLastUpdateBy,
				a.LastUpdateByType = @pLastUpdateByType
			from ShippingChannelIDCheck a
			where a.ShippingChannelId = @pShippingChannelId
		end
	end
	


return

/*

*/



GO


