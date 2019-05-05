IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_WizardSessionStepElementInputValueGet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_WizardSessionStepElementInputValueGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_WizardSessionStepElementInputValueGet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_WizardSessionStepElementInputValueGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_WizardSessionStepElementInputValueGet] 
	@pWizardSessionId int,
	@pWizardMasterStepCode nvarchar(64),
	@pWizardSessionStepElementInputId int
AS

SET NOCOUNT ON

declare @Time datetime = getutcdate()

declare @Ret_Table Table
(
	[WizardSessionId] int NOT NULL,
	[WizardMasterStepElementInputId] int NOT NULL,
	[StepCode] nvarchar(64) NOT NULL,
	[InputOrder] int NOT NULL, -- 0 --> 99
	[StepValue] nvarchar(512) NULL, --string input
	[StepIntValue] int NULL, --list input
	[StepSourceId] int NULL, --File or other
	[StepSourceTable] nvarchar(64) NULL --File or other
)

insert into @Ret_Table
(
	[WizardSessionId],
	[WizardMasterStepElementInputId],
	[StepCode],
	[InputOrder], -- 0 --> 99
	[StepValue], --string input
	[StepIntValue], --list input
	[StepSourceId], --File or other
	[StepSourceTable]--File or other
)
select	a.Id,
		b.WizardMasterStepElementInputId,
		b.StepCode,
		b.InputOrder,
		b.StepValue,
		b.StepIntValue,
		b.StepSourceId,
		b.StepSourceTable
from WizardSession a (nolock)
	inner join WizardSessionInputs b (nolock) on a.Id = b.WizardSessionId
where a.Id = @pWizardSessionId
and b.StepCode = @pWizardMasterStepCode
and b.WizardMasterStepElementInputId = @pWizardSessionStepElementInputId
order by b.InputOrder


select *
from @Ret_Table




return

/*
	exec [dbo].[sp_WizardSessionStepElementInputValueGet] 
	9,
	'1',
	8
*/



GO


