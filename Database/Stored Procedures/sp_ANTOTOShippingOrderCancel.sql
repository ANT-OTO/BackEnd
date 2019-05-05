IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ANTOTOShippingOrderCancel]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ANTOTOShippingOrderCancel] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ANTOTOShippingOrderCancel] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ANTOTOShippingOrderCancel] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ANTOTOShippingOrderCancel] 
	@pUserId int,
	@pShippingOrderId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	if(exists(
		select *
		from ShippingOrder a (nolock)
		where a.Id = @pShippingOrderId
		and a.ShippingOrderStatusCodeId in (1, 2, 3)
	))
	begin
		update a
		set a.ShippingOrderStatusCodeId = 11, --select * from CodeList where Category = 'ShippingOrderStatus'
			a.Price = 0.0,
			a.UserId = @pUserId,
			a.LastUpdate = @pTime
		from ShippingOrder a
		where a.Id = @pShippingOrderId

		--Charge void
		exec [dbo].[sp_ShippingOrderPriceCharge] @pShippingOrderId, @pUserId

	end
	else
	begin
		select @pShippingOrderId = 0
	end

	


	

	


return

/*

*/



GO


