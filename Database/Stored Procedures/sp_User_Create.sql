IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_User_Create]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_User_Create] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_User_Create] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_User_Create] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_User_Create] 
	@pUserId int output,
	@pRoleId int,
	@pFirstName nvarchar(256),
	@pLastName nvarchar(256),
	@pEmail nvarchar(256),
	@pLoginName nvarchar(256),
	@pPassword nvarchar(256),
	@pPhoneNumber nvarchar(256),
	@pPhoneCountryId int,
	@pAddress1 nvarchar(256),
	@pAddress2 nvarchar(256),
	@pCity nvarchar(256),
	@pState nvarchar(64),
	@pZip nvarchar(64),
	@pCountryId int,
	@pUpdateUserId int,
	@pCompanyId int,
	@pAvailable bit,
	@pError nvarchar(256) output
AS

SET NOCOUNT ON

	declare @pTime datetime = getutcdate()
	
    
	if(@pUserId > 0)
	begin
		if(exists(
			select * from [User] a (nolock)
				where a.LoginName = @pLoginName
				and a.Id <> @pUserId
		))
		begin
			select @pError = 'Account already exists.'
			return
		end
		update a
		set a.FirstName = @pFirstName,
			a.LastName = @pLastName,
			a.Email = @pEmail,
			a.LoginName = @pLoginName,
			a.Password = case when @pPassword is not null then @pPassword else a.Password end,
			a.Available = @pAvailable,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = @pUpdateUserId,
			a.LastUpdateByType = 1
		from [User] a
		where a.Id = @pUserId

		declare @pCurrentRoleId int = 0
		select @pCurrentRoleId = a.Id
		from SecRoleUser a (nolock)
			inner join [User] b (nolock) on a.UserId = b.Id
			inner join CompanyUser c (nolock) on b.Id = c.UserId
			inner join SecRoleCompany d (nolock) on c.CompanyId = d.CompanyId and a.SecRoleId = d.SecRoleId
		where c.CompanyId = @pCompanyId
		and b.Id = @pUserId
		and a.Available = 1
		and d.Available = 1
		and c.Available = 1

		if(isnull(@pCurrentRoleId, 0) > 0)
		begin
			update a
			set a.Available = 0,
				a.LastUpdate = @pTime,
				a.LastUpdateBy = @pUpdateUserId,
				a.LastUpdateByType = 1
				from SecRoleUser a 
			where a.SecRoleId = @pCurrentRoleId
			and a.UserId = @pUserId
		end

		insert into SecRoleUser 
		(
			[SecRoleId],
			[UserId],
			[Available],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select a.SecRoleId, a.UserId, a.Available, a.CreateDate, a.LastUpdate, a.LastUpdateBy, a.LastUpdateByType
		from
		(
			select	@pRoleId as [SecRoleId],
					@pUserId as [UserId],
					1 as [Available],
					@pTime as [CreateDate],
					@pTime as [LastUpdate],
					@pUpdateUserId as [LastUpdateBy],
					1 as [LastUpdateByType]
		) a
		left join SecRoleUser z (nolock) on a.SecRoleId = z.SecRoleId and a.UserId = z.UserId
		where z.Id is null

		update a
		set a.Available = 1,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = @pUpdateUserId,
			a.LastUpdateByType = 1
		from SecRoleUser a
		where a.SecRoleId = @pRoleId
		and a.UserId = @pUserId


	end
	else
	begin
		if(exists(
			select * from [User] a (nolock)
				where a.LoginName = @pLoginName
		))
		begin
			select @pError = 'Account already exists.'
			return
		end
		declare @AddressId int = 0
		insert into [dbo].[Address]
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
		select	@pAddress1 as [Address1],
				@pAddress2 as [Address2],
				@pCity as [City],
				'' as [District],
				@pState as [State],
				@pZip as [Zip],
				@pCountryId as [CountryId],
				@pTime as [CreateDate],
				@pTime as [LastUpdate],
				@pUpdateUserId as [LastUpdateBy],
				1 as [LastUpdateByType]
		if(@@ROWCOUNT > 0)
		begin
			select @AddressId = SCOPE_IDENTITY()

			declare @PhoneNumberId int = 0
			insert into [dbo].[PhoneNumber]
			(
				[CountryId],
				[PhoneNumber],
				[CreateDate],
				[LastUpdate],
				[LastUpdateBy],
				[LastUpdateByType]
			)
			select	@pPhoneCountryId as [CountryId],
					@pPhoneNumber as [PhoneNumber],
					@pTime as [CreateDate],
					@pTime as [LastUpdate],
					@pUpdateUserId as [LastUpdateBy],
					1 as [LastUpdateByType]
			if(@@ROWCOUNT > 0)
			begin
				select @PhoneNumberId = SCOPE_IDENTITY()
				insert into dbo.[User]
				(
					[FirstName],
					[LastName],
					[Email],
					[LoginName],
					[Password],
					[PhoneNumberId],
					[AddressId],
					[Available],
					[CreateDate],
					[LastUpdate]
				)
				select	@pFirstName, @pLastName, @pEmail, @pLoginName, @pPassword, @PhoneNumberId,
						@AddressId, 1, @pTime, @pTime

				if(@@ROWCOUNT > 0)
				begin
					select @pUserId = SCOPE_IDENTITY()
					insert into CompanyUser
					(
						[CompanyId],
						[UserId],
						[Available],
						[CreateDate],
						[LastUpdate],
						[LastUpdateBy],
						[LastUpdateByType]
					)
					select @pCompanyId, @pUserId, 1, @pTime, @pTime, @pUpdateUserId, 1

					insert into SecRoleUser
					(
						[SecRoleId],
						[UserId],
						[Available],
						[CreateDate],
						[LastUpdate],
						[LastUpdateBy],
						[LastUpdateByType]
					)
					select	@pRoleId,
							@pUserId,
							1,
							@pTime,
							@pTime,
							@pUpdateUserId,
							1

				end
				else
				begin
					select @pError = 'User create fail'
					return
				end

			end
			else
			begin
				select @pError = 'Phone number not valid.'
				return
			end
		end
		else
		begin
			select @pError = 'Address not valid.'
			return
		end
	end

	

return

/*

*/



GO


