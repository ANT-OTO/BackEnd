IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderSubOrderInsert]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderSubOrderInsert] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderSubOrderInsert] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderSubOrderInsert] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderSubOrderInsert] 
	@pShippingOrderId int,
	@pSubOrderTypeCodeId int,
	@pSubOrderCode nvarchar(256),
	@pSubOrderDescription nvarchar(max),
	@pUserId int,
	@pLastUpdateBy int,
	@pLastUpdateByType int,
	@pShippingOrderSubOrderId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	if(exists(
		select *
		from ShippingOrderSubOrder a (nolock)
		where a.ShippingOrderId = @pShippingOrderId
		and a.SubOrderTypeCodeId = @pSubOrderTypeCodeId
		and a.SubOrderCode = @pSubOrderCode
	))
	begin
		return
	end

	if(isnull(@pShippingOrderSubOrderId, 0) > 0)
	begin
		update a
		set a.ShippingOrderId = @pShippingOrderId,
			a.SubOrderCode = @pSubOrderCode,
			a.SubOrderTypeCodeId = @pSubOrderTypeCodeId,
			a.SubOrderDescription = @pSubOrderDescription
		from ShippingOrderSubOrder a
		where a.Id = @pShippingOrderSubOrderId
	end
	else
	begin
		insert into ShippingOrderSubOrder
		(
			[ShippingOrderId],
			[SubOrderTypeCodeId],
			[SubOrderCode],
			[SubOrderStatus],
			[SubOrderDescription],
			[UserId],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select @pShippingOrderId, @pSubOrderTypeCodeId, @pSubOrderCode, '', @pSubOrderDescription, @pUserId, @pTime, @pTime, @pUserId, 1



		select @pShippingOrderSubOrderId = SCOPE_IDENTITY()
	end


return

/*

*/



GO


