/****** Object:  UserDefinedFunction [dbo].[sfnWizardSessionStepCodeIsFinal]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sfnWizardSessionStepCodeIsFinal]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	print 'Create function [dbo].[sfnWizardSessionStepCodeIsFinal] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[sfnWizardSessionStepCodeIsFinal] 
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


print 'Update function [dbo].[sfnWizardSessionStepCodeIsFinal] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[sfnWizardSessionStepCodeIsFinal]
(
	@pStepCode nvarchar(256),
	@pWizardSessionId int
)
RETURNS  bit
as
Begin 

	declare @RtnValue bit = 0
	
	declare @pOrderId nvarchar(64)

	select @pOrderId = c.[Order]
	from WizardSession a (nolock)
		inner join WizardMaster b (nolock) on a.WizardMasterId = b.Id and b.Available = 1
		inner join WizardMasterStep c (nolock) on b.Id = c.WizardMasterId and c.Available = 1
	where a.Id = @pWizardSessionId
	and c.StepCode = @pStepCode

	if(not exists(
		select *
		from WizardSession a (nolock)
		inner join WizardMaster b (nolock) on a.WizardMasterId = b.Id and b.Available = 1
		inner join WizardMasterStep c (nolock) on b.Id = c.WizardMasterId and c.Available = 1
		where a.Id = @pWizardSessionId
		and c.StepCode <> @pStepCode
		and c.[Order] > @pOrderId
	))
	begin
		select @RtnValue = 1
	end

return @RtnValue

End

/*


select top 10 * from WizardMasterStep
select * from WizardSession order by Id desc

select [dbo].[sfnWizardSessionStepCodeIsFinal]('0', 11)
select [dbo].[sfnWizardSessionStepCodeIsFinal](2, 'AroundToday')

select [dbo].[sfnWizardSessionStepCodeIsFinal](3, 'AroundToday')

*/

GO


