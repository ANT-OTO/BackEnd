/****** Object:  UserDefinedFunction [dbo].[sfnCompanyCurrentBalanceGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sfnCompanyCurrentBalanceGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	print 'Create function [dbo].[sfnCompanyCurrentBalanceGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[sfnCompanyCurrentBalanceGet] 
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


print 'Update function [dbo].[sfnCompanyCurrentBalanceGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[sfnCompanyCurrentBalanceGet]
(
	@pCustomerCompanyId int,
	@pCurrencyId int
)
RETURNS  decimal(10,2)
as
Begin 

	declare @RtnValue decimal(10,2) = 0.0
	

	declare @pCompanyTransactionId int = 0


	select @pCompanyTransactionId = max(a.Id)
	from CompanyTransaction a (nolock)
	where a.CompanyId = @pCustomerCompanyId
	and a.CurrencyId = @pCurrencyId


	select @RtnValue = a.CurrentBalance
	from CompanyTransaction a (nolock)
	where a.Id = @pCompanyTransactionId


	return isnull(@RtnValue, 0.0)

End

/*


select top 10 * from WizardMasterStep
select * from WizardSession order by Id desc

select [dbo].[sfnCompanyCurrentBalanceGet]('0', 11)
select [dbo].[sfnCompanyCurrentBalanceGet](2, 'AroundToday')

select [dbo].[sfnCompanyCurrentBalanceGet](3, 'AroundToday')

*/

GO


