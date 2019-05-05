IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_User_Search]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_User_Search] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_User_Search] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_User_Search] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_User_Search] 
	@pUserFirstName nvarchar(50),
	@pUserLastName nvarchar(50),
	@pRoleId int,
	@pEmail nvarchar(256),
	@pCompanyId int,
	@pAvailable bit,
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
	select @pUserFirstName = isnull(@pUserFirstName, '')
    select @pUserFirstName = rtrim(ltrim(@pUserFirstName))


	declare @ByUserFirstName smallint = 0

	begin 

		if( len(@pUserFirstName) > 0 )
		begin
			select @ByUserFirstName = 1
		end

	end
	select @pUserLastName = isnull(@pUserLastName, '')
	select @pUserLastName = rtrim(ltrim(@pUserLastName))


	declare @ByUserLastName smallint = 0

	begin 

		if( len(@pUserLastName) > 0 )
		begin
			select @ByUserLastName = 1
		end

	end
	select @pEmail = isnull(@pEmail, '')
	select @pEmail = rtrim(ltrim(@pEmail))


	declare @ByEmail smallint = 0

	begin 

		if( len(@pEmail) > 0 )
		begin
			select @ByEmail = 1
		end

	end

select @pRoleId = isnull(@pRoleId, 0)
	

select @Total = count(1) 
--select * 
from [User] a
	inner join CompanyUser b (nolock) on a.Id = b.UserId
	inner join SecRoleUser c (nolock) on a.Id = c.UserId
	inner join SecRoleCompany d (nolock) on c.SecRoleId = d.SecRoleId and d.CompanyId = b.CompanyId
where (@ByUserFirstName = 0 or a.FirstName like '%' + @pUserFirstName + '%')
and (@ByEmail = 0 or a.Email like '%' + @pEmail + '%')
and (@ByUserLastName = 0 or a.LastName like '%' + @pUserLastName + '%')
and (@pRoleId = 0 or c.SecRoleId = @pRoleId)
and a.Available = @pAvailable
and b.CompanyId = @pCompanyId
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
		select a.Id, a.FirstName, a.LastName, a.Email, a.LoginName,
			ROW_NUMBER() OVER (order by a.FirstName, a.Id) AS RowNumber
		--select *
		from [User] a
		inner join CompanyUser b (nolock) on a.Id = b.UserId
		inner join SecRoleUser c (nolock) on a.Id = c.UserId
		inner join SecRoleCompany d (nolock) on c.SecRoleId = d.SecRoleId and d.CompanyId = b.CompanyId
		where (@ByUserFirstName = 0 or a.FirstName like '%' + @pUserFirstName + '%')
		and (@ByEmail = 0 or a.Email like '%' + @pEmail + '%')
		and (@ByUserLastName = 0 or a.LastName like '%' + @pUserLastName + '%')
		and (@pRoleId = 0 or c.SecRoleId = @pRoleId)
		and a.Available = @pAvailable
		and b.CompanyId = @pCompanyId
	)

	SELECT *
	from PagedQuery
	where RowNumber  between @RecStart and @RecEnd
	order by RowNumber ASC;



return

/*

*/



GO


