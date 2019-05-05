IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Item_Search]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Item_Search] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Item_Search] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Item_Search] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Item_Search] 
	@pCompanyId int,
	@pSKU nvarchar(256),
	@pProductCode nvarchar(256),
	@pItemName nvarchar(256),
	@pItemStatusCodeId int,
	@pCategory nvarchar(256),
	@pBrand nvarchar(256),
	@pFileId int, --To be continued
	@pProductDescription nvarchar(256),
	@pModelNumber nvarchar(256),
	@pSupplierSKU nvarchar(256),
	@PageSize INT,
	@Page INT output,
	@Total INT OUTPUT,
	@TotalPages INT OUTPUT,
	@pSystemLanguageId int
AS

SET NOCOUNT ON
	if(isnull(@PageSize, 0) <= 0)
	begin
		return
	end
	declare @pTime datetime = getutcdate()
	declare @pBySKU bit = 0,
			@pByProductCode bit = 0,
			@pByItemName bit = 0,
			@pByItemStatus bit = 0,
			@pByCategory bit = 0,
			@pByBrand bit = 0,
			@pByFileId bit = 0,
			@pByProductDescription bit = 0,
			@pByModelNumber bit = 0,
			@pBySupplierSKU bit = 0

	select @pSKU = isnull(@pSKU, '')
    select @pSKU = rtrim(ltrim(@pSKU))
	if( len(@pSKU) > 0 )
	begin
		select @pBySKU = 1
	end

	select @pProductCode = isnull(@pProductCode, '')
    select @pProductCode = rtrim(ltrim(@pProductCode))
	if( len(@pProductCode) > 0 )
	begin
		select @pByProductCode = 1
	end

	select @pItemName = isnull(@pItemName, '')
    select @pItemName = rtrim(ltrim(@pItemName))
	if( len(@pItemName) > 0 )
	begin
		select @pByItemName = 1
	end

	select @pCategory = isnull(@pCategory, '')
    select @pCategory = rtrim(ltrim(@pCategory))
	if( len(@pCategory) > 0 )
	begin
		select @pByCategory = 1
	end

	select @pBrand = isnull(@pBrand, '')
    select @pBrand = rtrim(ltrim(@pBrand))
	if( len(@pBrand) > 0 )
	begin
		select @pByBrand = 1
	end

	select @pProductDescription = isnull(@pProductDescription, '')
    select @pProductDescription = rtrim(ltrim(@pProductDescription))
	if( len(@pProductDescription) > 0 )
	begin
		select @pByProductDescription = 1
	end

	select @pModelNumber = isnull(@pModelNumber, '')
    select @pModelNumber = rtrim(ltrim(@pModelNumber))
	if( len(@pModelNumber) > 0 )
	begin
		select @pByModelNumber = 1
	end

	select @pSupplierSKU = isnull(@pSupplierSKU, '')
    select @pSupplierSKU = rtrim(ltrim(@pSupplierSKU))
	if( len(@pSupplierSKU) > 0 )
	begin
		select @pBySupplierSKU = 1
	end

	if( @pItemStatusCodeId is not null and @pItemStatusCodeId <> 0)
	begin
		select @pByItemStatus = 1
	end

	if(@pFileId is not null and @pFileId <> 0)
	begin
		select @pByFileId = 1
	end
	
	declare @pPossibleCategory Table
	(
		CategoryId int
	)

	insert @pPossibleCategory
	(
		CategoryId
	)
	select a.Id
	from Category a (nolock)
	where a.Name like '%'+ @pCategory + '%'
	and a.Available = 1

	declare @pPossibleBrand Table
	(
		BrandId int
	)
	
	insert @pPossibleBrand
	(
		BrandId
	)
	select a.Id
	from Brand a (nolock)
	where a.BrandName like '%'+ @pBrand + '%'
	and a.Available = 1


	declare @pBrandTable Table
	(
		BrandId int
	)
	if(@pByBrand = 1)
	begin
		;with PagedQuery as
		(
		  SELECT a.Id
		  FROM Brand a (nolock)
		  WHERE a.BrandName like '%' + @pBrand + '%'

		  UNION ALL

		  SELECT b.Id
		  FROM Brand b (nolock)
		  INNER JOIN PagedQuery c
		  ON b.ParentBrandId = c.Id
		)
		insert into @pBrandTable
		(BrandId)
		select a.Id
		from PagedQuery a
	end

	declare @pCategoryTable Table
	(
		CategoryId int
	)

if(@pByCategory = 1)
BEGIN
	;with PagedQuery as
	(
	  SELECT a.Id
	  FROM Category a (nolock)
	  WHERE a.Name like '%' + @pCategory + '%'

	  UNION ALL

	  SELECT b.Id
	  FROM Category b (nolock)
	  INNER JOIN PagedQuery c
	  ON b.ParentCategoryId = c.Id
	)
	insert into @pCategoryTable
	(CategoryId)
	select a.Id
	from PagedQuery a
