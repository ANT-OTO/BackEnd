declare @pCompanyName nvarchar(256) = 'Test Company'
declare @pContactFirstName nvarchar(256) = 'Test'
declare @pContactLastName nvarchar(256) = 'Company'
declare @pCompanyCode nvarchar(256) = 'TEST'
declare @pPhoneNumber nvarchar(256) = '9999999999'
declare @pPhoneNumberCountryId int = 183
declare @pPhoneNumber2 nvarchar(256) = '9999999999'
declare @pPhoneNumberCountryId2 int = 183
--select * from Country
declare @pEmail nvarchar(256) = 'test@company.com'
declare @pFax nvarchar(256) = ''
declare @pAddress1 nvarchar(256) = 'abcdefg'
declare @pAddress2 nvarchar(256) = ''
declare @pCity nvarchar(256) = 'Davie'
declare @pDistrict nvarchar(256) = ''
declare @pState nvarchar(256) = 'FL'
declare @pZip nvarchar(64) = '33330'
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

end