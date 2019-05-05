
--drop function [dbo].[tfnBatchTemplateListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnBatchTemplateListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnBatchTemplateListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnBatchTemplateListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnBatchTemplateListGet] 
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


print 'Update function [dbo].[tfnBatchTemplateListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from BatchTemplate
ALTER function [dbo].[tfnBatchTemplateListGet]
(
	@pCompanyId int
)  
RETURNS @Ret_Table Table
(
	[BatchTemplateId] int NOT NULL,
	[TemplateName] nvarchar(256) NOT NULL,
	[TemplateCode] nvarchar(256) NOT NULL,
	[Available] bit NOT NULL,
	[FilePath] nvarchar(256) NULL,
	[FilePublicUrl] nvarchar(256) NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[BatchTemplateId],
		[TemplateName],
		[TemplateCode],
		[Available],
		[FilePath],
		[FilePublicUrl]
	)
	select	a.Id, a.TemplateName, a.TemplateCode, a.Available,
			b.[FilePath], b.FilePublicUrl
	from BatchTemplate a (nolock)
		inner join [BatchTemplateSampleFile] b (nolock) on a.Id = b.BatchTemplateId
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnBatchTemplateListGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

