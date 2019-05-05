IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderBatchHandlerActionUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderBatchHandlerActionUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderBatchHandlerActionUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderBatchHandlerActionUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderBatchHandlerActionUpdate] 
	@pShippingOrderBatchHandlerId int,
	@pSubOrderTypeCodeId int,--select * from CodeList where Category = 'SubOrderType'
	@pSubOrderCode nvarchar(256),
    @pSubOrderDescription nvarchar(max)
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	insert into [dbo].[ShippingOrderBatchHandlerAction]
	(
		[ShippingOrderBatchHandlerId], 
		[SubOrderTypeCodeId],
		[SubOrderCode],
		[SubOrderDescription],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	@pShippingOrderBatchHandlerId, 
			@pSubOrderTypeCodeId,
			@pSubOrderCode,
			@pSubOrderDescription,
			1,
			@pTime,
			@pTime,
			1,
			1

return

/*

*/



GO


