IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemPurchaseTaskInStockPayToBuyer]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemPurchaseTaskInStockPayToBuyer] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemPurchaseTaskInStockPayToBuyer] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemPurchaseTaskInStockPayToBuyer] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemPurchaseTaskInStockPayToBuyer] 
	@pStockItemGroupId int,
	@pTotalGivenPrice decimal(10,2),
	@pCurrencyId int,
	@pDetail nvarchar(256),
	@pIsClear bit,
	@pStockItemPaymentId int output
AS

SET NOCOUNT ON
	
	declare @pTime datetime = getutcdate()
	
	 
	insert into [dbo].[StockItemPayment]
	(
		[StockItemGroupId],
		[Amount],
		[CurrencyId],
		[Detail],
		[TransactionTypeCodeId], --select * from CodeList where Category = 'TransactionType'
		[CreateDate],
		[LastUpdate]
	)
	select @pStockItemGroupId, @pTotalGivenPrice, @pCurrencyId, @pDetail, 2, @pTime, @pTime 
	

	select @pStockItemPaymentId = SCOPE_IDENTITY()
	
	if(isnull(@pIsClear, 0) = 1)
	begin
		update a
		set a.StockItemGroupStatusCodeId = 2, --select * from CodeList where Category = 'StockItemGroupStatus'
			a.LastUpdate = @pTime
		from StockItemGroup a 
		where a.Id = @pStockItemGroupId
	end
	





return

/*

*/



GO


