IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ANTOTOShippingOrderTaxPaymentSet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ANTOTOShippingOrderTaxPaymentSet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ANTOTOShippingOrderTaxPaymentSet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ANTOTOShippingOrderTaxPaymentSet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ANTOTOShippingOrderTaxPaymentSet] 
	@pShippingOrderId int,
	@pTaxPaymentMethod int, --shipper, receiver 1, 2
	@pTaxPrice decimal(10,2),
	@pCurrencyId int,
	@pShippingOrderTaxPaymentId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	if(exists(
		select *
		from ShippingOrderTaxPayment a (nolock)
			inner join ShippingOrder b (nolock) on a.ShippingOrderId = b.Id
		where b.Id = @pShippingOrderId
	))
	begin
		update a
		set a.TaxPaymentMethod = @pTaxPaymentMethod,
			a.TaxPrice = @pTaxPrice,
			a.CurrencyId = @pCurrencyId,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = 1,
			a.LastUpdateByType = 1
		from ShippingOrderTaxPayment a
		where a.ShippingOrderId = @pShippingOrderId

		select @pShippingOrderTaxPaymentId = a.Id
		from ShippingOrderTaxPayment a (nolock)
		where a.ShippingOrderId = @pShippingOrderId
	end
	else
	begin
		insert into ShippingOrderTaxPayment
		(
			[ShippingOrderId],
			[TaxPaymentMethod], --shipper, receiver 1, 2
			[TaxPrice],
			[CurrencyId],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select @pShippingOrderId, @pTaxPaymentMethod, @pTaxPrice, @pCurrencyId, @pTime, @pTime, 1, 1

		select @pShippingOrderTaxPaymentId = SCOPE_IDENTITY()
	end

	

	
	
	

	


return

/*

*/



GO


