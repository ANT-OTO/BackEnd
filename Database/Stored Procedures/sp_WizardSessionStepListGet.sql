IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_WizardSessionStepListGet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_WizardSessionStepListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_WizardSessionStepListGet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_WizardSessionStepListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_WizardSessionStepListGet] 
	@pWizardSessionId int
AS

SET NOCOUNT ON

declare @Time datetime = getutcdate()

declare @Ret_Table Table
(
	WizardSessionId int NOT NULL,
	WizardMasterId int NOT NULL,
	WizardMasterStepCode nvarchar(64) NOT NULL,
	WizardMasterStepTitle nvarchar(256) NOT NULL,
	[Order] nvarchar(64) NOT NULL
)

insert into @Ret_Table
(
	WizardSessionId,
	WizardMasterId,
	WizardMasterStepCode,
	WizardMasterStepTitle,
	[Order]
)
select a.Id, b.Id, c.StepCode, c.StepDisplayName, c.[Order]
from WizardSession a (nolock)
	inner join WizardMaster b (nolock) on a.WizardMasterId = b.Id
	inner join WizardMasterStep c (nolock) on b.Id = c.WizardMasterId
where a.Id = @pWizardSessionId
and c.Available = 1
and b.Available = 1
order by c.[Order]

select * from @Ret_Table





return

/*
 exec [dbo].[sp_WizardSessionStepListGet] 4
	@pWizardSessionId int
*/



GO


