IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderSFOrderNumberGet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderSFOrderNumberGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderSFOrderNumberGet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderSFOrderNumberGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
Alter procedure [dbo].[sp_ShippingOrderSFOrderNumberGet] 
	@pShippingOrderId int,
	@pSFOrderNumber nvarchar(max) output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	select @pSFOrderNumber = ''
	declare @pShippingOrderSubOrderId int = 0
	DECLARE db_cursor_2 CURSOR FOR 
		SELECT b.Id
		from ShippingOrder a (nolock)
			inner join ShippingOrderSubOrder b (nolock) on a.Id = b.ShippingOrderId
		where a.Id = @pShippingOrderId
		and b.SubOrderTypeCodeId = 4 --select * from CodeList where Category = 'SubOrderType'
		order by b.Id
		OPEN db_cursor_2  
		FETCH NEXT FROM db_cursor_2 INTO @pShippingOrderSubOrderId

		WHILE @@FETCH_STATUS = 0  
		BEGIN  
			if(@pSFOrderNumber <> '')
			begin
				select @pSFOrderNumber = @pSFOrderNumber + ', ' + a.SubOrderCode
				from ShippingOrderSubOrder a (nolock)
				where a.Id = @pShippingOrderSubOrderId
			end
			else
			begin
				select @pSFOrderNumber = @pSFOrderNumber + '' + a.SubOrderCode
				from ShippingOrderSubOrder a (nolock)
				where a.Id = @pShippingOrderSubOrderId
			end
			

			FETCH NEXT FROM db_cursor_2 INTO @pShippingOrderSubOrderId
		END 

		CLOSE db_cursor_2  
		DEALLOCATE db_cursor_2 


return

/*

*/



GO


