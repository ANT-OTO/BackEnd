IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Customer_OrderCreate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Customer_OrderCreate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Customer_OrderCreate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Customer_OrderCreate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Customer_OrderCreate] 
	@pCustomerId int,
	@pCustomer_AddressId int,
	@pDiscountCode nvarchar(256),
	@pCompanyId int,
	@pUserId int,
	@pCustomer_OrderId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	if(exists(
		select *
		from Customer_ShoppingCart_Items a (nolock)
		where a.CustomerId = @pCustomerId
		and a.Quantity <> 0
	))
	begin
		insert into [dbo].[Customer_Orders]
		(
			[OrderCode], --Unified Order Code
			[CustomerId],
			[CustomerOrderStatusCodeId],
			[Date_Placed],
			[Date_Paid],
			[OrderDiscountId],
			[TotalPriceAmount],
			[CurrencyId],
			[SourceId],
			[SourceTable],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	'' as [OrderCode], --Unified Order Code
				@pCustomerId as [CustomerId],
				1 as [CustomerOrderStatusCodeId],
				@pTime as [Date_Placed],
				null as [Date_Paid],
				null as [OrderDiscountId],
				0.00 as [TotalPriceAmount],
				0 as [CurrencyId],
				null as [SourceId],
				null as [SourceTable],
				@pTime as [CreateDate],
				@pTime as [LastUpdate],
				@pUserId as [LastUpdateBy],
				1 as [LastUpdateByType]
		IF(@@ROWCOUNT > 0)
		BEGIN
			select @pCustomer_OrderId = SCOPE_IDENTITY()
			update a 
			set a.OrderCode =  'AO' + RIGHT('00000000000'+CAST(@pCustomer_OrderId aS VARCHAR(10)),10)
			from Customer_Orders a
			where a.Id = @pCustomer_OrderId

			insert into Customer_Order_Company
			(
				[Customer_OrderId],
				[OrderCompanyId],
				[SellerCompanyId],
				[Available],
				[CreateDate],
				[LastUpdate],
				[LastUpdateBy],
				[LastUpdateByType]
			)
			select	@pCustomer_OrderId, 
					@pCompanyId,
					@pCompanyId,
					1,
					@pTime,
					@pTime,
					1,
					1

			insert into Customer_Order_ShippingAddress
			(
				[Customer_OrderId],
				[Customer_AddressId],
				[AddressId],
				[ContactPersonFirstName],
				[ContactPersonLastName],
				[ContactPersonPhoneNumber],
				[ContactPersonPhoneNumberCountryId],
				[CreateDate],
				[LastUpdate],
				[LastUpdateBy],
				[LastUpdateByType]
			)
			select	@pCustomer_OrderId, a.Id, a.AddressId, a.ContactPersonFirstName,
					a.ContactPersonLastName, a.ContactPersonPhoneNumber, a.ContactPersonPhoneNumberCountryId,
					@pTime, @pTime, 1, 1
			from Customer_Address a (nolock)
			where a.Id = @pCustomer_AddressId
		END
	end
	


return

/*

*/



GO


