IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_WizardSessionInput_Clear]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_WizardSessionInput_Clear] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_WizardSessionInput_Clear] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_WizardSessionInput_Clear] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_WizardSessionInput_Clear] 
	@pWizardSessionId int,
	@pWizardSessionStepCode nvarchar(64),
	@pWizardMasterStepElementInputId int
AS

SET NOCOUNT ON

declare @Time datetime = getutcdate()


delete 
from WizardSessionInputs
where WizardSessionId = @pWizardSessionId
	and WizardMasterStepElementInputId = @pWizardMasterStepElementInputId
	and StepCode = @pWizardSessionStepCode



return

/*

*/



GO


