IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CustomerAddressResourceClear]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CustomerAddressResourceClear] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CustomerAddressResourceClear] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CustomerAddressResourceClear] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CustomerAddressResourceClear] 
	@pCustomer_AddressId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	declare @pAddressId int = 0
	
	update a
	set a.Available = 0
	from Customer_AddressResource a
	where a.Customer_AddressId = @pCustomer_AddressId
	and a.Available = 1


	


return

/*

*/



GO


