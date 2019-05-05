IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CompanyFromAddressSubmitUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CompanyFromAddressSubmitUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CompanyFromAddressSubmitUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CompanyFromAddressSubmitUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CompanyFromAddressSubmitUpdate] 
	@pCompanyId int,
	@pContactName nvarchar(256),
	@pContactLastName nvarchar(256),
	@pContactPhoneNumber nvarchar(256),
	@pContactPhoneCountryId int,
	@pAddress1 nvarchar(256),
	@pAddress2 nvarchar(256),
	@pCity nvarchar(256),
	@pState nvarchar(64),
	@pZip nvarchar(64),
	@pCountryId int,
	@pDefaultShipping bit,
	@pAvailable bit,
	@pUpdateUserId int,
	@pCompanyFromAddressId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	declare @pAddressId int = 0
	
	if(isnull(@pCompanyFromAddressId, 0) > 0)
	begin
		if(exists(
			select *
			from CompanyFromAddress a (nolock)
			where a.CompanyId = @pCompanyId
			and a.Id = @pCompanyFromAddressId
		))
		begin
			if(isnull(@pAvailable, 1) = 1)
			begin
				select @pAddressId = a.AddressId
				from CompanyFromAddress a (nolock)
				where a.CompanyId = @pCompanyId
				and a.Id = @pCompanyFromAddressId

				update a
				set a.Address1 = @pAddress1,
					a.Address2 = isnull(@pAddress2, ''),
					a.City = @pCity,
					a.CountryId = @pCountryId,
					a.District = '',
					a.LastUpdate = @pTime,
					a.LastUpdateBy = @pUpdateUserId,
					a.LastUpdateByType = 1,
					a.State = @pState,
					a.Zip = @pZip
				from [Address] a
				where a.Id = @pAddressId

				update a
				set a.[ContactPersonFirstName] = @pContactName,
					a.[ContactPersonLastName] = @pContactLastName,
					a.[ContactPersonPhoneNumber] = @pContactPhoneNumber,
					a.[ContactPersonPhoneNumberCountryId] = @pContactPhoneCountryId,
					a.Available = isnull(@pAvailable, 1),
					a.LastUpdateBy = @pUpdateUserId,
					a.LastUpdate = 1
				from CompanyFromAddress a
				where a.Id = @pCompanyFromAddressId
			end
			else
			begin
				update a
				set a.Available = @pAvailable,
					a.LastUpdateBy = @pUpdateUserId,
					a.LastUpdate = 1
				from CompanyFromAddress a
				where a.Id = @pCompanyFromAddressId
			end
			
		end
		else
		begin
			select @pCompanyFromAddressId = 0
		end
	end
	else if (isnull(@pCompanyFromAddressId, 0) = 0)
	begin
		if(isnull(@pCompanyId, 0) > 0)
		begin
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
					isnull(@pAddress2, '') as [Address2],
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
				select @pAddressId = SCOPE_IDENTITY()
			end
			insert into CompanyFromAddress
			(
				CompanyId,
				[AddressId],
				[ContactPersonFirstName],
				[ContactPersonLastName],
				[ContactPersonPhoneNumber],
				[ContactPersonPhoneNumberCountryId],
				[Available],
				[CreateDate],
				[LastUpdate],
				[LastUpdateBy],
				[LastUpdateByType]
			)
			select	@pCompanyId,
					@pAddressId,
					@pContactName,
					@pContactLastName,
					@pContactPhoneNumber,
					@pContactPhoneCountryId,
					isnull(@pAvailable, 1),
					@pTime,
					@pTime,
					@pUpdateUserId,
					1
			if(@@ROWCOUNT > 0)
			BEGIN
				select @pCompanyFromAddressId = SCOPE_IDENTITY()
			END
		end
	end
	if(@pDefaultShipping = 1)
	begin
		if(exists(
			select *
			from CompanyFromAddress a (nolock)
				inner join CompanyFromAddressDefault b (nolock) on a.Id = b.CompanyFromAddressId
				inner join Company c (nolock) on a.CompanyId = c.Id and b.CompanyId = c.Id
			where a.CompanyId = 1
		))
		begin
			update a
			set a.CompanyFromAddressId = @pCompanyFromAddressId,
				a.Available = 1,
				a.LastUpdate = @pTime,
				a.LastUpdateBy = 1,
				a.LastUpdateByType = 1
			from CompanyFromAddressDefault a 
			where a.CompanyId = @pCompanyId
		end
		else
		begin
			--select * from CompanyFromAddressDefault
			insert into CompanyFromAddressDefault
			(
				CompanyId,
				CompanyFromAddressId,
				Available,
				CreateDate,
				LastUpdate,
				LastUpdateBy,
				LastUpdateByType
			)
			select @pCompanyId, @pCompanyFromAddressId, 1, @pTime, @pTime, 1, 1
		end
	end
	else
	begin
		update a
		set a.Available = 0,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = 1,
			a.LastUpdateByType = 1
		from CompanyFromAddressDefault a 
		where a.CompanyId = @pCompanyId
		and a.Available = 1
		and a.CompanyFromAddressId = @pCompanyFromAddressId
	end

return

/*

*/



GO


