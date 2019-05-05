IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderReceiptUpdateFile]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderReceiptUpdateFile] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderReceiptUpdateFile] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderReceiptUpdateFile] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderReceiptUpdateFile] 
	@pShippingOrderBatchReceiptId int output,
	@pFileId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	update a
	set a.FileId = @pFileId
	from ShippingOrderBatchReceipt a
	where a.Id = @pShippingOrderBatchReceiptId
return

/*

*/



GO


