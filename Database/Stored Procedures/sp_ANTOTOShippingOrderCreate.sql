IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ANTOTOShippingOrderCreate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ANTOTOShippingOrderCreate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ANTOTOShippingOrderCreate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ANTOTOShippingOrderCreate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ANTOTOShippingOrderCreate] 
	@pCustomerId int,
	@pCustomerOrderId int,
	@pReferenceOrderCode nvarchar(256),
	@pCompanyFromAddressId int,
	@pCustomer_AddressId int,
	@pShippingChannelId int,
	@pPrice decimal(10,2),
	@pCurrencyId int,
	@pTotalWeight decimal(10,2),
	@pWeightUnitId int,
	@pShippingOrderStatusCodeId int,
	@pUserId int,
	@pSourceCompanyId int,
	@pHandlerCompanyId int,
	@pShippingOrderId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	declare @pFromAddressId int = 0
	insert into [Address]
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
	select b.Address1, isnull(b.Address2,''), b.City, b.District, b.State, b.Zip, b.CountryId, @pTime, @pTime, 1, 1
	from CompanyFromAddress a (nolock)
		inner join [Address] b (nolock) on a.AddressId = b.Id
	where a.Id = @pCompanyFromAddressId

	select @pFromAddressId = SCOPE_IDENTITY()
	declare @pFromShippingAddressId int = 0
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
	select	@pFromAddressId, a.ContactPersonFirstName, a.ContactPersonLastName, a.ContactPersonPhoneNumber,
			a.ContactPersonPhoneNumberCountryId, 1, @pTime, @pTime, 1, 1
	from CompanyFromAddress a (nolock)
	where a.Id = @pCompanyFromAddressId

	select @pFromShippingAddressId = SCOPE_IDENTITY()


	declare @pToAddressId int = 0
	insert into [Address]
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
	select b.Address1, isnull(b.Address2,''), b.City, b.District, b.State, b.Zip, b.CountryId, @pTime, @pTime, 1, 1
	from Customer_Address a (nolock)
		inner join [Address] b (nolock) on a.AddressId = b.Id
	where a.Id = @pCustomer_AddressId

	select @pToAddressId = SCOPE_IDENTITY()
	declare @pToShippingAddressId int = 0
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
	select	@pToAddressId, a.ContactPersonFirstName, a.ContactPersonLastName, a.ContactPersonPhoneNumber,
			a.ContactPersonPhoneNumberCountryId, 1, @pTime, @pTime, 1, 1
	from Customer_Address a (nolock)
	where a.Id = @pCustomer_AddressId

	select @pToShippingAddressId = SCOPE_IDENTITY()

	if(isnull(@pFromShippingAddressId, 0) = 0 or isnull(@pToShippingAddressId, 0) = 0 )
	begin
		return
	end


	insert into [dbo].[ShippingOrder]
	(
		[CustomerId],
		[CustomerOrderId],
		[ReferenceOrderCode],
		[ShippingFromAddressId],
		[ShippingToAddressId],
		[ShippingChannelId],
		[Price],
		[CurrencyId],
		[TotalWeight],
		[WeightUnitId],
		[ShippingOrderStatusCodeId], --select * from CodeList where Category = 'ShippingOrderStatus'
		[ShippingOrderCode],
		[UserId],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	@pCustomerId, @pCustomerOrderId, @pReferenceOrderCode, @pFromShippingAddressId, @pToShippingAddressId,
			@pShippingChannelId, @pPrice, @pCurrencyId, @pTotalWeight, @pWeightUnitId, 1, '',
			@pUserId, @pTime, @pTime, 1, 1
	
	
	select @pShippingOrderId = SCOPE_IDENTITY()

	declare @pShippingOrderCode nvarchar(256) = 'AS' + RIGHT('00000000'+CAST(@pShippingOrderId AS VARCHAR(8)),8)

	update a
	set a.ShippingOrderCode = @pShippingOrderCode
	from ShippingOrder a
	where a.Id = @pShippingOrderId

	--ID
	declare @pShippingOrderIdentityProfileId int = 0
	insert into ShippingOrderIdentityProfile
	(
		[ShippingOrderId],
		[IdentityNumber],
		[Name],
		[PhoneNumber],
		[Available]
	)
	select	@pShippingOrderId,
			b.CustomerNationalId,
			a.ContactPersonFirstName + '' + a.ContactPersonLastName,
			a.ContactPersonPhoneNumber,
			c.Available 
	from Customer_Address a (nolock)
		inner join Customer_AddressID b (nolock) on a.Id = b.Customer_AddressId
		inner join Customer_AddressResource c (nolock) on a.Id = c.Customer_AddressId
	where a.Id = @pCustomer_AddressId
	and b.Available = 1
	and c.Available = 1
	and a.Available = 1
	select @pShippingOrderIdentityProfileId = SCOPE_IDENTITY()
	insert into [dbo].[ShippingOrderIdentityProfileFiles]
	(
		[ShippingOrderIdentityProfileId],
		[FileId],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select @pShippingOrderIdentityProfileId, c.FileId, 1, @pTime, @pTime, 1, 1
	from Customer_Address a (nolock)
		inner join Customer_AddressID b (nolock) on a.Id = b.Customer_AddressId
		inner join Customer_AddressResource c (nolock) on a.Id = c.Customer_AddressId
	where a.Id = @pCustomer_AddressId
	and b.Available = 1
	and c.Available = 1
	and a.Available = 1
	--Company Info

	insert into  [dbo].[ShippingOrderCompany]
	(
		[ShippingOrderId],
		[SourceCompanyId],
		[HandlerCompanyId],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	@pShippingOrderId,
			@pSourceCompanyId,
			@pHandlerCompanyId,
			@pTime,
			@pTime,
			1,1

	


return

/*

*/



GO


