IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemPackageUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemPackageUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemPackageUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemPackageUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemPackageUpdate]
	@pUPC nvarchar(256),
	@pPrice nvarchar(256) ,
	@pCurrencyId int,
	@pWeight nvarchar(256),
	@pSaleTitle nvarchar(max),
	@pSalePlace nvarchar(256),
	@pDiscountDescription nvarchar(max),
	@pSizeRange nvarchar(max),
	@pColorRange nvarchar(max),
	@pUserId int,
	@pCompanyId int,
	@pItemUpdatePackageId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	declare @pItemId int = 0
	select @pItemId = a.Id 
	from Item a (nolock)
		inner join CompanyItem b (nolock) on b.ItemId = a.Id
	where a.ProductCode = @pUPC
	and a.ItemStatusCodeId not in (2) --select * from CodeList where Category = 'ItemStatus'
	and b.CompanyId = @pCompanyId
	if(@pItemId > 0)
	begin
		insert into [dbo].[ItemUpdatePackage]
		(
			[Price],
			[CurrencyId],
			[Weight],
			[SaleTitle],
			[SalePlace],
			[DiscountDescription],
			[SizeRange],
			[ColorRange],
			[UserId],
			[CompanyId],
			[ItemPackageStatusCodeId], 
			[ItemId],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	@pPrice as [Price],
				@pCurrencyId as [CurrencyId],
				@pWeight as [Weight],
				@pSaleTitle as [SaleTitle],
				@pSalePlace as [SalePlace],
				@pDiscountDescription as [DiscountDescription],
				isnull(@pSizeRange,'') as [SizeRange],
				isnull(@pColorRange, '') as [ColorRange],
				@pUserId as [UserId],
				@pCompanyId as [CompanyId],
				1 as [ItemPackageStatusCodeId], 
				@pItemId as [ItemId],
				@pTime as [CreateDate],
				@pTime as [LastUpdate],
				@pUserId as [LastUpdateBy],
				1 as [LastUpdateByType]
	
		select @pItemUpdatePackageId = SCOPE_IDENTITY()
	end


return

/*

*/



GO


