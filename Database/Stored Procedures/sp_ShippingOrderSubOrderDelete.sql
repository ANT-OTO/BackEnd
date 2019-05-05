IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderSubOrderDelete]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderSubOrderDelete] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderSubOrderDelete] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderSubOrderDelete] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderSubOrderDelete] 
	@pShippingOrderSubOrderId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	if(isnull(@pShippingOrderSubOrderId, 0) > 0)
	begin
		update a
		set a.SubOrderStatus = 'Cancelled'
		from ShippingOrderSubOrder a
		where Id = @pShippingOrderSubOrderId
	end
	
	


	

	


return

/*

*/



GO


