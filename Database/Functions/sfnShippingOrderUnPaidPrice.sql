/****** Object:  UserDefinedFunction [dbo].[sfnShippingOrderUnPaidPrice]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sfnShippingOrderUnPaidPrice]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	print 'Create function [dbo].[sfnShippingOrderUnPaidPrice] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[sfnShippingOrderUnPaidPrice] 
		(
		)
		returns  bit

		AS  
		BEGIN 
			declare @Ret_value bit
			return @Ret_value
		END
	'


	exec (@create)
END


print 'Update function [dbo].[sfnShippingOrderUnPaidPrice] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[sfnShippingOrderUnPaidPrice]
(
	@pShippingOrderId int,
	@pShippingOrderCode nvarchar(256)
)
RETURNS  decimal(10,2)
as
Begin 

	declare @RtnValue decimal(10,2) = 0.0
	
	if(isnull(@pShippingOrderId, 0) = 0)
	begin
		select @pShippingOrderId = a.Id
		from ShippingOrder a (nolock)
		where a.ShippingOrderCode = @pShippingOrderCode
	end
	declare @pCustomerCompanyId int = 0
	select @pCustomerCompanyId = b.SourceCompanyId
	from ShippingOrder a (nolock)
		inner join ShippingOrderCompany b (nolock) on a.Id = b.ShippingOrderId
	where a.Id = @pShippingOrderId

	declare @pPrice decimal(10, 2) = 0.0

	select @pPrice = a.Price
	from ShippingOrder a (nolock)
	where a.Id = @pShippingOrderId

	--declare @pTaxPrice decimal(10,2) = 0.0
	
	--select @pTaxPrice = b.TaxPrice
	--from ShippingOrder a (nolock)
	--	inner join ShippingOrderTaxPayment b (nolock) on a.Id = b.ShippingOrderId
	--where a.Id = @pShippingOrderId

	declare @pChargedPrice decimal(10, 2) = 0.0
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
	and a.SourceTable = 'ShippingOrder'
	and a.CompanyId = @pCustomerCompanyId

	select @RtnValue = @pPrice - isnull(@pChargedPrice, 0.0)



	return isnull(@RtnValue, 0.0)

End

/*


select top 10 * from WizardMasterStep
select * from WizardSession order by Id desc

select [dbo].[sfnShippingOrderUnPaidPrice]('0', 11)
select [dbo].[sfnShippingOrderUnPaidPrice](2, 'AroundToday')

select [dbo].[sfnShippingOrderUnPaidPrice](3, 'AroundToday')

*/

GO


