IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_LogisticCompanyUserCreate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_LogisticCompanyUserCreate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_LogisticCompanyUserCreate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_LogisticCompanyUserCreate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_LogisticCompanyUserCreate] 
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
	@pCustomerCompanyId int output,
	@pLastUpdateUserId int
AS

SET NOCOUNT ON
	
	declare @pTime datetime = getutcdate()
	select @pCompanyCode = replace(newid(), '-', '')
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
	select isnull(@pAddress1, ''), isnull(@pAddress2, ''), isnull(@pCity, ''), isnull(@pDistrict, ''),
	 isnull(@pState, ''), isnull(@pZip, ''), isnull(@pCountryId, 183), @pTime, @pTime, 1, 1
	 
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

	

	if(@pPhoneNumberId > 0 and @pAddressId > 0)
	begin
		
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
		select	isnull(@pContactFirstName, '') + '' + isnull(@pContactLastName,''), 
				@pCompanyCode, 1, @pContactFirstName, @pContactLastName, 
				@pAddressId, @pPhoneNumberId, null, @pFax, @pEmail, @pTime,
				@pTime, 1, 1
		select @pCustomerCompanyId = SCOPE_IDENTITY()
		--select * from Company where Id = @pCompanyId
		update a
		set a.CompanyCode = 'U' + RIGHT('00000'+CAST(@pCustomerCompanyId AS VARCHAR(5)),5)
		from Company a
		where a.Id = @pCustomerCompanyId
		insert into [dbo].[CompanyLogisticCompany]
		(
			[CompanyId],
			[CustomerCompanyId],
			[Available],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select @pCompanyId, @pCustomerCompanyId, 1, @pTime, @pTime, 1, 1

		declare @pSecFunctionId int = 0

		select @pSecFunctionId = a.Id
		from SecFunction a (nolock)
		where a.FunctionKey = 'FK_EcommerceManagement'
		
		insert into [dbo].[SecFunctionCompany]
		(
			[SecFunctionId],
			[CompanyId],
			[Available],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select @pSecFunctionId, @pCustomerCompanyId, 1, @pTime, @pTime, 1, 1

		--Insert Role
		declare @pSecRoleId int = 0
		exec [dbo].[sp_Role_Update] 
		@pSecRoleId output,
		N'管理员',
		0,
		0,
		1,
		@pCustomerCompanyId, 
		0,
		1,
		1
		--select @pSecRoleId = SCOPE_IDENTITY()

		declare @pUserId int = 0
		declare @pError nvarchar(256) = ''
		exec [dbo].[sp_User_Create] 
			@pUserId output,
			@pSecRoleId,
			@pContactFirstName,
			@pContactLastName,
			@pEmail,
			@pUserLoginName,
			@pPassword,
			@pPhoneNumber,
			@pPhoneNumberCountryId,
			@pAddress1,
			@pAddress2,
			@pCity,
			@pState,
			@pZip,
			@pCountryId,
			@pLastUpdateUserId,
			@pCustomerCompanyId,
			1,
			@pError output
			
		declare @pCompanyFromAddressId int = 0
		if(@pAddress1 is not null and len(@pAddress1) > 0)
		begin
			exec [dbo].[sp_CompanyFromAddressSubmitUpdate] 
				@pCustomerCompanyId,
				@pContactFirstName,
				@pContactLastName,
				@pPhoneNumber,
				@pPhoneNumberCountryId,
				@pAddress1,
				@pAddress2,
				@pCity,
				@pState,
				@pZip,
				@pCountryId,
				1,
				1,
				@pLastUpdateUserId,
				@pCompanyFromAddressId output
		end
		else
		begin
			select	@pAddress1 = b.Address1,
					@pAddress2 = b.Address2,
					@pCity = b.City,
					@pState = b.State,
					@pZip = b.Zip,
					@pCountryId = b.CountryId
			from Company a (nolock)
				inner join [Address] b (nolock) on a.AddressId = b.Id
			where a.Id = @pCompanyId

			exec [dbo].[sp_CompanyFromAddressSubmitUpdate] 
				@pCustomerCompanyId,
				@pContactFirstName,
				@pContactLastName,
				@pPhoneNumber,
				@pPhoneNumberCountryId,
				@pAddress1,
				@pAddress2,
				@pCity,
				@pState,
				@pZip,
				@pCountryId,
				1,
				1,
				@pLastUpdateUserId,
				@pCompanyFromAddressId output
		end
		 
		
end


return

/*

*/



GO


