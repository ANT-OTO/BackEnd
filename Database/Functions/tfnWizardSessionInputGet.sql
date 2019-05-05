
--drop function [dbo].[tfnWizardSessionInputGet]


/****** Object:  UserDefinedFunction [dbo].[tfnWizardSessionInputGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnWizardSessionInputGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnWizardSessionInputGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnWizardSessionInputGet] 
		(
    @pSystemLanguageId int,
	@pCategory [nvarchar](128)
		)
		RETURNS @Ret_Table Table
(	
	[CodeId] [int] NOT NULL,
	[CodeShort] [nvarchar](30) NOT NULL,
	[CodeLong] [nvarchar](256) NOT NULL,
	[SortOrder] [varchar](8) NOT NULL
)
		AS  
		BEGIN 
			return 
		END
	'


	exec (@create)
END


print 'Update function [dbo].[tfnWizardSessionInputGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnWizardSessionInputGet]
(
    @pWizardSessionId int,
	@pInputName nvarchar(64)
)  
RETURNS @Ret_Table Table
(
	[InputName] nvarchar(64) NOT NULL,
	[InputTypeCodeId] int NOT NULL,
	[InputTextValue] nvarchar(max) NULL,
	[InputValue] nvarchar(max) NULL,
	[InputContent] nvarchar(max) NULL,
	[FileId] int NULL,
	[Order] nvarchar(64) NOT NULL
)
as
Begin 
	
	declare @pWizardMasterStepElementInputId int = 0
	declare @pInputTypeCodeId int = 0
	declare @pInputListId int = 0
	select	@pWizardMasterStepElementInputId = e.Id,
			@pInputTypeCodeId = e.InputTypeCodeId,
			@pInputListId = e.WizardInputListId
	from WizardSession a (nolock)
		inner join WizardMaster b (nolock) on a.WizardMasterId = b.Id
		inner join WizardMasterStep c (nolock) on b.Id = c.WizardMasterId and c.Available = 1
		inner join WizardMasterStepElement d (nolock) on c.Id = d.WizardMasterStepId and d.Available = 1 and d.WizardMasterStepElementTypeCodeId = 2
		inner join WizardMasterStepElementInput e (nolock) on d.Id = e.WizardMasterStepElementId and e.Available = 1
	where a.Id = @pWizardSessionId
	and e.InputName = @pInputName	


	insert into @Ret_Table
	(
		[InputName],
		[InputTypeCodeId],
		[InputTextValue],
		[InputValue],
		[InputContent],
		[FileId],
		[Order]
	)
	select	@pInputName,
			@pInputTypeCodeId,
			b.StepValue,
			b.StepValue,
			'',
			b.StepSourceId,
			b.InputOrder
	from WizardSession a (nolock)
		inner join WizardSessionInputs b (nolock) on a.Id = b.WizardSessionId
	where b.WizardMasterStepElementInputId = @pWizardMasterStepElementInputId
	order by b.InputOrder
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnWizardSessionInputGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

