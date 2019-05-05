IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemPurchaseTaskInStock]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemPurchaseTaskInStock] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemPurchaseTaskInStock] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemPurchaseTaskInStock] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemPurchaseTaskInStock] 
	@pItemPurchaseTaskId int,
	@pUserId int,
	@pCompanyId int,
	@pStockGroupId int output
AS

SET NOCOUNT ON
	
	declare @pTime datetime = getutcdate()
	
	declare @pItemId int = 0
	declare @pQuantity int = 0
	select	@pItemId = b.ItemId,
			@pQuantity = a.UpdateQuantity
	from ItemPurchaseTask a (nolock)
		inner join ItemPurchasePool b (nolock) on a.ItemPurchasePoolId = b.Id
	where a.Id = @pItemPurchaseTaskId
	declare @pStockItemId int = 0
	declare @pStockActionId int = 0
	declare @pStockItemGroupId int = 0
	if(@pQuantity > 0)
	begin
		insert into StockItemGroup
		(
			StockItemGroupStatusCodeId,
			CreateDate,
			LastUpdate
		)
		select 1, @pTime, @pTime

		select @pStockItemGroupId = SCOPE_IDENTITY()
	end

	declare @i int = 0
	declare @pStockCode nvarchar(256) = ''
	WHILE @i < @pQuantity
	BEGIN  
		insert into [dbo].[StockItem]
		(
			[ItemId],
			[StockCode],
			[StockItemStatusCodeId], --select * from CodeList where Category = 'StockItemStatus'
			[CreateDate],
			[LastUpdate]
		)
		select @pItemId, '', 3, @pTime, @pTime

		select @pStockItemId = SCOPE_IDENTITY()

		update a
		set a.StockCode = 'AS' + RIGHT('00000000' + CAST(a.Id AS NCHAR(8)), 8 )
		from StockItem a (nolock)
		where a.Id = @pStockItemId
		
		INSERT INTO dbo.StockItemCompany
		(
			StockItemId,
			CompanyId,
			CreateDate,
			LastUpdate
		)
		select	@pStockItemId,
				@pCompanyId,
				@pTime,
				@pTime

		insert into [dbo].[StockItemAction]
		(
			[StockItemId],
			[StockActionTypeCodeId], --select * from CodeList where Category = 'StockActionType'
			[ResponsibleUserId],
			[SourceTable],
			[SourceId],
			[CreateDate],
			[LastUpdate]
		)
		select	@pStockItemId,
				1,
				@pUserId,
				'ItemPurchaseTask',
				@pItemPurchaseTaskId,
				@pTime,
				@pTime
		select @pStockActionId = SCOPE_IDENTITY()

		insert into [dbo].[StockItemGroupStockItem]
		(
			[StockItemGroupId],
			[StockItemId],
			[CreateDate],
			[LastUpdate]
		)
		select	@pStockItemGroupId,
				@pStockItemId,
				@pTime,
				@pTime
			
	END 

	
	
	





return

/*

*/



GO


