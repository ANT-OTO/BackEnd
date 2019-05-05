IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderReceiptUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderReceiptUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderReceiptUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderReceiptUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderReceiptUpdate] 
	@pShippingOrderBatchReceiptId int output,
	@pReceiptNumber nvarchar(256) output,
	@pCustomerCompanyId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	insert into ShippingOrderBatchReceipt
	(
		CustomerCompanyId,
		ReceiptNumber,
		CreateDate,
		LastUpdate,
		LastUpdateBy,
		LastUpdateByType
	)
	select	@pCustomerCompanyId,
			'',
			@pTime,
			@pTime,
			1,
			1

	select @pShippingOrderBatchReceiptId = SCOPE_IDENTITY()

	update a
	set a.ReceiptNumber = 'AR' + RIGHT('000000'+CAST(@pShippingOrderBatchReceiptId AS VARCHAR(6)),6),
		a.LastUpdate = @pTime,
		a.LastUpdateBy = 1,
		a.LastUpdateByType = 1
	from ShippingOrderBatchReceipt a
	where a.Id = @pShippingOrderBatchReceiptId

	select @pReceiptNumber = 'AR' + RIGHT('000000'+CAST(@pShippingOrderBatchReceiptId AS VARCHAR(6)),6)

return

/*

*/



GO


