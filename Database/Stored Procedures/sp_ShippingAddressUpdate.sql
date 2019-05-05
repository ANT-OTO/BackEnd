IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingAddressUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingAddressUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingAddressUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingAddressUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingAddressUpdate] 
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
	@pShippingAddressId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	declare @pAddressId int = 0
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
			1 as [LastUpdateBy],
			1 as [LastUpdateByType]
	if(@@ROWCOUNT > 0)
	begin
		select @pAddressId = SCOPE_IDENTITY()
	end
	update a
	set a.AddressId = @pAddressId,
		a.ContactPersonFirstName = @pContactName,
		a.ContactPersonLastName = @pContactLastName,
		a.ContactPersonPhoneNumberCountryId = @pContactPhoneCountryId,
		a.ContactPersonPhoneNumber = @pContactPhoneNumber,
		a.LastUpdate = @pTime,
		a.LastUpdateBy = 1,
		a.LastUpdateByType = 1
	from ShippingAddress a
	where a.Id = @pShippingAddressId

	


return

/*

*/



GO


