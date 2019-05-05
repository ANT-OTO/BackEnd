IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_LogisticCompanyUserUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_LogisticCompanyUserUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_LogisticCompanyUserUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_LogisticCompanyUserUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_LogisticCompanyUserUpdate] 
	@pCompanyId int,
	@pCompanyName nvarchar(256),
	@pContactFirstName nvarchar(256),
	@pContactLastName nvarchar(256),
	@pCompanyCode nvarchar(256),
	@pPhoneNumber nvarchar(256),
	@pPhoneNumberCountryId int,
--select * from Country
	@pEmail nvarchar(256),
	@pFax nvarchar(256),
	@pAddress1 nvarchar(256),
	@pAddress2 nvarchar(256),
	@pCity nvarchar(256),
	@pDistrict nvarchar(256),
	@pState nvarchar(256),
	@pZip nvarchar(64),
	@pCountryId int,
	@pUserLoginName nvarchar(256),
	@pPassword nvarchar(256),
	@pAvailable bit,
	@pCustomerCompanyId int output,
	@pLastUpdateUserId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	declare @pAddressId int = 0
	select @pAddress1 = isnull(@pAddress1, '')
	select @pAddress2 = isnull(@pAddress2, '')
	select @pCity = isnull(@pCity, '')
	select @pDistrict = isnull(@pDistrict, '')
	select @pState = isnull(@pState, '')
	select @pZip = isnull(@pZip, '')
	select @pCountryId = isnull(@pCountryId, 183)
	insert into dbo.[Address]
	(
		[Address1],
		[Address2],
		[City],
		[District],
		[State],
		[Zip],
		[CountryId],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select @pAddress1, @pAddress2, @pCity, @pDistrict, @pState, @pZip, @pCountryId, @pTime, @pTime, 1, 1

	select @pAddressId = SCOPE_IDENTITY()

	declare @pPhoneNumberId int = 0
	insert into dbo.PhoneNumber 
	(
		[CountryId],
		[PhoneNumber],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select @pPhoneNumberCountryId, @pPhoneNumber, @pTime, @pTime, 1, 1

	select @pPhoneNumberId = SCOPE_IDENTITY()

	update a
	set a.CompanyName = @pCompanyName,
		a.CompanyCode = @pCompanyCode,
		a.ContactFirstName = @pContactFirstName,
		a.ContactLastName = @pContactLastName,
		a.AddressId = @pAddressId,
		a.Email = @pEmail,
		a.Fax = @pFax,
		a.PhoneNumberId = @pPhoneNumberId,
		a.Active = isnull(@pAvailable, 1)
	from Company a
	where a.Id = @pCustomerCompanyId

		
	declare @pSecRoleId int = 0
	select @pSecRoleId = a.Id
	from SecRole a (nolock)
		inner join SecRoleCompany b (nolock) on a.Id = b.SecRoleId
	where b.CompanyId = @pCustomerCompanyId
	and a.RoleName = N'管理员'

	declare @pUserId int = 0
	select @pUserId = a.UserId
	from SecRoleUser a (nolock)
		inner join SecRole b (nolock) on a.SecRoleId = b.Id
	where a.SecRoleId = @pSecRoleId
	order by a.CreateDate desc

	update a
	set a.FirstName = @pContactFirstName,
		a.LastName = @pContactLastName,
		a.Email = @pEmail,
		a.AddressId = @pAddressId,
		a.Available = isnull(@pAvailable, 1),
		a.Password = case when isnull(@pPassword, '') = '' then a.Password else @pPassword end,
		a.LoginName = @pUserLoginName,
		a.PhoneNumberId = @pPhoneNumberId
	from [User] a
	where a.Id = @pUserId

return

/*

*/



GO


