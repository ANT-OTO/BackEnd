IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Customer_Create]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Customer_Create] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Customer_Create] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Customer_Create] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Customer_Create] 
	@pFirstName nvarchar(256),
	@pLastName nvarchar(256),
	@pPhoneNumber nvarchar(256),
	@pCountryId int,
	@pNickName nvarchar(256),
	@pEmail nvarchar(256),
	@pLoginName nvarchar(256),
	@pPassword nvarchar(256),
	@pDescription nvarchar(256),
	@pAvailable bit,
	@pLastUpdateBy int,
	@pCompanyId int,
	@pThirdPartyUId nvarchar(256),
	@pThirdPartyNickName nvarchar(256),
	@pCustomerTypeCodeId int,
	@pAvatarUrl nvarchar(256),
	@pGender nvarchar(64),
	@pCustomerId int output

AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	declare @pNewId nvarchar(256) = ''
	select @pNewId = replace(NEWID(),'-','')
	if(isnull(@pLoginName, '') = '')
	begin
		select @pLoginName = ''
	end
	if(isnull(@pFirstName, '') = '')
	begin
		select @pFirstName = @pNickName
	end
	if(isnull(@pLastName, '') = '')
	begin
		select @pLastName = ''
	end
	if(isnull(@pPhoneNumber, '') = '')
	begin
		select @pPhoneNumber = ''
	end
	if(isnull(@pCountryId, 0) = 0)
	begin
		select @pCountryId = 37
	end
	if(isnull(@pEmail, '') = '')
	begin
		select @pEmail = ''
	end
	if(isnull(@pPassword, '') = '')
	begin
		select @pPassword = ''
	end
	if(isnull(@pDescription, '') = '')
	begin
		select @pDescription = ''
	end

	if(exists(
		select * from Customers a (nolock)
			inner join CustomerCompany b (nolock) on a.Id = b.CustomerId
		where a.LoginName = @pLoginName
		and a.Available = 1
		and b.CompanyId = @pCompanyId
	))
	begin
		select @pCustomerId = 0
		return
	end

	if(exists(
		select * from Customers a (nolock)
		where a.LoginName = @pLoginName
		and a.Email = @pEmail
		and a.Available = 1
	))
	begin
		select @pCustomerId = a.Id
		from Customers a (nolock)
		where a.LoginName = @pLoginName
		and a.Email = @pEmail
		insert into CustomerCompany
		(
			CustomerId,
			CompanyId,
			Available,
			CreateDate,
			LastUpdate,
			LastUpdateBy,
			LastUpdateByType
		)
		select @pCustomerId, @pCompanyId, 1, @pTime, @pTime, @pLastUpdateBy, 1
		return
	end

	insert into [dbo].[Customers]
	(
		[FirstName],
		[LastName],
		[NickName],
		[PhoneNumber],
		[CountryId],
		[Email],
		[LoginName],
		[Password],
		[Description],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select isnull(@pFirstName, ''), isnull(@pLastName, ''), 
		   @pNickName, @pPhoneNumber, @pCountryId, @pEmail, 
		   @pLoginName, @pPassword, @pDescription, 1,
		   @pTime, @pTime, @pLastUpdateBy, 1

	select @pCustomerId = SCOPE_IDENTITY()
	if(isnull(@pLoginName, '') = '')
	begin
		update a
		set a.LoginName = 'C' + right('000000' + cast(a.Id as varchar(6)), 6)
		from Customers a
		where a.Id = @pCustomerId
	end

	insert into CustomerCompany
	(
		CustomerId,
		CompanyId,
		Available,
		CreateDate,
		LastUpdate,
		LastUpdateBy,
		LastUpdateByType
	)
	select @pCustomerId, @pCompanyId, 1, @pTime, @pTime, @pLastUpdateBy, 1
	
	if(isnull(@pCustomerTypeCodeId, 0) > 0)
	begin
		insert into CustomerThirdParty
		(
			[CustomerId],
			[CustomerTypeCodeId], -- 1 Taobao 2 Wechat
			[UnifiedId],
			[AvatarUrl],
			[NickName],
			[GenderCode],
			[BuyerDescription],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	@pCustomerId,
				@pCustomerTypeCodeId,
				@pThirdPartyUId,
				@pAvatarUrl,
				@pThirdPartyNickName,
				@pGender,
				@pDescription,
				@pTime,
				@pTime,
				1,
				1

	end


return

/*

*/



GO


