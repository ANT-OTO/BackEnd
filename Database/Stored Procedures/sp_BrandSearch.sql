IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_BrandSearch]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_BrandSearch] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_BrandSearch] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_BrandSearch] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_BrandSearch] 
	@pSearchWord nvarchar(256),
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
	select @pSearchWord = isnull(@pSearchWord, '')
    select @pSearchWord = rtrim(ltrim(@pSearchWord))

	select @Total = count(distinct(a.Id)) 
	--select * 
	from Brand a (nolock)
			left join CompanyBrand b (nolock) on b.BrandId = a.Id
			inner join CategoryBrand z (nolock) on a.Id = z.BrandId and z.Available = 1
			inner join Category y (nolock) on z.CategoryId = y.Id and y.Available = 1
		where ((b.Id is not null and b.CompanyId = @pCompanyId and b.Available = 1)
					or (b.Id is null and a.SystemBrand = 1))
			and ((a.BrandName like N'%' + @pSearchWord + N'%') or (y.Name like N'%' + @pSearchWord + N'%'))
			and a.Available = 1
			and y.Available = 1
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
		select distinct (a.Id), a.BrandName, a.BrandDescription, a.SystemBrand, a.CategoryId, a.CategoryName,
			ROW_NUMBER() OVER (order by a.BrandName, a.Id) AS RowNumber
		from 
		(
			select distinct(a.Id), a.BrandName, a.BrandDescription,a.SystemBrand, y.Id as CategoryId, isnull(y1.Name, y.Name) as CategoryName
		--select *
		from Brand a (nolock)
			left join CompanyBrand b (nolock) on b.BrandId = a.Id
			inner join CategoryBrand z (nolock) on a.Id = z.BrandId and z.Available = 1
			inner join Category y (nolock) on z.CategoryId = y.Id and y.Available = 1
			left join CategoryY y1 (nolock) on y.Id = y1.CategoryId and y1.SystemLanguageId = @pSystemLanguageId
		where ((b.Id is not null and b.CompanyId = @pCompanyId and b.Available = 1)
					or (b.Id is null and a.SystemBrand = 1))
			and ((a.BrandName like N'%' + @pSearchWord + N'%') or (y.Name like N'%' + @pSearchWord + N'%'))
			and a.Available = 1
			and y.Available = 1
		) a
	)

	SELECT *
	from PagedQuery
	where RowNumber  between @RecStart and @RecEnd
	order by RowNumber ASC;



return

/*

*/



GO


