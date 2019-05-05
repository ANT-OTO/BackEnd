IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderTaxPriceCharge]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderTaxPriceCharge] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderTaxPriceCharge] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderTaxPriceCharge] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderTaxPriceCharge] 
	@pShippingOrderId int,
	@pUserId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	declare @pPrice decimal(10, 2) = 0.0
	declare @pCurrencyId int = 0
	declare @pChargedPrice decimal(10, 2) = 0.0
	declare @pPaidPrice decimal(10, 2) = 0.0
	declare @pSourceCompanyId int = 0
	declare @pHandlerCompanyId int = 0
	declare @pShippingOrderCode nvarchar(256) = ''
	declare @pShippingOrderTaxPaymentTypeCodeId int = 1
	select @pShippingOrderTaxPaymentTypeCodeId = a.ShippingOrderTaxPaymentTypeCodeId --select * from CodeList where Category = 'ShippingOrderTaxPaymentType'
	from ShippingOrderAdditionalInfo a (nolock)
	where a.ShippingOrderId = @pShippingOrderId

	if(@pShippingOrderTaxPaymentTypeCodeId = 2)
	begin
		return
	end

	select	@pPrice = c.TaxPrice,
			@pSourceCompanyId = b.SourceCompanyId,
			@pHandlerCompanyId = b.HandlerCompanyId,
			@pShippingOrderCode = a.ShippingOrderCode,
			@pCurrencyId = c.CurrencyId
	from ShippingOrder a (nolock)
		inner join ShippingOrderCompany b (nolock) on a.Id = b.ShippingOrderId
		inner join ShippingOrderTaxPayment c (nolock) on a.Id = c.ShippingOrderId
	where a.Id = @pShippingOrderId
	--select * from CodeList where Category = 'TransactionType'
	select @pChargedPrice = SUM(case when a.TransactionTypeCodeId = 1 then a.Amount
								when a.TransactionTypeCodeId = 2 then - a.Amount
								when a.TransactionTypeCodeId = 3 then a.Amount
								when a.TransactionTypeCodeId = 4 then -a.Amount
								when a.TransactionTypeCodeId = 5 then -a.Amount
								when a.TransactionTypeCodeId = 6 then a.Amount
								when a.TransactionTypeCodeId = 7 then a.Amount
								when a.TransactionTypeCodeId = 8 then -a.Amount end)
	from CompanyTransaction a (nolock)
	where a.SourceId = @pShippingOrderId
	and a.SourceTable = 'ShippingOrderTax'
	and a.CompanyId = @pSourceCompanyId

	select @pPaidPrice = SUM(case when a.TransactionTypeCodeId = 1 then - a.Amount
								when a.TransactionTypeCodeId = 2 then a.Amount
								when a.TransactionTypeCodeId = 3 then -a.Amount
								when a.TransactionTypeCodeId = 4 then a.Amount
								when a.TransactionTypeCodeId = 5 then a.Amount
								when a.TransactionTypeCodeId = 6 then -a.Amount
								when a.TransactionTypeCodeId = 7 then -a.Amount
								when a.TransactionTypeCodeId = 8 then a.Amount end)
	from CompanyTransaction a (nolock)
	where a.SourceId = @pShippingOrderId
	and a.SourceTable = 'ShippingOrderTax'
	and a.CompanyId = @pHandlerCompanyId
	

	if(isnull(@pPrice, 0) > 0.0 and isnull(@pPrice, 0.0) <> isnull(@pChargedPrice, 0.0) 
	and isnull(@pPrice, 0.0) <> isnull(@pPaidPrice, 0.0) )
	begin
		-- SourceCompany Charge
		declare @pDiff decimal(10,2) = @pPrice - isnull(@pChargedPrice, 0.0)
		declare @pDescription nvarchar(256) = N'税金 蚂蚁运单号 ： ' + @pShippingOrderCode  + N''
		if(@pDiff > 0)
		begin
			exec sp_CompanyTransactionInsert @pSourceCompanyId, 1, @pDiff, @pCurrencyId, @pShippingOrderId,
												'ShippingOrderTax', @pDescription, @pUserId, @pUserId, 1							
		end
		else
		begin
			select @pDiff = -@pDiff
			exec sp_CompanyTransactionInsert @pSourceCompanyId, 2, @pDiff, @pCurrencyId, @pShippingOrderId,
												'ShippingOrderTax', @pDescription, @pUserId, @pUserId, 1							
		end
		-- HandlerCompany Payment
		
		declare @pPaidDiff decimal(10,2) = @pPrice - isnull(@pPaidPrice, 0.0)
		if(@pPaidDiff > 0)
		begin
			exec sp_CompanyTransactionInsert @pHandlerCompanyId, 2, @pPaidDiff, @pCurrencyId, @pShippingOrderId,
												'ShippingOrderTax', @pDescription, @pUserId, @pUserId, 1							
		end
		else
		begin
			select @pPaidDiff = - @pPaidDiff
			exec sp_CompanyTransactionInsert @pHandlerCompanyId, 1, @pPaidDiff, @pCurrencyId, @pShippingOrderId,
												'ShippingOrderTax', @pDescription, @pUserId, @pUserId, 1							
		end



	end

	

return

/*

*/



GO


