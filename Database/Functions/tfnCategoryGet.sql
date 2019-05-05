
--drop function [dbo].[tfnCategoryGet]


/****** Object:  UserDefinedFunction [dbo].[tfnCategoryGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCategoryGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCategoryGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCategoryGet] 
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


print 'Update function [dbo].[tfnCategoryGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCategoryGet]
(
    @pCategoryId int,
	@pSystemLanguageId int
)  
RETURNS @Ret_Table Table
(
	[ParentCategoryId] int NOT NULL,
	[Level] int NOT NULL,
	[Name] nvarchar(128) NOT NULL,
	[OrderCode] nvarchar(10) NOT NULL,
	[Available] bit NOT NULL,
	[SystemCategory] bit NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[ParentCategoryId],
		[Level],
		[Name],
		[OrderCode],
		[Available],
		[SystemCategory]
	)
	select	a.ParentCategoryId,
			a.Level,
			isnull(z.Name, a.Name),
			a.OrderCode,
			a.Available,
			a.SystemCategory
	from Category a (nolock)
		left join CategoryY z (nolock) on a.Id = z.CategoryId and z.SystemLanguageId = @pSystemLanguageId
	where a.Id = @pCategoryId
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnCategoryGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

