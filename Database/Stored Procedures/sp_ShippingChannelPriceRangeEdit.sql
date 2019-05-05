IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingChannelPriceRangeEdit]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingChannelPriceRangeEdit] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingChannelPriceRangeEdit] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingChannelPriceRangeEdit] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
Alter procedure [dbo].[sp_ShippingChannelPriceRangeEdit] 
	@pShippingChannelId int,
	@pCurrencyId int,
	@pWeightMax decimal(10, 2),
	@pShippingChannelPriceRangeId int output,
	@pPrice decimal(10, 2),
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	if(not exists(
		select *
		from ShippingChannel a (nolock)
			inner join ShippingChannelPriceRange b (nolock) on a.Id = b.ShippingChannelId
		where a.Id = @pShippingChannelId
		and b.Available = 1
	))
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
				@pCurrencyId,
				0.0,
				10000.0,
				1,
				0,
				@pTime,
				@pTime,
				@pLastUpdateBy,
				@pLastUpdateByType
	end

	if(exists(
		select * 
		from ShippingChannel a (nolock)
			inner join ShippingChannelPriceRange b (nolock) on a.Id = b.ShippingChannelId
		where a.Id = @pShippingChannelId
		and b.WeightMax = @pWeightMax
		and b.Available = 1
	))
	begin
		select @pShippingChannelPriceRangeId = b.Id
		from ShippingChannel a (nolock)
			inner join ShippingChannelPriceRange b (nolock) on a.Id = b.ShippingChannelId
		where a.Id = @pShippingChannelId
		and b.WeightMax = @pWeightMax
		and b.Available = 1 

		update a
		set a.Price = @pPrice,
			a.CurrencyId = @pCurrencyId,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = @pLastUpdateBy,
			a.LastUpdateByType = @pLastUpdateByType
		from ShippingChannelPriceRange a 
			inner join ShippingChannel b on a.ShippingChannelId = b.Id
		where a.ShippingChannelId = @pShippingChannelId
		and a.WeightMax = @pWeightMax
		and a.Available = 1
	end
	else
	begin
		declare @pCurrentMin decimal(10, 2) = 0
		declare @pCurrentMax decimal(10, 2) = 0

		declare @pCurrentId int = 0

		select	@pCurrentId = b.Id,
				@pCurrentMin = b.WeightMin,
				@pCurrentMax = b.WeightMax
		from ShippingChannel a (nolock)
			inner join ShippingChannelPriceRange b (nolock) on a.Id = b.ShippingChannelId
		where a.Id = @pShippingChannelId
		and b.WeightMax > @pWeightMax
		and b.WeightMin < @pWeightMax
		and b.Available = 1

		--insert new
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
				@pCurrencyId,
				@pCurrentMin,
				@pWeightMax,
				1,
				@pPrice,
				@pTime,
				@pTime,
				@pLastUpdateBy,
				@pLastUpdateByType

		select @pShippingChannelPriceRangeId = SCOPE_IDENTITY()

		update a
		set a.WeightMin = @pWeightMax,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = @pLastUpdateBy,
			a.LastUpdateByType = @pLastUpdateByType
		from ShippingChannelPriceRange a 
			inner join ShippingChannel b on a.ShippingChannelId = b.Id
		where a.ShippingChannelId = @pShippingChannelId
		and a.Available = 1
		and a.Id = @pCurrentId

	end



	
	


return

/*

*/



GO


