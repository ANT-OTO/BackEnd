/****** Object:  UserDefinedFunction [dbo].[sfnShippingOrderCheckForPrecharge]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sfnShippingOrderCheckForPrecharge]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	print 'Create function [dbo].[sfnShippingOrderCheckForPrecharge] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[sfnShippingOrderCheckForPrecharge] 
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


print 'Update function [dbo].[sfnShippingOrderCheckForPrecharge] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[sfnShippingOrderCheckForPrecharge]
(
	@pShippingOrderId int,
	@pShippingOrderCode nvarchar(256),
	@pCustomerCompanyId int
)
RETURNS  nvarchar(256)
as
Begin 

	declare @RtnValue nvarchar(256) = ''
	
	if(isnull(@pShippingOrderId, 0) = 0)
	begin
		select @pShippingOrderId = a.Id
		from ShippingOrder a (nolock)
		where a.ShippingOrderCode = @pShippingOrderCode
	end

	if(exists(
		select *
		from ShippingOrder a (nolock)
		where a.Id = @pShippingOrderId
		and a.ShippingOrderStatusCodeId in (1, 2) --select * from CodeList where Category = 'ShippingOrderStatus'
	))
	begin
		select @RtnValue = a.ShippingOrderCode + N'包裹未经过审核'
		from ShippingOrder a (nolock)
		where a.Id = @pShippingOrderId
		return @RtnValue
	end

	if(exists(
		select *
		from ShippingOrder a (nolock)
		where a.Id = @pShippingOrderId
		and a.ShippingOrderStatusCodeId in (9, 10, 11) --select * from CodeList where Category = 'ShippingOrderStatus'
	))
	begin
		select @RtnValue = a.ShippingOrderCode + N'包裹已取消或者异常'
		from ShippingOrder a (nolock)
		where a.Id = @pShippingOrderId
		return @RtnValue
	end

	if(not exists(
		select * from ShippingOrder a (nolock)
			inner join ShippingOrderCompany b (nolock) on a.Id = b.ShippingOrderId
		where b.SourceCompanyId = @pCustomerCompanyId
		and a.Id = @pShippingOrderId
	))
	begin
		select @RtnValue = a.ShippingOrderCode + N'包裹不属于此用户'
		from ShippingOrder a (nolock)
		where a.Id = @pShippingOrderId
		return @RtnValue
	end

	return isnull(@RtnValue, '')

End

/*


select top 10 * from WizardMasterStep
select * from WizardSession order by Id desc

select [dbo].[sfnShippingOrderCheckForPrecharge]('0', 11)
select [dbo].[sfnShippingOrderCheckForPrecharge](2, 'AroundToday')

select [dbo].[sfnShippingOrderCheckForPrecharge](3, 'AroundToday')

*/

GO


