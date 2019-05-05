
--drop function [dbo].[tfnCompanyCategoryListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnCompanyCategoryListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCompanyCategoryListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCompanyCategoryListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCompanyCategoryListGet] 
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


print 'Update function [dbo].[tfnCompanyCategoryListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCompanyCategoryListGet]
(
    @pCompanyId int,
	@pParentCategoryId int,
	@pSystemLanguageId int
)  
RETURNS @Ret_Table Table
(
	[CategoryId] int NOT NULL,
	[ParentCategoryId] int NOT NULL,
	[Level] int NOT NULL,
	[Name] nvarchar(128) NOT NULL,
	[OrderCode] nvarchar(10) NOT NULL,
	[Available] bit NOT NULL,
	[SystemCategory] bit NOT NULL,
	[FinalLevel] bit NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[CategoryId],
		[ParentCategoryId],
		[Level],
		[Name],
		[OrderCode],
		[Available],
		[SystemCategory],
		[FinalLevel]
	)
	select  a.Id,
			a.ParentCategoryId,
			a.Level,
			isnull(z.Name, a.Name),
			a.OrderCode,
			a.Available,
			a.SystemCategory,
			0
	from Category a (nolock)
		left join CompanyCategory b (nolock) on a.Id = b.CategoryId
		left join CategoryY z (nolock) on a.Id = z.CategoryId and z.SystemLanguageId = @pSystemLanguageId
		--left join Category y (nolock) on a.Id = y.ParentCategoryId and y.Available = 1
	where ((b.Id is not null and b.CompanyId = @pCompanyId and b.Available = 1)
				or (b.Id is null and a.SystemCategory = 1))
	and (a.ParentCategoryId = @pParentCategoryId)
	and a.Available = 1
	order by a.Name

	update a
	set a.FinalLevel = 1
	from @Ret_Table a
		left join Category y (nolock) on a.CategoryId = y.ParentCategoryId and y.Available = 1
	where y.Id is null
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnCompanyCategoryListGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

