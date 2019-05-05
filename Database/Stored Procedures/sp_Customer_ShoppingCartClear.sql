IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Customer_ShoppingCartClear]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Customer_ShoppingCartClear] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Customer_ShoppingCartClear] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Customer_ShoppingCartClear] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Customer_ShoppingCartClear] 
	@pCustomerId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	delete 
	from Customer_ShoppingCart_Items 
	where CustomerId = @pCustomerId




	


return

/*

*/



GO


