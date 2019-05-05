IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_WizardSessionStepElementListGet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_WizardSessionStepElementListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_WizardSessionStepElementListGet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_WizardSessionStepElementListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_WizardSessionStepElementListGet] 
	@pWizardSessionId int,
	@pWizardMasterStepCode nvarchar(64)
AS

SET NOCOUNT ON

declare @Time datetime = getutcdate()

declare @Ret_Table Table
(
	[WizardMasterStepId] [int] NOT NULL,
	[WizardMasterStepElementId] int NOT NULL,
	[WizardMasterStepElementTypeCodeId] int NOT NULL, --select * from CodeList where Category = 'WizardMasterStepElementType'
	[Level] int NOT NULL,
	[Order] nvarchar(8) NOT NULL,
	[Weight] decimal(10,2) NOT NULL
)

insert into @Ret_Table
(
	[WizardMasterStepId],
	[WizardMasterStepElementId],
	[WizardMasterStepElementTypeCodeId], --select * from CodeList where Category = 'WizardMasterStepElementType'
	[Level],
	[Order],
	[Weight]
)
select c.Id, d.Id, d.WizardMasterStepElementTypeCodeId, d.[Level], d.[Order], d.[Weight]
from WizardSession a (nolock)
	inner join WizardMaster b (nolock) on a.WizardMasterId = b.Id
	inner join WizardMasterStep c (nolock) on b.Id = c.WizardMasterId
	inner join WizardMasterStepElement d (nolock) on c.Id = d.WizardMasterStepId
where a.Id = @pWizardSessionId
and c.StepCode = @pWizardMasterStepCode
and c.Available = 1
and b.Available = 1
and d.Available = 1
order by d.[Order]

select *
from @Ret_Table




return

/*

*/



GO


