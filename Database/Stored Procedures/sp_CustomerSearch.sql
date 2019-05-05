IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CustomerSearch]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CustomerSearch] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CustomerSearch] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CustomerSearch] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CustomerSearch] 
	@pSearchWord nvarchar(256),
	@pCustomerTypeCodeId int,
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
	from Customers a (nolock)
		inner join CustomerCompany b (nolock) on a.Id = b.CustomerId
		left join CustomerThirdParty z (nolock) on a.Id = z.CustomerId
	where (a.FirstName like '%' + @pSearchWord + '%'
	or a.LastName like '%' + @pSearchWord + '%'
	or (z.Id is not null and z.NickName like '%' + @pSearchWord + '%' ))
	and a.Available = 1
	and b.CompanyId = @pCompanyId
	and a.Available = 1
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
		select distinct (a.Id), a.FirstName, a.LastName, a.NickName,
				a.LoginName, a.CountryId, a.PhoneNumber, a.[Description],
				a.AvatarUrl, a.Gender,
			ROW_NUMBER() OVER (order by a.Id) AS RowNumber
		from 
		(
			select	distinct(a.Id), a.FirstName as FirstName, a.LastName as LastName, 
			a.LoginName as LoginName, isnull(z.NickName, a.NickName) as NickName,
					a.PhoneNumber as PhoneNumber, a.CountryId as CountryId,
					a.Description as [Description], isnull(z.AvatarUrl, '') as [AvatarUrl],
					isnull(z.GenderCode, '') as [Gender]
		--select * 
		from Customers a (nolock)
			inner join CustomerCompany b (nolock) on a.Id = b.CustomerId
			left join CustomerThirdParty z (nolock) on a.Id = z.CustomerId
		where (a.FirstName like '%' + @pSearchWord + '%'
			or a.LastName like '%' + @pSearchWord + '%'
			or (z.Id is not null and z.NickName like '%' + @pSearchWord + '%' ))
			and a.Available = 1
			and b.CompanyId = @pCompanyId
			and a.Available = 1
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


