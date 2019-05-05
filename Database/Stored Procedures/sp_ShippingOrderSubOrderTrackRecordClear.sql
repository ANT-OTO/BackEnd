IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderSubOrderTrackRecordClear]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderSubOrderTrackRecordClear] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderSubOrderTrackRecordClear] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderSubOrderTrackRecordClear] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderSubOrderTrackRecordClear] 
	@pShippingOrderSubOrderId int

AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	--delete
	--from ShippingOrderSubOrderRoutingTrack
	--where ShippingOrderSubOrderId = @pShippingOrderSubOrderId

return

/*

*/



GO


