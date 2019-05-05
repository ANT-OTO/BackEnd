IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Customer_ItemOnSaleSearch]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Customer_ItemOnSaleSearch] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Customer_ItemOnSaleSearch] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Customer_ItemOnSaleSearch] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Customer_ItemOnSaleSearch] 
	@pProductName nvarchar(256),
    @pPriceStart decimal(10,2),
	@pPriceEnd decimal(10,2),
	@pCompanyId int,
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
	select @pProductName = isnull(@pProductName, '')
    select @pProductName = rtrim(ltrim(@pProductName))

	

	declare @pByPriceStart bit = 0
	if(@pPriceStart is not null and @pPriceStart > 0)
	begin
		select @pByPriceStart = 1
	end
	else
	begin
		select @pByPriceStart = 0
	end
	declare @pByPriceEnd bit = 0
	if(@pPriceEnd is not null and @pPriceEnd > 0)
	begin
		select @pByPriceEnd = 1
	end
	else
	begin
		select @pByPriceEnd = 0
	end
	
	declare @pItemOnSaleTable Table
	(
		[ItemId] int NOT NULL,
		[ItemOnSaleId] int NOT NULL,
		[Title] nvarchar(256) NOT NULL,
		[Description] nvarchar(256) NOT NULL,
		[VariationTitle] nvarchar(256) NOT NULL,
		[Price] decimal(10,2) NOT NULL,
		[CurrencyId] int NOT NULL,
		[OnMarket] bit NOT NULL
	)
	insert into @pItemOnSaleTable
	(
		[ItemId],
		[ItemOnSaleId],
		[Title],
		[Description],
		[VariationTitle],
		[Price],
		[CurrencyId],
		[OnMarket]
	)
	select	a.ItemId,
			a.Id,
			a.Title,
			a.Description,
			a.VariationTitle,
			a.Price,
			a.CurrencyId,
			1
		from ItemOnSale a (nolock)
			inner join CompanyItem b (nolock) on a.ItemId = b.ItemId and b.Available = 1
		where b.CompanyId = @pCompanyId
		and a.Available = 1
		and (@pByPriceStart = 0 or (a.Price >= @pPriceStart))
		and (@pByPriceEnd = 0 or (a.Price <= @pPriceEnd))
		and (@pProductName = '' or (a.Title like '%'+ @pProductName +'%'))


	select @Total = count(distinct(a.ItemOnSaleId)) 
	--select * 
	from @pItemOnSaleTable a
	
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
		select	a.ItemId as [ItemId],
				a.[ItemOnSaleId] as [ItemOnSaleId],
				a.Title as [Title],
				a.Description as [Description],
				a.VariationTitle as [VariationTitle],
				a.Price as [Price],
				a.CurrencyId as [CurrencyId],
				1 as [OnMarket],
			ROW_NUMBER() OVER (order by a.[ItemOnSaleId]) AS RowNumber
			from @pItemOnSaleTable a
	)

	SELECT *
	from PagedQuery
	where RowNumber  between @RecStart and @RecEnd
	order by RowNumber ASC;



return

/*

*/



GO


