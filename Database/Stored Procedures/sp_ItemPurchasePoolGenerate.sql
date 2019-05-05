IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemPurchasePoolGenerate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemPurchasePoolGenerate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemPurchasePoolGenerate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemPurchasePoolGenerate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemPurchasePoolGenerate] 
	@pCompanyId int,
	@pItemPurchasePoolCompanyId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	--Lock
	
	
	declare @pLastGenerateDateTime datetime = '1990-01-01'
	select	@pLastGenerateDateTime = a.LastUpdateUtcDate,
			@pItemPurchasePoolCompanyId = a.Id 
	from ItemPurchasePoolCompany a (nolock)
	where a.CompanyId = @pCompanyId

	if(isnull(@pItemPurchasePoolCompanyId, 0) = 0)
	begin
		insert into ItemPurchasePoolCompany
		(
			[CompanyId],
			[LastUpdateUtcDate],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select @pCompanyId, @pLastGenerateDateTime, @pTime, @pTime, 1, 1
		select @pItemPurchasePoolCompanyId = SCOPE_IDENTITY()
	end

	declare @LockResource varchar(256)
	select @LockResource = 'sp_ItemPurchasePoolGenerate' + convert(varchar(16), @pItemPurchasePoolCompanyId)


	declare @rc int = 0
	exec @rc = sp_getapplock @Resource = @LockResource ,
			@LockMode = 'Exclusive' ,
			@LockOwner = 'Session',
			@LockTimeout = 0

	if( @rc not in (0, 1) )
	begin
		select @pItemPurchasePoolCompanyId = 0
		return
	end
	-- All Orders not in warehouse

	declare @pOrderRequireItem Table
	(
		ItemId int,
		Quantity int
	)

	insert into @pOrderRequireItem
	(
		ItemId,
		Quantity
	)
	select b.ItemId, SUM(b.Quantity)
	from Customer_Orders a (nolock)
		inner join Customer_Order_Items b (nolock) on a.Id = b.Customer_OrderId
		inner join CustomerCompany c (nolock) on a.CustomerId = c.CustomerId
	where a.CustomerOrderStatusCodeId in (1, 2, 3, 4, 5, 6, 7)--select * from CodeList where Category = 'CustomerOrderStatus'
	and c.CompanyId = @pCompanyId
	group by b.ItemId

	update a
	set a.CustomerOrderStatusCodeId = 3,
		a.LastUpdate = @pTime,
		a.LastUpdateBy = 1,
		a.LastUpdateByType = 1
	from Customer_Orders a (nolock)
		inner join Customer_Order_Items b (nolock) on a.Id = b.Customer_OrderId
		inner join CustomerCompany c (nolock) on a.CustomerId = c.CustomerId
	where a.CustomerOrderStatusCodeId in (1, 2)--select * from CodeList where Category = 'CustomerOrderStatus'
	and c.CompanyId = @pCompanyId

	-- Item in Purchase Pool
	declare @pPurchasePoolItems Table
	(
		ItemId int,
		Quantity int
	)

	insert into @pPurchasePoolItems
	(
		ItemId,
		Quantity
	)
	select	a.ItemId,
			a.Quantity
	from ItemPurchasePool a (nolock)
		inner join ItemPurchasePoolCompany b (nolock) on a.ItemPurchasePoolCompanyId = b.Id
	where b.CompanyId = @pCompanyId

	-- Item in Stock
	declare @pStockItems Table
	(
		ItemId int NOT NULL,
		Quantity int NOT NULL
	)

	insert into @pStockItems
	(
		ItemId,
		Quantity
	)
	select b.ItemId, SUM(b.Id)
	from StockItemCompany a (nolock)
		inner join StockItem b (nolock) on a.StockItemId = b.Id
	where a.CompanyId = @pCompanyId
	and b.StockItemStatusCodeId in (1, 2, 3) --select* from CodeList where Category = 'StockItemStatus'
	group by b.ItemId


	-- Need Items

	declare @pItemsNeed Table
	(
		ItemId int,
		Quantity int
	)

	insert into @pItemsNeed
	(
		ItemId,
		Quantity
	)
	select a.ItemId, 0
	from @pOrderRequireItem a

	insert into @pItemsNeed
	(
		ItemId,
		Quantity
	)
	select a.ItemId, 0
	from @pStockItems a
		left join @pItemsNeed z on a.ItemId = z.ItemId
	where z.ItemId is null

	insert into @pItemsNeed
	(
		ItemId,
		Quantity
	)
	select a.ItemId, 0
	from @pPurchasePoolItems a
		left join @pItemsNeed z on a.ItemId = z.ItemId
	where z.ItemId is null


	update a
	set a.Quantity = isnull(z.Quantity, 0) - isnull(y.Quantity, 0) - isnull(x.Quantity, 0)
	from @pItemsNeed a
		left join @pOrderRequireItem z on a.ItemId = z.ItemId
		left join @pPurchasePoolItems y on a.ItemId = y.ItemId
		left join @pStockItems x on x.ItemId = a.ItemId

	declare @pItemId int = 0
	declare @pQuantity int = 0
	declare @pPoolQuantity int = 0
	declare @pPurchasePlace nvarchar(256) = ''
	declare @pPurchasePrice decimal(10,2) = 0.0
	declare @pCurrencyId int = 0
	
	DECLARE db_cursor CURSOR FOR 
	SELECT a.ItemId, a.Quantity
	from @pItemsNeed a
	

	OPEN db_cursor  
	FETCH NEXT FROM db_cursor INTO @pItemId, @pQuantity  

	WHILE @@FETCH_STATUS = 0  
	BEGIN  
			select	@pPurchasePlace = a.PurchasePlace,
					@pPurchasePrice = a.PurchasePrice,
					@pCurrencyId = a.CurrencyId
			from tfnItemPurchaseInfoGet(@pItemId, @pCompanyId) a

			if(isnull(@pPurchasePlace, '') = '')
			begin
				select @pPurchasePlace = N'未知'
				
			end

			if(isnull(@pPurchasePrice, 0.0) = 0.0)
			begin
				select @pPurchasePrice = 0.0
				
			end

			if(isnull(@pCurrencyId, 0) = 0)
			begin
			--select * from Currency
				select @pCurrencyId = 114
				
			end
			

			if(exists(
				select * 
				from ItemPurchasePool a (nolock)
					inner join ItemPurchasePoolCompany b (nolock) on a.ItemPurchasePoolCompanyId = b.Id
				where b.CompanyId = @pCompanyId
				and a.ItemId = @pItemId
				and a.PurchasePlace = @pPurchasePlace
				and a.CurrencyId = @pCurrencyId
				and a.PurchasePrice = @pPurchasePrice
			))
			begin
				select @pPoolQuantity = 0

				select @pPoolQuantity = a.Quantity
				from ItemPurchasePool a (nolock)
					inner join ItemPurchasePoolCompany b (nolock) on a.ItemPurchasePoolCompanyId = b.Id
				where b.CompanyId = @pCompanyId
				and a.ItemId = @pItemId 

				if(@pPoolQuantity - @pQuantity >= 0)
				begin
					update a
					set a.Quantity = case when @pQuantity < 0 then 0 else @pQuantity end,
						a.LastUpdate = @pTime
					from ItemPurchasePool a
						inner join ItemPurchasePoolCompany b (nolock) on a.ItemPurchasePoolCompanyId = b.Id
					where b.CompanyId = @pCompanyId
					and a.ItemId = @pItemId
				end
				else
				begin
					update a
					set a.Quantity = @pQuantity,
						a.LastUpdate = @pTime
					from ItemPurchasePool a
						inner join ItemPurchasePoolCompany b (nolock) on a.ItemPurchasePoolCompanyId = b.Id
					where b.CompanyId = @pCompanyId
					and a.ItemId = @pItemId
				end
			end
			else
			begin
				update a
				set a.Quantity = 0,
					a.LastUpdate = @pTime
				from ItemPurchasePool a (nolock)
						inner join ItemPurchasePoolCompany b (nolock) on a.ItemPurchasePoolCompanyId = b.Id
					where b.CompanyId = @pCompanyId
					and a.ItemId = @pItemId
				select @pQuantity = case when @pQuantity <= 0 then 0 else @pQuantity end
				
				insert into ItemPurchasePool
				(
					[ItemPurchasePoolCompanyId],
					[ItemId],
					[Quantity],
					[AvailableQuantity],
					[PurchasePrice],
					[CurrencyId],
					[PurchasePlace],
					[PurchaseDetail],
					[CreateDate],
					[LastUpdate],
					[LastUpdateBy],
					[LastUpdateByType]
				)
				select	@pItemPurchasePoolCompanyId,
						@pItemId,
						@pQuantity,
						@pQuantity,
						@pPurchasePrice,
						@pCurrencyId,
						@pPurchasePlace,
						'',
						@pTime,
						@pTime,
						1,1
				
			end
			FETCH NEXT FROM db_cursor INTO @pItemId, @pQuantity  
	END 

	CLOSE db_cursor  
	DEALLOCATE db_cursor 


	update a
	set a.LastUpdateUtcDate = @pTime,
		a.LastUpdate = @pTime
	from ItemPurchasePoolCompany a
	where a.Id = @pItemPurchasePoolCompanyId


	exec sp_releaseapplock @Resource = @LockResource 
		, @LockOwner = 'Session'

	return

return

/*

*/



GO


