IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CompanyLogisticCompanySearch]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CompanyLogisticCompanySearch] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CompanyLogisticCompanySearch] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CompanyLogisticCompanySearch] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CompanyLogisticCompanySearch] 
	@pName nvarchar(256),
	@pCompanyCode nvarchar(256),
	@pEmail nvarchar(256),
	@pUserId int,
	@pCompanyId int,
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

	select @pName = isnull(@pName, '')
	select @pEmail = isnull(@pEmail, '')
	select @pCompanyCode = isnull(@pCompanyCode, '')

	
	
	declare @pCompanyLogisticCompany Table
	(
		CompanyId int,
		UserId int,
		UserLoginName nvarchar(256),
		CompanyCode nvarchar(256),
		CompanyName nvarchar(256),
		Email nvarchar(256),
		PhoneNumber nvarchar(256),
		PhoneNumberCountryId int,
		ContactFirstName nvarchar(256),
		ContactLastName nvarchar(256),
		Address1 nvarchar(256),
		Address2 nvarchar(256) NULL,
		City nvarchar(256),
		District nvarchar(256) NULL,
		[State] nvarchar(256),
		Zip nvarchar(64),
		Fax nvarchar(256),
		CountryId int,
		Available bit
	)
	insert into @pCompanyLogisticCompany
	(
		CompanyId,
		UserId,
		UserLoginName,
		CompanyCode,
		CompanyName,
		Email,
		PhoneNumber,
		PhoneNumberCountryId,
		ContactFirstName,
		ContactLastName,
		Address1,
		Address2,
		City,
		District,
		[State],
		Zip,
		Fax,
		CountryId,
		Available
	)
	select	a.CustomerCompanyId, d.Id, d.LoginName, b.CompanyCode, b.CompanyName, b.Email,
			b2.PhoneNumber, b2.CountryId, b.ContactFirstName, b.ContactLastName, b1.Address1, b1.Address2, b1.City,
			b1.District, b1.[State], b1.Zip, b.Fax, b1.CountryId, b.Active
	from CompanyLogisticCompany a (nolock)
		inner join Company b (nolock) on a.CustomerCompanyId = b.Id
		inner join [Address] b1 (nolock) on b.AddressId = b1.Id
		inner join [PhoneNumber] b2 (nolock) on b.PhoneNumberId = b2.Id
		inner join CompanyUser c (nolock) on b.Id = c.CompanyId
		inner join [User] d (nolock) on c.UserId = d.Id
		inner join SecRoleUser e (nolock) on d.Id = e.UserId and e.Available = 1
		inner join SecRole f (nolock) on e.SecRoleId = f.Id and f.RoleName = N'管理员'
	where a.CompanyId = @pCompanyId
	and b.CompanyCode like '%'+ @pCompanyCode + '%'
	and d.Email like '%' + @pEmail + '%'
	and ((isnull(d.FirstName,'') + '' + isnull(d.LastName,'') like '%' + @pName + '%')  
	or (b2.PhoneNumber like '%' + @pName + '%' ))
	and a.Available = 1

	select @Total = count(distinct(a.CompanyId)) 
	--select * 
	from @pCompanyLogisticCompany a
	
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
		select	a.CompanyId,
				UserId,
				UserLoginName,
				CompanyCode,
				CompanyName,
				Email,
				PhoneNumber,
				PhoneNumberCountryId,
				ContactFirstName,
				ContactLastName,
				Address1,
				Address2,
				City,
				District,
				[State],
				Zip,
				Fax,
				CountryId,
				Available,
			ROW_NUMBER() OVER (order by a.CompanyId desc) AS RowNumber
			from @pCompanyLogisticCompany a
	)

	SELECT *
	from PagedQuery
	where RowNumber  between @RecStart and @RecEnd
	order by RowNumber ASC;



return

/*

*/



GO


