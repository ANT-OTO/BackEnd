IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderReceiptShippingOrderUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderReceiptShippingOrderUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderReceiptShippingOrderUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderReceiptShippingOrderUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderReceiptShippingOrderUpdate] 
	@pShippingOrderBatchReceiptId int output,
	@pShippingOrderId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	insert into [dbo].[ShippingOrderBatchReceiptShippingOrder]
	(
		[ShippingOrderBatchReceiptId],
		[ShippingOrderId],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	a.ShippingOrderBatchReceiptId, a.ShippingOrderId, 
			a.CreateDate, a.LastUpdate, a.LastUpdateBy,
			a.LastUpdateByType
	from 
	(
		select	@pShippingOrderBatchReceiptId as ShippingOrderBatchReceiptId,
				@pShippingOrderId as [ShippingOrderId],
				@pTime as CreateDate,
				@pTime as LastUpdate,
				1 as LastUpdateBy,
				1 as LastUpdateByType
	) a
	left join [ShippingOrderBatchReceiptShippingOrder] z (nolock) on a.ShippingOrderBatchReceiptId = z.ShippingOrderBatchReceiptId and a.ShippingOrderId = z.ShippingOrderId
	where z.Id is null

return

/*

*/



GO


