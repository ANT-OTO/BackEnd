IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Customer_ShoppingCartUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Customer_ShoppingCartUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Customer_ShoppingCartUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Customer_ShoppingCartUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Customer_ShoppingCartUpdate] 
	@pCustomerId int,
	@pItemId int,
	@pQuantity int,
	@pUserId int,
	@pCustomer_ShoppingCart_ItemId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	--select @pCustomer_ShoppingCart_ItemId = 0
	

	if(isnull(@pCustomer_ShoppingCart_ItemId, 0) > 0)
	begin
		
		update a
		set a.Quantity = @pQuantity,
			a.TotalAmount = a.UnitAmount * @pQuantity
		from Customer_ShoppingCart_Items a (nolock)
		where a.CustomerId = @pCustomerId
		and a.ItemId = @pItemId
		and a.Id = @pCustomer_ShoppingCart_ItemId

	end
	else
	begin
		if(exists(
			select *
			from Customer_ShoppingCart_Items a (nolock)
			where a.CustomerId = @pCustomerId
			and a.ItemId = @pItemId
			and a.Quantity > 0
		))
		begin
			update a
			set a.Quantity = a.Quantity + @pQuantity,
				a.TotalAmount = a.UnitAmount * (a.Quantity + @pQuantity)
			from Customer_ShoppingCart_Items a (nolock)
			where a.CustomerId = @pCustomerId
			and a.ItemId = @pItemId

			select @pCustomer_ShoppingCart_ItemId = a.Id
			from Customer_ShoppingCart_Items a (nolock)
			where a.CustomerId = @pCustomerId
			and a.ItemId = @pItemId
		end
		else
		begin
			insert into Customer_ShoppingCart_Items 
			(
				[CustomerId],
				[ItemId],
				[UnitAmount],
				[Quantity],
				[TotalAmount],
				[CurrencyId],
				[CreateDate],
				[LastUpdate],
				[LastUpdateBy],
				[LastUpdateByType]
			)
			select	@pCustomerId,
					@pItemId,
					a.Price,
					@pQuantity,
					a.Price * @pQuantity,
					a.CurrencyId,
					@pTime,
					@pTime,
					@pUserId,
					1
			from ItemOnSale a (nolock)
			where a.ItemId = @pItemId
			and a.Available = 1
			if(@@ROWCOUNT > 0)
			begin
				select @pCustomer_ShoppingCart_ItemId = SCOPE_IDENTITY()
			end
			else
			begin
				select @pCustomer_ShoppingCart_ItemId = 0 
			end
		end
		
	end



	


return

/*

*/



GO


