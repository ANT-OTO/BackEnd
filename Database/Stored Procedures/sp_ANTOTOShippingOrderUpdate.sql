IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ANTOTOShippingOrderUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ANTOTOShippingOrderUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ANTOTOShippingOrderUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ANTOTOShippingOrderUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ANTOTOShippingOrderUpdate] 
	@pCustomerId int,
	@pReferenceOrderCode nvarchar(256),
	@pFromShippingAddressId int,
	@pToShippingAddressId int,
	@pShippingChannelId int,
	@pTotalWeight decimal(10,2),
	@pWeightUnitId int,
	@pShippingOrderStatusCodeId int,
	@pUserId int,
	@pSourceCompanyId int,
	@pHandlerCompanyId int,
	@pShippingOrderId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	

	if(isnull(@pFromShippingAddressId, 0) = 0 or isnull(@pToShippingAddressId, 0) = 0 )
	begin
		return
	end

	update a
	set a.ShippingFromAddressId = @pFromShippingAddressId,
		a.ShippingToAddressId = @pToShippingAddressId,
		a.ReferenceOrderCode = @pReferenceOrderCode,
		a.ShippingChannelId = @pShippingChannelId,
		a.TotalWeight = @pTotalWeight,
		a.WeightUnitId = @pWeightUnitId,
		a.UserId = @pUserId,
		a.LastUpdate = @pTime
	from ShippingOrder a
	where a.Id = @pShippingOrderId




	

	


return

/*

*/



GO


