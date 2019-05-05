
--drop function [dbo].[tfnSystemLanguageListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnSystemLanguageListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnSystemLanguageListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnSystemLanguageListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnSystemLanguageListGet] 
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


print 'Update function [dbo].[tfnSystemLanguageListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnSystemLanguageListGet]
(
)  
RETURNS @Ret_Table Table
(
	SystemLanguageId int,
	LanguageEnglishName nvarchar(256),
	LanguageDisplayName nvarchar(256),
	Available bit
)
as
Begin 
	
	insert into @Ret_Table
	(
		SystemLanguageId,
		LanguageEnglishName,
		LanguageDisplayName,
		Available
	)
	select	a.Id, a.EnglishName, a.DisplayName, a.Available
	from SystemLanguage a (nolock)
	where a.Available = 1
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnSystemLanguageListGet]()

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

