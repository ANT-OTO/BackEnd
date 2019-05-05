IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ANTOTOShippingOrderQuickCreate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ANTOTOShippingOrderQuickCreate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ANTOTOShippingOrderQuickCreate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ANTOTOShippingOrderQuickCreate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ANTOTOShippingOrderQuickCreate] 
	@pCustomerId int,
	@pReferenceOrderCode nvarchar(256),
	@pFromShippingAddressId int,
	@pToShippingAddressId int,
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
	

	if(isnull(@pFromShippingAddressId, 0) = 0 or isnull(@pToShippingAddressId, 0) = 0 )
	begin
		return
	end

	if(exists(
		select *
		from ShippingOrder a (nolock)
		where a.ReferenceOrderCode = @pReferenceOrderCode
		and a.ShippingOrderStatusCodeId not in (9, 10, 11) --select * from CodeList where Category = 'ShippingOrderStatus'
	))
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
	select	isnull(@pCustomerId,0), null, @pReferenceOrderCode, @pFromShippingAddressId, @pToShippingAddressId,
			@pShippingChannelId, @pPrice, @pCurrencyId, isnull(@pTotalWeight, 0.0) , isnull(@pWeightUnitId, 1), 1, '',
			@pUserId, @pTime, @pTime, 1, 1
	
	
	select @pShippingOrderId = SCOPE_IDENTITY()

	declare @pShippingOrderCode nvarchar(256) = 'AS' + RIGHT('00000000'+CAST(@pShippingOrderId AS VARCHAR(8)),8)

	update a
	set a.ShippingOrderCode = @pShippingOrderCode
	from ShippingOrder a
	where a.Id = @pShippingOrderId

	if(len(isnull(@pReferenceOrderCode, '')) = 0)
	begin
		update a
		set a.ReferenceOrderCode = a.ShippingOrderCode
		from ShippingOrder a 
		where a.Id = @pShippingOrderId
	end

	--ID

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


