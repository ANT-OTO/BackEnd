IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingChannelPriceRangeCompanyDelete]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingChannelPriceRangeCompanyDelete] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingChannelPriceRangeCompanyDelete] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingChannelPriceRangeCompanyDelete] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
Alter procedure [dbo].[sp_ShippingChannelPriceRangeCompanyDelete] 
	@pShippingChannelId int,
	@pCompanyId int,
	@pShippingChannelPriceRangeId int,
	@pPrice decimal(10, 2),
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	
	
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
		declare @pShippingChannelPriceRangeCompanyId int = 0
		select @pShippingChannelPriceRangeCompanyId = a.Id
		from ShippingChannelPriceRangeCompany a
			inner join ShippingChannelCompany b (nolock) on a.ShippingChannelCompanyId = b.Id
			inner join ShippingChannel c (nolock) on b.ShippingChannelId = c.Id
		where a.ShippingChannelPriceRangeId = @pShippingChannelPriceRangeId
		and b.SourceCompanyId = @pCompanyId
		and b.Available = 1 
		and c.Id = @pShippingChannelId

		delete
		from ShippingChannelPriceRangeCompany
		where Id = @pShippingChannelPriceRangeCompanyId
	end


	
	


return

/*

*/



GO


