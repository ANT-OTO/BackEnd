IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderBatchHandlerStatusUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderBatchHandlerStatusUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderBatchHandlerStatusUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderBatchHandlerStatusUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderBatchHandlerStatusUpdate] 
	@pShippingOrderBatchHandlerId int,
	@pBatchHandlerStatusCodeId int,
	@pUserId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	update a
	set a.[BatchHandlerStatusCodeId] = @pBatchHandlerStatusCodeId,
		a.LastUpdate = @pTime,
		a.LastUpdateBy = @pUserId,
		a.LastUpdateByType = 1
	from ShippingOrderBatchHandler a
	where a.Id = @pShippingOrderBatchHandlerId

return

/*

*/



GO


