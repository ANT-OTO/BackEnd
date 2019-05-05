/****** Object:  UserDefinedFunction [dbo].[sfnSFExpressOrderCodeGetByNameAndPhoneNumber]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sfnSFExpressOrderCodeGetByNameAndPhoneNumber]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	print 'Create function [dbo].[sfnSFExpressOrderCodeGetByNameAndPhoneNumber] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[sfnSFExpressOrderCodeGetByNameAndPhoneNumber] 
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


print 'Update function [dbo].[sfnSFExpressOrderCodeGetByNameAndPhoneNumber] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[sfnSFExpressOrderCodeGetByNameAndPhoneNumber]
(
	@pName nvarchar(256),
	@pPhoneNumber nvarchar(256)
)
RETURNS  nvarchar(256)
as
Begin 

	declare @RtnValue nvarchar(256) = ''
	
	select top 1 @RtnValue = a.SubOrderCode
	from ShippingOrderSubOrder a (nolock)
		inner join ShippingOrder b (nolock) on a.ShippingOrderId = b.Id
		inner join ShippingAddress c (nolock) on b.ShippingToAddressId = c.Id
	where c.ContactPersonLastName + '' + c.ContactPersonFirstName = @pName
	and c.ContactPersonPhoneNumber = @pPhoneNumber
	and a.SubOrderTypeCodeId = 4
	order by b.Id desc

	return isnull(@RtnValue, '')

End

/*


select top 10 * from WizardMasterStep
select * from WizardSession order by Id desc

select [dbo].[sfnSFExpressOrderCodeGetByNameAndPhoneNumber]('0', 11)
select [dbo].[sfnSFExpressOrderCodeGetByNameAndPhoneNumber](2, 'AroundToday')

select [dbo].[sfnSFExpressOrderCodeGetByNameAndPhoneNumber](3, 'AroundToday')

*/

GO


