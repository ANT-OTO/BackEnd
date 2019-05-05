IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Customer_OrderCancel]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Customer_OrderCancel] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Customer_OrderCancel] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Customer_OrderCancel] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Customer_OrderCancel]
	@pReason nvarchar(256),
	@pCustomer_OrderId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	--select * from CodeList where Category = 'CustomerOrderStatus'
	if(exists(
		select *
		from Customer_Orders a (nolock)
		where a.Id = @pCustomer_OrderId
		and a.CustomerOrderStatusCodeId not in (1, 2)
	))
	begin
		update a
		set a.CustomerOrderStatusCodeId = 12
		from Customer_Orders a 
		where a.Id = @pCustomer_OrderId
	end
	else
	begin
		select @pCustomer_OrderId = 0
	end
	


return

/*

*/



GO


