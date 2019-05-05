IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CustomerAddressIDUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CustomerAddressIDUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CustomerAddressIDUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CustomerAddressIDUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CustomerAddressIDUpdate] 
	@pCustomer_AddressId int,
	@pIDNumber nvarchar(256),
	@pCustomer_AddressIDId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	if(exists(
		select * 
		from [Customer_AddressID] a (nolock)
		where a.Customer_AddressId = @pCustomer_AddressId
	))
	begin
		update a
		set a.[CustomerNationalId] = @pIDNumber,
			a.Available = 1,
			a.LastUpdate = @pTime
		from Customer_AddressID a (nolock)
		where a.Customer_AddressID = @pCustomer_AddressId

		select @pCustomer_AddressIDId = a.Id
		from Customer_AddressID a (nolock)
		where a.Customer_AddressID = @pCustomer_AddressId
	end
	else
	begin
		insert into Customer_AddressID
		(
			[Customer_AddressId],
			[CustomerNationalId],
			[Available],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	@pCustomer_AddressId,
				@pIDNumber,
				1,
				@pTime,
				@pTime,
				1,
				1

		select @pCustomer_AddressIDId = SCOPE_IDENTITY()
	end


	


return

/*

*/



GO


