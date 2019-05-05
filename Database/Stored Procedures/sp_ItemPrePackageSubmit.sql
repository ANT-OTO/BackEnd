IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemPrePackageSubmit]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemPrePackageSubmit] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemPrePackageSubmit] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemPrePackageSubmit] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemPrePackageSubmit] 
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
	@pItemPrePackageId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	insert into [dbo].[ItemPrePackage]
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
		[ItemPrePackageStatusCodeId], 
		[ItemId],
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
			@pSizeRange as [SizeRange],
			@pColorRange as [ColorRange],
			@pUserId as [UserId],
			1 as [ItemPrePackageStatusCodeId], 
			null as [ItemId],
			@pTime as [CreateDate],
			@pTime as [LastUpdate],
			@pUserId as [LastUpdateBy],
			1 as [LastUpdateByType]
	
	select @pItemPrePackageId = SCOPE_IDENTITY()


return

/*

*/



GO


