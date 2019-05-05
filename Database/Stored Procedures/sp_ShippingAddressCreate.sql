IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingAddressCreate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingAddressCreate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingAddressCreate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingAddressCreate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingAddressCreate] 
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
	insert into  [dbo].[ShippingAddress]
	(
		[AddressId],
		[ContactPersonFirstName],
		[ContactPersonLastName],
		[ContactPersonPhoneNumber],
		[ContactPersonPhoneNumberCountryId],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy] ,
		[LastUpdateByType]
	)
	select  @pAddressId,
			@pContactName,
			@pContactLastName,
			@pContactPhoneNumber,
			@pContactPhoneCountryId,
			1,
			@pTime,
			@pTime,
			1,
			1
	if(@@ROWCOUNT > 0)
	BEGIN
		select @pShippingAddressId = SCOPE_IDENTITY()
	END

	


return

/*

*/



GO


