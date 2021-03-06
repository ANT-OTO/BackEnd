
--drop function [dbo].[tfnBrandGet]


/****** Object:  UserDefinedFunction [dbo].[tfnBrandGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnBrandGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnBrandGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnBrandGet] 
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


print 'Update function [dbo].[tfnBrandGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnBrandGet]
(
    @pBrandId int,
	@pSystemLanguageId int
)  
RETURNS @Ret_Table Table
(
	[ParentBrandId] int NOT NULL,
	[BrandId] int NOT NULL,
	[BrandName] nvarchar(256) NOT NULL,
	[BrandDescription] nvarchar(max) NOT NULL,
	[BrandCategoryDescription] nvarchar(max) NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		ParentBrandId,
		BrandId,
		BrandName,
		BrandDescription,
		BrandCategoryDescription
	)
	select a.ParentBrandId, a.Id, a.BrandName, a.BrandDescription, a.BrandCategoryDescription 
	from Brand a (nolock)
	where a.Id = @pBrandId
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnBrandGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

