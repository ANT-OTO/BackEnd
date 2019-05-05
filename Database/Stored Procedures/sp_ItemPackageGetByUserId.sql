IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemPackageGetByUserId]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemPackageGetByUserId] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemPackageGetByUserId] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemPackageGetByUserId] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemPackageGetByUserId] 
	@pSearchWord nvarchar(256),
	@pItemPackageStatusCodeId int,
	@pCompanyId int,
	@pUserId int,
	@pSystemLanguageId int,
	@PageSize INT,
	@Page INT output,
	@Total INT OUTPUT,
	@TotalPages INT OUTPUT
AS

SET NOCOUNT ON
	if(isnull(@PageSize, 0) <= 0)
	begin
		return
	end
	declare @pTime datetime = getutcdate()
	select @pSearchWord = isnull(@pSearchWord, '')
    select @pSearchWord = rtrim(ltrim(@pSearchWord))
	declare @TempTable Table
	(
		SourceId int NOT NULL,
		SourceTable nvarchar(64) NOT NULL,
		UPC nvarchar(256) NOT NULL,
		[ProductName] nvarchar(256) NOT NULL,
		[Price] nvarchar(256) NOT NULL,
		[CurrencyId] int NOT NULL,
		[Currency] nvarchar(256) NOT NULL,
		[Weight] nvarchar(256) NOT NULL,
		[SaleTitle] nvarchar(max) NOT NULL,
		[SalePlace] nvarchar(256) NOT NULL,
		[DiscountDescription] nvarchar(max) NOT NULL,
		[SizeRange] nvarchar(max) NOT NULL,
		[ColorRange] nvarchar(max) NOT NULL,
		[UserId] int NOT NULL,
		[CompanyId] int NOT NULL,
		[ItemPackageStatusCodeId] int NOT NULL,
		[ItemPackageStatus] nvarchar(256) NOT NULL,
		[CreateDate] datetime NOT NULL,
		[ItemId] int NULL,
		[WizardSessionId] int NULL
	)

	insert into @TempTable
	(
		SourceId,
		SourceTable,
		UPC,
		[ProductName],
		[Price],
		[CurrencyId],
		[Currency],
		[Weight],
		[SaleTitle],
		[SalePlace],
		[DiscountDescription],
		[SizeRange],
		[ColorRange],
		[UserId],
		[CompanyId],
		[ItemPackageStatusCodeId],
		[ItemPackageStatus],
		[CreateDate],
		[ItemId],
		[WizardSessionId]
	)
	select	a.Id as [SourceId], 'ItemSubmitPackage' as [SourceTable],
			a.UPC as [UPC], a.ProductName as [ProductName],
			a.Price as [Price], a.CurrencyId as [CurrencyId], isnull(x.Code, '') as [Currency],
			a.[Weight] as [Weight], a.SaleTitle as [SaleTitle] ,
			a.SalePlace as [SalePlace], a.DiscountDescription as [DiscountDescription],
			a.SizeRange as [SizeRange], a.ColorRange as [ColorRange],
			a.UserId as [UserId], a.CompanyId as [CompanyId],
			a.ItemPackageStatusCodeId as [ItemPackageStatusCodeId], isnull(z.CodeShort, b.CodeShort) as [ItemPackageStatus],
			a.CreateDate as [CreateDate], a.ItemId as [ItemId], y.Id as [WizardSessionId]
	from ItemSubmitPackage a (nolock)
		inner join CodeList b (nolock) on a.ItemPackageStatusCodeId = b.CodeId AND b.Category = 'ItemPackageStatus'
		left join CodeListY z (nolock) on b.Id = z.CodeListId and z.SystemLanguageId = @pSystemLanguageId
		left join WizardSession y (nolock) on a.ItemId = y.SourceId and y.SourceTable = 'Item'
		left join Currency x (nolock) on a.CurrencyId = x.Id
	where (len(@pSearchWord) = 0 or a.ProductName like '%' + @pSearchWord + '%' or a.UPC = @pSearchWord)
	and a.UserId = @pUserId
	and a.CompanyId = @pCompanyId
	and (isnull(@pItemPackageStatusCodeId, 0) = 0 or a.ItemPackageStatusCodeId = @pItemPackageStatusCodeId)

	insert into @TempTable
	(
		SourceId,
		SourceTable,
		UPC,
		[ProductName],
		[Price],
		[CurrencyId],
		[Currency],
		[Weight],
		[SaleTitle],
		[SalePlace],
		[DiscountDescription],
		[SizeRange],
		[ColorRange],
		[UserId],
		[CompanyId],
		[ItemPackageStatusCodeId],
		[ItemPackageStatus],
		[CreateDate],
		[ItemId],
		[WizardSessionId]
	)
	select	a.Id as [SourceId], 'ItemUpdatePackage' as [SourceTable],
			c.ProductCode as [UPC], c.Name as [ProductName],
			a.Price as [Price], a.CurrencyId as [CurrencyId], isnull(x.Code, '') as [Currency],
			a.[Weight] as [Weight], a.SaleTitle as [SaleTitle] ,
			a.SalePlace as [SalePlace], a.DiscountDescription as [DiscountDescription],
			a.SizeRange as [SizeRange], a.ColorRange as [ColorRange],
			a.UserId as [UserId], a.CompanyId as [CompanyId],
			a.ItemPackageStatusCodeId as [ItemPackageStatusCodeId], isnull(z.CodeShort, b.CodeShort) as [ItemPackageStatus],
			a.CreateDate as [CreateDate], a.ItemId as [ItemId], y.Id as [WizardSessionId]
	from ItemUpdatePackage a (nolock)
		inner join CodeList b (nolock) on a.ItemPackageStatusCodeId = b.CodeId AND b.Category = 'ItemPackageStatus'
		left join CodeListY z (nolock) on b.Id = z.CodeListId and z.SystemLanguageId = @pSystemLanguageId
		inner join Item c (nolock) on a.ItemId = c.Id
		left join WizardSession y (nolock) on a.ItemId = y.SourceId and y.SourceTable = 'Item'
		left join Currency x (nolock) on a.CurrencyId = x.Id
	where (len(@pSearchWord) = 0 or c.Name like '%' + @pSearchWord + '%' or c.ProductCode = @pSearchWord)
	and a.UserId = @pUserId
	and a.CompanyId = @pCompanyId
	and (isnull(@pItemPackageStatusCodeId, 0) = 0 or a.ItemPackageStatusCodeId = @pItemPackageStatusCodeId)

	select @Total = count(*) 
	--select *
	from @TempTable a

	select @TotalPages = CEILING(convert(decimal(10,2), @Total)/convert(decimal(10,2) ,@PageSize))
	declare @MaxPage INT

	select @MaxPage = (@Total - 1 )/@PageSize + 1

	if ( @Page < 1 )
	BEGIN
		select @Page = 1
	END

	if ( @Page > @MaxPage )
	BEGIN
		select @Page = @MaxPage
	END

	declare @RecStart INT,
			@RecEnd INT

	select @RecStart = (@Page - 1) * @PageSize + 1,
			@RecEnd = @Page * @PageSize

	if( @RecEnd > @Total )
	begin
		select @RecEnd = @Total
	end
	;

	with PagedQuery AS
	(
		select	SourceId,
				SourceTable,
				UPC,
				[ProductName],
				[Price],
				[CurrencyId],
				[Currency],
				[Weight],
				[SaleTitle],
				[SalePlace],
				[DiscountDescription],
				[SizeRange],
				[ColorRange],
				[UserId],
				[CompanyId],
				[ItemPackageStatusCodeId],
				[ItemPackageStatus],
				[CreateDate] ,
				[ItemId],
				[WizardSessionId],
				ROW_NUMBER() OVER (order by a.CreateDate desc) AS RowNumber
		from @TempTable a
	)

	SELECT *
	from PagedQuery
	where RowNumber  between @RecStart and @RecEnd
	order by RowNumber ASC;



return

/*

*/



GO


