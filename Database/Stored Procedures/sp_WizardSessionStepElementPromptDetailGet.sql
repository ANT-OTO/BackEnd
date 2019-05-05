IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_WizardSessionStepElementPromptDetailGet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_WizardSessionStepElementPromptDetailGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_WizardSessionStepElementPromptDetailGet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_WizardSessionStepElementPromptDetailGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_WizardSessionStepElementPromptDetailGet] 
	@pWizardSessionId int,
	@pWizardMasterStepCode nvarchar(64),
	@pWizardSessionStepElementId int
AS

SET NOCOUNT ON

declare @Time datetime = getutcdate()

declare @Ret_Table Table
(
	[WizardMasterStepElementPropmtId] int NOT NULL,
	[WizardMasterStepElementId] [int] NOT NULL,
	[DisplayText] nvarchar(max) NOT NULL,
	[Available] bit NOT NULL
)

insert into @Ret_Table
(
	[WizardMasterStepElementPropmtId],
	[WizardMasterStepElementId],
	[DisplayText],
	[Available]
)
select	e.Id,
		e.WizardMasterStepElementId,
		e.DisplayText,
		e.Available
from WizardSession a (nolock)
	inner join WizardMaster b (nolock) on a.WizardMasterId = b.Id
	inner join WizardMasterStep c (nolock) on b.Id = c.WizardMasterId
	inner join WizardMasterStepElement d (nolock) on c.Id = d.WizardMasterStepId
	inner join WizardMasterStepElementPrompt e (nolock) on d.Id = e.WizardMasterStepElementId
where a.Id = @pWizardSessionId
and c.StepCode = @pWizardMasterStepCode
and d.Id = @pWizardSessionStepElementId
and c.Available = 1
and b.Available = 1
and d.Available = 1
and e.Available = 1
order by d.[Order]

select *
from @Ret_Table




return

/*

*/



GO


