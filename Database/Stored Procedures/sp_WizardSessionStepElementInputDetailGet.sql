IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_WizardSessionStepElementInputDetailGet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_WizardSessionStepElementInputDetailGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_WizardSessionStepElementInputDetailGet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_WizardSessionStepElementInputDetailGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_WizardSessionStepElementInputDetailGet] 
	@pWizardSessionId int,
	@pWizardMasterStepCode nvarchar(64),
	@pWizardSessionStepElementId int
AS

SET NOCOUNT ON

declare @Time datetime = getutcdate()

declare @Ret_Table Table
(
	[WizardMasterStepElementInputId] int NOT NULL,
	[WizardMasterStepElementId] [int] NOT NULL,
	[InputName] nvarchar(64) NOT NULL,
	[InputDisplayName] nvarchar(64) NOT NULL,
	[InputTypeCodeId] int NOT NULL,
	[AllowList] bit NOT NULL,
	[Required] bit NOT NULL,
	[InputDiscription] nvarchar(512) NOT NULL,
	[ValidationCode] nvarchar(128) NULL,
	[ValidationFailMessage] nvarchar(256) NULL,
	[WizardInputListId] int NULL, --only exists when it is List.
	[Available] bit NOT NULL
)

insert into @Ret_Table
(
	[WizardMasterStepElementInputId],
	[WizardMasterStepElementId],
	[InputName],
	[InputDisplayName],
	[InputTypeCodeId],
	[AllowList],
	[Required],
	[InputDiscription],
	[ValidationCode],
	[ValidationFailMessage],
	[WizardInputListId], --only exists when it is List.
	[Available]
)
select	e.Id,
		e.WizardMasterStepElementId,
		e.InputName,
		e.InputDisplayName,
		e.InputTypeCodeId,
		e.AllowList,
		e.[Required],
		e.InputDiscription,
		e.ValidationCode,
		e.ValidationFailMessage,
		e.WizardInputListId,
		e.Available
from WizardSession a (nolock)
	inner join WizardMaster b (nolock) on a.WizardMasterId = b.Id
	inner join WizardMasterStep c (nolock) on b.Id = c.WizardMasterId
	inner join WizardMasterStepElement d (nolock) on c.Id = d.WizardMasterStepId
	inner join WizardMasterStepElementInput e (nolock) on d.Id = e.WizardMasterStepElementId
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


