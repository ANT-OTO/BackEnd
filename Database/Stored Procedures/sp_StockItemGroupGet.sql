IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_StockItemGroupGet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_StockItemGroupGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_StockItemGroupGet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_StockItemGroupGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_StockItemGroupGet] 
	@pStockItemGroupId int,
	@pStockItemGroupStatusCodeId int output,
	@pStockItemGroupStatus nvarchar(64) output,
	@pStockItemPaymentId int output
AS

SET NOCOUNT ON
	
	declare @pTime datetime = getutcdate()
	
	
	select	@pStockItemGroupStatusCodeId = a.StockItemGroupStatusCodeId,
			@pStockItemGroupStatus = b.CodeShort
	from StockItemGroup a (nolock)
		inner join CodeList b (nolock) on a.StockItemGroupStatusCodeId = b.CodeId and b.Category = 'StockItemGroupStatus'
	where a.Id = @pStockItemGroupId

	declare @pStockItemTable Table
	(
		[StockItemId] int NOT NULL,
		[ItemId] int NOT NULL,
		[StockCode] nvarchar(64) NOT NULL,
		[StockItemStatusCodeId] int NOT NULL,
		[StockItemStatus] nvarchar(64) NOT NULL
	)
	if(isnull(@pStockItemGroupStatusCodeId, 0) > 0)
	begin
		insert into @pStockItemTable
		(
			StockItemId,
			ItemId,
			StockCode,
			StockItemStatusCodeId,
			StockItemStatus
		)
		select a.Id, a.ItemId, a.StockCode, a.StockItemStatusCodeId, c.CodeShort
		from StockItem a (nolock)
			inner join StockItemGroupStockItem b (nolock) on a.Id = b.StockItemId
			inner join CodeList c (nolock) on a.StockItemStatusCodeId = c.CodeShort and c.Category = 'StockItemStatus'
		where b.Id = @pStockItemGroupId
	end

	select * 
	from @pStockItemTable
	
	





return

/*

*/



GO


