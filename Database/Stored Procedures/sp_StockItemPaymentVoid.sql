IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_StockItemPaymentVoid]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_StockItemPaymentVoid] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_StockItemPaymentVoid] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_StockItemPaymentVoid] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_StockItemPaymentVoid]
	@pStockItemPaymentId int output
AS

SET NOCOUNT ON
	
	declare @pTime datetime = getutcdate()
	
	update a
	set a.[TransactionTypeCodeId] = 3,
		a.LastUpdate = @pTime
	from StockItemPayment a 
	where a.Id = @pStockItemPaymentId
	

	select @pStockItemPaymentId = SCOPE_IDENTITY()
	
	





return

/*

*/



GO


