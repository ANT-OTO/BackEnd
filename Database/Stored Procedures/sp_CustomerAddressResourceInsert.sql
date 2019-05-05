IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CustomerAddressResourceInsert]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CustomerAddressResourceInsert] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CustomerAddressResourceInsert] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CustomerAddressResourceInsert] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CustomerAddressResourceInsert] 
	@pCustomer_AddressId int,
	@pFileId int,
	@pCustomer_AddressResourceId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	insert into Customer_AddressResource
	(
		Customer_AddressId,
		FileId,
		Available,
		CreateDate,
		LastUpdate,
		LastUpdateBy,
		LastUpdateByType
	)
	select @pCustomer_AddressId, @pFileId, 1, @pTime, @pTime, 1, 1

	select @pCustomer_AddressResourceId = SCOPE_IDENTITY()


	


return

/*

*/



GO


