IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CategorySearch]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CategorySearch] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CategorySearch] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CategorySearch] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CategorySearch] 
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


	
	if( len(@pSearchWord) = 0 )
	begin
		return
	end

	
	

	select @Total = count(distinct(a.Id)) 
	--select * 
	from Category a (nolock)
			left join CategoryKeyword b (nolock) on a.Id = b.CategoryId
			left join CompanyCategory c (nolock) on a.Id = c.CategoryId
			left join CategoryY z (nolock) on a.Id = z.CategoryId and z.SystemLanguageId = @pSystemLanguageId
			left join CategoryBrand y (nolock) on a.Id = y.CategoryId and y.Available = 1
			left join Brand x (nolock) on x.Id = y.BrandId
			left join CompanyBrand w (nolock) on w.BrandId = x.Id
		where ((c.Id is not null and c.CompanyId = @pCompanyId and c.Available = 1)
					or (c.Id is null and a.SystemCategory = 1))
			and a.Available = 1
			and (x.Id is null or ((w.Id is not null and w.CompanyId = @pCompanyId and w.Available = 1)
					or (w.Id is null and x.SystemBrand = 1)))
			and (a.Name like N'%' + @pSearchWord + N'%'
			or (b.Id is not null and b.Keyword like N'%' + @pSearchWord + N'%')
			or (x.Id is not null and x.BrandName like N'%' + @pSearchWord + N'%'))
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
		select distinct (a.Id), a.Name,
			ROW_NUMBER() OVER (order by a.Name, a.Id) AS RowNumber
		from 
		(
			select distinct(a.Id), a.Name
		--select *
		from Category a (nolock)
			left join CategoryKeyword b (nolock) on a.Id = b.CategoryId
			left join CompanyCategory c (nolock) on a.Id = c.CategoryId
			left join CategoryY z (nolock) on a.Id = z.CategoryId and z.SystemLanguageId = @pSystemLanguageId
			left join CategoryBrand y (nolock) on a.Id = y.CategoryId and y.Available = 1
			left join Brand x (nolock) on x.Id = y.BrandId
			left join CompanyBrand w (nolock) on w.BrandId = x.Id
		where ((c.Id is not null and c.CompanyId = @pCompanyId and c.Available = 1)
					or (c.Id is null and a.SystemCategory = 1))
			and a.Available = 1
			and (x.Id is null or ((w.Id is not null and w.CompanyId = @pCompanyId and w.Available = 1)
					or (w.Id is null and x.SystemBrand = 1)))
			and (a.Name like N'%' + @pSearchWord + N'%'
			or (b.Id is not null and b.Keyword like N'%' + @pSearchWord + N'%')
			or (x.Id is not null and x.BrandName like N'%' + @pSearchWord + N'%'))
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


