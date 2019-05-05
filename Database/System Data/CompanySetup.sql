declare @pCompanyName nvarchar(256) = 'FL Miami'
declare @pContactFirstName nvarchar(256) = 'Yi'
declare @pContactLastName nvarchar(256) = 'Yang'
declare @pCompanyCode nvarchar(256) = 'HOME'
declare @pPhoneNumber nvarchar(256) = '9999999999'
declare @pPhoneNumberCountryId int = 183
declare @pPhoneNumber2 nvarchar(256) = '9999999999'
declare @pPhoneNumberCountryId2 int = 183
--select * from Country
declare @pEmail nvarchar(256) = 'yangyi@ant-oto.com'
declare @pFax nvarchar(256) = ''
declare @pAddress1 nvarchar(256) = '1619 Orion ln'
declare @pAddress2 nvarchar(256) = ''
declare @pCity nvarchar(256) = 'Weston'
declare @pDistrict nvarchar(256) = ''
declare @pState nvarchar(256) = 'FL'
declare @pZip nvarchar(64) = '33327'
declare @pCountryId int = 183
declare @pTime datetime = getutcdate()

declare @pAddressId int = 0
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

declare @pPhoneNumberId2 int = 0
insert into dbo.PhoneNumber 
(
	[CountryId],
	[PhoneNumber],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pPhoneNumberCountryId2, @pPhoneNumber2, @pTime, @pTime, 1, 1

select @pPhoneNumberId2 = SCOPE_IDENTITY()

if(@pPhoneNumberId > 0 and @pPhoneNumberId2 > 0 and @pAddressId > 0)
begin
	declare @pCompanyId int = 0
	insert into [dbo].[Company]
	(
		[CompanyName],
		[CompanyCode],
		[Active],
		[ContactFirstName],
		[ContactLastName],
		[AddressId],
		[PhoneNumberId],
		[PhoneNumberId2],
		[Fax],
		[Email],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	@pCompanyName, @pCompanyCode, 1, @pContactFirstName, @pContactLastName, 
			@pAddressId, @pPhoneNumberId, @pPhoneNumberId2, @pFax, @pEmail, @pTime,
			@pTime, 1, 1
	select @pCompanyId = SCOPE_IDENTITY()
	select * from Company where Id = @pCompanyId

	--Insert Role
	declare @pSecRoleId int = 0
	exec [dbo].[sp_Role_Update] 
	@pSecRoleId output,
	N'管理员',
	0,
	0,
	1,
	@pCompanyId, 
	0,
	1,
	1
	select @pSecRoleId = 0
	exec [dbo].[sp_Role_Update] 
	@pSecRoleId output,
	N'终端用户',
	0,
	0,
	1,
	@pCompanyId, 
	0,
	1,
	1

	select @pSecRoleId = 0
	exec [dbo].[sp_Role_Update] 
	@pSecRoleId output,
	N'采购管理员',
	0,
	0,
	1,
	@pCompanyId, 
	0,
	1,
	1
	

	select @pSecRoleId = 0
	exec [dbo].[sp_Role_Update] 
	@pSecRoleId output,
	N'仓库管理员',
	0,
	0,
	1,
	@pCompanyId, 
	0,
	1,
	1


	select @pSecRoleId = 0
	exec [dbo].[sp_Role_Update] 
	@pSecRoleId output,
	N'广告管理员',
	0,
	0,
	1,
	@pCompanyId, 
	0,
	1,
	1
end