end
	
	

	select @Total = count(distinct(a.Id)) 
	--select * 
	from Item a (nolock)
		inner join WizardSession b (nolock) on a.Id = b.SourceId and b.SourceTable = 'Item'
		inner join CompanyItem a1 (nolock) on a1.ItemId = a.Id and a1.CompanyId = @pCompanyId and a1.Available = 1
		left join ItemCategory c (nolock) on a.Id = c.ItemId
		left join ItemBrand d (nolock) on a.Id = d.ItemId
		left join ItemProperty z (nolock) on a.Id = z.ItemId and z.PropertyName = 'SupplierSKU'
		left join ItemProperty y (nolock) on a.Id = y.ItemId and y.PropertyName = 'ModelNumber'
		left join WizardSessionInputs x (nolock) on b.Id = x.WizardSessionId and x.StepSourceTable = 'ItemRelatedUPCInfo'
		left join ItemRelatedUPCInfo x1 (nolock) on x.StepSourceId = x1.Id and x1.Available = 1
	where (@pBySKU = 0 or a.SKU = @pSKU)
	and (@pByProductCode = 0 or a.ProductCode = @pProductCode or (x1.Id is not null and x1.UPC = @pProductCode))
	and (@pByItemName = 0 or a.Name like '%'+ @pItemName + '%')
	and a.ItemStatusCodeId not in (2)
	and (@pByItemStatus = 0 or a.ItemStatusCodeId = @pItemStatusCodeId)
	and (@pByCategory = 0 or c.CategoryId in (select CategoryId from @pCategoryTable))
	and (@pByBrand = 0 or d.BrandId in (select BrandId from @pBrandTable))
	and (@pByProductDescription = 0 or a.Description like '%'+ @pProductDescription + '%')
	and (@pByModelNumber = 0 or isnull(y.PropertyValue,'') like '%' + @pModelNumber + '%')
	and (@pBySupplierSKU = 0 or isnull(z.PropertyValue, '') like '%' + @pSupplierSKU + '%')
	and b.Id in (
			select a.Id
			from WizardSession a (nolock)
				inner join WizardSessionInputs b (nolock) on a.Id = b.WizardSessionId
		)	
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
		select distinct a.Id as ItemId, b.Id as WizardSessionId,
				isnull(a.Name, '') as ItemName, isnull(c1.Id, 0) as CategoryId,
				isnull(c1.Name, '') as Category, isnull(d1.Id, 0) as BrandId,
				isnull(d1.BrandName, '') as Brand,
				a.ItemStatusCodeId,
				isnull(y.CodeShort, z.CodeShort) as ItemStatusCode,
				isnull(x.FileId, null) as MainImageFileId,
				isnull(a.SKU, '') as [SKU],
				isnull(a.ProductCode, '') as ProductCode,
				isnull(a.Description, '') as ProductDescription,
				isnull(z1.PropertyValue, '') as SupplierSKU,
				isnull(y1.PropertyValue, '') as ModelNumber,
			DENSE_RANK() OVER (order by case when v.Id is null then a.Id else convert(int, v.PropertyValue) end desc) AS RowNumber
		--select * 
		from Item a (nolock)
			inner join WizardSession b (nolock) on a.Id = b.SourceId and b.SourceTable = 'Item'
			inner join CompanyItem a1 (nolock) on a1.ItemId = a.Id and a1.CompanyId = @pCompanyId and a1.Available = 1
			left join ItemCategory c (nolock) on a.Id = c.ItemId
			left join Category c1 (nolock) on c.CategoryId = c1.Id
			left join ItemBrand d (nolock) on a.Id = d.ItemId
			left join Brand d1 (nolock) on d.BrandId = d1.Id
			left join CodeList z (nolock) on z.Category = 'ItemStatus' and z.CodeId = a.ItemStatusCodeId
			left join CodeListY y (nolock) on z.Id = y.CodeListId and y.SystemLanguageId = @pSystemLanguageId
			left join ItemResource x (nolock) on a.Id = x.ItemId and x.MainResource = 1 and x.Available = 1
			left join ItemProperty z1 (nolock) on a.Id = z1.ItemId and z1.PropertyName = 'SupplierSKU'
			left join ItemProperty y1 (nolock) on a.Id = y1.ItemId and y1.PropertyName = 'ModelNumber'
			left join WizardSessionInputs w (nolock) on b.Id = w.WizardSessionId and w.StepSourceTable = 'ItemRelatedUPCInfo'
			left join ItemRelatedUPCInfo w1 (nolock) on w.StepSourceId = w1.Id and w1.Available = 1
			left join ItemProperty v (nolock) on a.Id = v.ItemId and v.PropertyName = 'ItemOrderId'
		where (@pBySKU = 0 or a.SKU = @pSKU)
		and (@pByProductCode = 0 or a.ProductCode = @pProductCode or (w1.Id is not null and w1.UPC = @pProductCode))
		and (@pByItemName = 0 or a.Name like '%'+ @pItemName + '%')
		and (@pByItemStatus = 0 or a.ItemStatusCodeId = @pItemStatusCodeId)
		and a.ItemStatusCodeId not in (2)
		and (@pByCategory = 0 or c.CategoryId in (select CategoryId from @pCategoryTable))
		and (@pByBrand = 0 or d.BrandId in (select BrandId from @pBrandTable))
		and (@pByProductDescription = 0 or a.Description like '%'+ @pProductDescription + '%')
		and (@pByModelNumber = 0 or isnull(y1.PropertyValue,'') like '%' + @pModelNumber + '%')
		and (@pBySupplierSKU = 0 or isnull(z1.PropertyValue, '') like '%' + @pSupplierSKU + '%')
		and b.Id in (
			select a.Id
			from WizardSession a (nolock)
				inner join WizardSessionInputs b (nolock) on a.Id = b.WizardSessionId
		)	
		
	)

	SELECT *
	from PagedQuery
	where RowNumber  between @RecStart and @RecEnd
	order by RowNumber ASC;



return

/*

*/



GO


