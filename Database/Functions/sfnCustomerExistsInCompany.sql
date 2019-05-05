/****** Object:  UserDefinedFunction [dbo].[sfnCustomerExistsInCompany]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sfnCustomerExistsInCompany]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	print 'Create function [dbo].[sfnCustomerExistsInCompany] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[sfnCustomerExistsInCompany] 
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


print 'Update function [dbo].[sfnCustomerExistsInCompany] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[sfnCustomerExistsInCompany]
(
	@pCompanyId int,
	@pLoginName nvarchar(256)
)
RETURNS  int
as
Begin 

	declare @RtnValue int = 0
	
	declare @pOrderId nvarchar(64)

	if(exists(
		select * from Customers a (nolock)
			inner join CustomerCompany b (nolock) on a.Id = b.CustomerId
		where b.CompanyId = @pCompanyId
		and b.Available = 1
		and a.Available = 1
	))
	begin
		select @RtnValue = a.Id
		from Customers a (nolock)
			inner join CustomerCompany b (nolock) on a.Id = b.CustomerId
		where b.CompanyId = @pCompanyId
		and b.Available = 1
		and a.Available = 1
	end
	else
	begin
		select @RtnValue = 0 
	end

return @RtnValue

End

/*


select top 10 * from WizardMasterStep
select * from WizardSession order by Id desc

select [dbo].[sfnCustomerExistsInCompany]('0', 11)
select [dbo].[sfnCustomerExistsInCompany](2, 'AroundToday')

select [dbo].[sfnCustomerExistsInCompany](3, 'AroundToday')

*/

GO


