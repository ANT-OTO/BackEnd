IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingChannelPriceRangeDelete]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingChannelPriceRangeDelete] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingChannelPriceRangeDelete] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingChannelPriceRangeDelete] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
Alter procedure [dbo].[sp_ShippingChannelPriceRangeDelete] 
	@pShippingChannelPriceRangeId int output,
	@pCompanyId int,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	declare @pShippingChannelId int = 0
	declare @pCurrentMin decimal(10, 2) = 0.0
	declare @pCurrentMax decimal(10, 2) = 0.0
	select	@pShippingChannelId = a.Id,
			@pCurrentMin = b.WeightMin,
			@pCurrentMax = b.WeightMax
	from ShippingChannel a (nolock)
		inner join ShippingChannelPriceRange b (nolock) on a.Id = b.ShippingChannelId
	where b.Id = @pShippingChannelPriceRangeId
	and b.Available = 1

	declare @pPreviousShippingChannelPriceRangeId int = 0
	declare @pNextShippingChannelPriceRangeId int = 0

	select @pPreviousShippingChannelPriceRangeId = b.Id
	from ShippingChannel a (nolock)
		inner join ShippingChannelPriceRange b (nolock) on a.Id = b.ShippingChannelId
	where a.Id = @pShippingChannelId 
	and b.Available = 1
	and b.WeightMax = @pCurrentMin

	select @pNextShippingChannelPriceRangeId = b.Id
	from ShippingChannel a (nolock)
		inner join ShippingChannelPriceRange b (nolock) on a.Id = b.ShippingChannelId
	where a.Id = @pShippingChannelId
	and b.Available = 1
	and b.WeightMin = @pCurrentMax

	if(@pPreviousShippingChannelPriceRangeId = 0 and @pNextShippingChannelPriceRangeId = 0)
	begin
		select @pShippingChannelPriceRangeId = 0
		return
	end
	else if (@pPreviousShippingChannelPriceRangeId > 0 and @pNextShippingChannelPriceRangeId = 0)
	begin
		delete
		from ShippingChannelPriceRange 
		where Id = @pShippingChannelPriceRangeId

		update a
		set a.WeightMax = @pCurrentMax
		from ShippingChannelPriceRange a
			inner join ShippingChannel b (nolock) on a.ShippingChannelId = b.Id
		where a.Id = @pPreviousShippingChannelPriceRangeId
	end
	else if (@pPreviousShippingChannelPriceRangeId = 0 and @pNextShippingChannelPriceRangeId > 0)
	begin
		delete
		from ShippingChannelPriceRange
		where Id = @pShippingChannelPriceRangeId

		update a
		set a.WeightMin = @pCurrentMin
		from ShippingChannelPriceRange a
			inner join ShippingChannel b (nolock) on a.ShippingChannelId = b.Id
		where a.Id = @pNextShippingChannelPriceRangeId
	end
	else
	begin
		delete
		from ShippingChannelPriceRange
		where Id = @pShippingChannelPriceRangeId

		update a
		set a.WeightMax = @pCurrentMax
		from ShippingChannelPriceRange a
			inner join ShippingChannel b (nolock) on a.ShippingChannelId = b.Id
		where a.Id = @pPreviousShippingChannelPriceRangeId
		
		update a
		set a.WeightMin = @pCurrentMax
		from ShippingChannelPriceRange a
			inner join ShippingChannel b (nolock) on a.ShippingChannelId = b.Id
		where a.Id = @pNextShippingChannelPriceRangeId
	end




	
	


return

/*

*/



GO


