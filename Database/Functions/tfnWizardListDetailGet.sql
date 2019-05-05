
--drop function [dbo].[tfnWizardListDetailGet]


/****** Object:  UserDefinedFunction [dbo].[tfnWizardListDetailGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnWizardListDetailGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnWizardListDetailGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnWizardListDetailGet] 
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


print 'Update function [dbo].[tfnWizardListDetailGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnWizardListDetailGet]
(
    @pWizardListId int
)  
RETURNS @Ret_Table Table
(
	[Value] nvarchar(64) NOT NULL,
	[Content] nvarchar(256) NOT NULL,
	[Order] nvarchar(5) NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[Value],
		[Content],
		[Order]
	)
	select  b.Value,
			b.Content,
			b.[Order]
	from WizardList a (nolock)
		inner join WizardListDetail b (nolock) on a.Id = b.WizardListId
	where b.Available = 1
	and a.Available = 1
	and a.Id = @pWizardListId
	order by b.[Order] 

	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnWizardListDetailGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

