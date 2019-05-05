IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CustomerAddressSubmitUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CustomerAddressSubmitUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CustomerAddressSubmitUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CustomerAddressSubmitUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CustomerAddressSubmitUpdate] 
	@pCustomerId int,
	@pContactName nvarchar(256),
	@pContactLastName nvarchar(256),
	@pContactPhoneNumber nvarchar(256),
	@pContactPhoneCountryId int,
	@pAddress1 nvarchar(256),
	@pAddress2 nvarchar(256),
	@pCity nvarchar(256),
	@pState nvarchar(64),
	@pZip nvarchar(64),
	@pDefaultShipping bit,
	@pCountryId int,
	@pAvailable bit,
	@pUpdateUserId int,
	@pCompanyId int,
	@pCustomer_AddressId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	declare @pAddressId int = 0
	
	if(isnull(@pCustomer_AddressId, 0) > 0)
	begin
		if(exists(
			select *
			from Customer_Address a (nolock)
			where a.CustomerId = @pCustomerId
			and a.Id = @pCustomer_AddressId
		))
		begin
			if(isnull(@pAvailable, 1) = 1)
			begin
				select @pAddressId = a.AddressId
				from Customer_Address a (nolock)
				where a.Id = @pCustomer_AddressId

				update a
				set a.Address1 = isnull(@pAddress1, ''),
					a.Address2 = isnull(@pAddress2, ''),
					a.City = isnull(@pCity, ''),
					a.CountryId = isnull(@pCountryId, 37),
					a.District = '',
					a.LastUpdate = @pTime,
					a.LastUpdateBy = isnull(@pUpdateUserId, 1),
					a.LastUpdateByType = 1,
					a.State = @pState,
					a.Zip = @pZip
				from [Address] a
				where a.Id = @pAddressId

				update a
				set a.DefaultShipping = @pDefaultShipping,
					a.[ContactPersonFirstName] = isnull(@pContactName, ''),
					a.[ContactPersonLastName] = isnull(@pContactLastName, ''),
					a.[ContactPersonPhoneNumber] = isnull(@pContactPhoneNumber, ''),
					a.[ContactPersonPhoneNumberCountryId] = isnull(@pContactPhoneCountryId, 37),
					a.Available = isnull(@pAvailable, 1),
					a.LastUpdateBy = isnull(@pUpdateUserId, 1),
					a.LastUpdate = 1
				from Customer_Address a
				where a.Id = @pCustomer_AddressId

				if(@pDefaultShipping = 1 and isnull(@pAvailable, 1) = 1)
				begin
					update a
					set a.DefaultShipping = 0,
						a.LastUpdate = @pTime,
						a.LastUpdateBy = isnull(@pUpdateUserId, 1),
						a.LastUpdateByType = 1
					from Customer_Address a
					where a.CustomerId = @pCustomerId
					and a.Id <> @pCustomer_AddressId
					and a.DefaultShipping = 1
					and a.Available = 1
				end
			end
			else
			begin
				update a
				set a.Available = @pAvailable,
					a.LastUpdateBy = isnull(@pUpdateUserId, 1),
					a.LastUpdate = 1
				from Customer_Address a
				where a.Id = @pCustomer_AddressId
			end
			
		end
		else
		begin
			select @pCustomer_AddressId = 0
		end
	end
	else if (isnull(@pCustomer_AddressId, 0) = 0)
	begin
		if(isnull(@pCustomerId, 0) > 0)
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
			select	isnull(@pAddress1, '') as [Address1],
					isnull(@pAddress2, '') as [Address2],
					isnull(@pCity, '') as [City],
					'' as [District],
					isnull(@pState, '') as [State],
					isnull(@pZip, '') as [Zip],
					isnull(@pCountryId, 37) as [CountryId],
					@pTime as [CreateDate],
					@pTime as [LastUpdate],
					isnull(@pUpdateUserId, 1) as [LastUpdateBy],
					1 as [LastUpdateByType]
			if(@@ROWCOUNT > 0)
			begin
				select @pAddressId = SCOPE_IDENTITY()
			end
			insert into Customer_Address
			(
				CustomerId,
				[AddressId],
				[ContactPersonFirstName],
				[ContactPersonLastName],
				[ContactPersonPhoneNumber],
				[ContactPersonPhoneNumberCountryId],
				[DefaultShipping],
				[Available],
				[CreateDate],
				[LastUpdate],
				[LastUpdateBy],
				[LastUpdateByType]
			)
			select	@pCustomerId,
					@pAddressId,
					isnull(@pContactName, ''),
					isnull(@pContactLastName, ''),
					isnull(@pContactPhoneNumber, ''),
					isnull(@pContactPhoneCountryId, 37),
					isnull(@pDefaultShipping, 0),
					isnull(@pAvailable, 1),
					@pTime,
					@pTime,
					isnull(@pUpdateUserId, 1),
					1
			if(@@ROWCOUNT > 0)
			BEGIN
				select @pCustomer_AddressId = SCOPE_IDENTITY()
				if(@pDefaultShipping = 1 and @pAvailable = 1)
				begin
					update a
					set a.DefaultShipping = 0,
						a.LastUpdate = @pTime,
						a.LastUpdateBy = isnull(@pUpdateUserId, 1),
						a.LastUpdateByType = 1
					from Customer_Address a
					where a.CustomerId = @pCustomerId
					and a.Id <> @pCustomer_AddressId
					and a.DefaultShipping = 1
					and a.Available = 1
				end
			END
		end
	end

	


return

/*

*/



GO


