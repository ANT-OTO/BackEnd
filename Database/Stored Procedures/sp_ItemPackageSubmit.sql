IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemPackageSubmit]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemPackageSubmit] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemPackageSubmit] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemPackageSubmit] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemPackageSubmit] 
	@pUPC nvarchar(256),
	@pPrice nvarchar(256) ,
	@pCurrencyId int,
	@pProductName nvarchar(max),
	@pWeight nvarchar(256),
	@pSaleTitle nvarchar(max)  ,
	@pSalePlace nvarchar(256)  ,
	@pDiscountDescription nvarchar(max)  ,
	@pSizeRange nvarchar(max)  ,
	@pColorRange nvarchar(max)  ,
	@pUserId int,
	@pCompanyId int,
	@pItemSubmitPackageId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	if(exists(
		select *
		from Item a (nolock)
			inner join CompanyItem b (nolock) on b.ItemId = a.Id
		where a.ProductCode = @pUPC
		and a.ItemStatusCodeId not in (2) --select * from CodeList where Category = 'ItemStatus'
		and b.CompanyId = @pCompanyId
	))
	begin
		return
	end
	insert into [dbo].[ItemSubmitPackage]
	(
		[UPC],
		[Price],
		[CurrencyId],
		[ProductName],
		[Weight],
		[SaleTitle],
		[SalePlace],
		[DiscountDescription],
		[SizeRange],
		[ColorRange],
		[UserId],
		[ItemPackageStatusCodeId], 
		[ItemId],
		[CompanyId],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	@pUPC as [UPC],
			@pPrice as [Price],
			@pCurrencyId as [CurrencyId],
			@pProductName as [ProductName],
			@pWeight as [Weight],
			@pSaleTitle as [SaleTitle],
			@pSalePlace as [SalePlace],
			@pDiscountDescription as [DiscountDescription],
			isnull(@pSizeRange,'') as [SizeRange],
			isnull(@pColorRange,'') as [ColorRange],
			@pUserId as [UserId],
			1 as [ItemPackageStatusCodeId], 
			null as [ItemId],
			@pCompanyId as [CompanyId],
			@pTime as [CreateDate],
			@pTime as [LastUpdate],
			@pUserId as [LastUpdateBy],
			1 as [LastUpdateByType]
	
	select @pItemSubmitPackageId = SCOPE_IDENTITY()


return

/*

*/



GO


