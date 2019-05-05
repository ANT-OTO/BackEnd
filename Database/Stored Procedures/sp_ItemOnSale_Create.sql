IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemOnSale_Create]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemOnSale_Create] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemOnSale_Create] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemOnSale_Create] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemOnSale_Create] 
	@pItemId int,
	@pTitle nvarchar(256),
	@pDescription nvarchar(256),
	@pVariationTitle nvarchar(256),
	@pPrice decimal(10,2),
	@pCurrencyId int,
	@pSaleTitle nvarchar(256),
	@pUserId int,
	@pItemOnSaleId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	if(isnull(@pItemOnSaleId, 0) = 0)
	begin
		update a
		set a.Available = 0,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = @pUserId,
			a.LastUpdateByType = 1
		from ItemOnSale a
		where a.ItemId = @pItemId
		insert into [dbo].[ItemOnSale]
		(
			[ItemId],
			[Title],
			[Description],
			[VariationTitle],
			[Price],
			[CurrencyId],
			[Available],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	@pItemId,
				@pTitle,
				@pDescription,
				@pVariationTitle,
				@pPrice,
				@pCurrencyId,
				1,
				@pTime,
				@pTime,
				@pUserId,
				1
		select @pItemOnSaleId = SCOPE_IDENTITY()
	end
	else
	begin
		update a
		set A.Title = @pTitle,
			a.VariationTitle = @pVariationTitle,
			a.Price = @pPrice,
			a.CurrencyId = @pCurrencyId,
			a.Description = @pDescription,
			a.Available = 1,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = @pUserId,
			a.LastUpdateByType = 1
		from ItemOnSale a 
		where a.Id = @pItemOnSaleId
	end

	

/*

*/



GO


