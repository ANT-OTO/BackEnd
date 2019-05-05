
--drop function [dbo].[tfnCompanyCategoryListGetByCategoryId]


/****** Object:  UserDefinedFunction [dbo].[tfnCompanyCategoryListGetByCategoryId]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCompanyCategoryListGetByCategoryId]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCompanyCategoryListGetByCategoryId] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCompanyCategoryListGetByCategoryId] 
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


print 'Update function [dbo].[tfnCompanyCategoryListGetByCategoryId] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCompanyCategoryListGetByCategoryId]
(
    @pCompanyId int,
	@pCategoryId int,
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
	[FinalLevel] bit NOT NULL,
	[Selected] bit NOT NULL
)
as
Begin 
	
	declare @CategoryTable Table
	(
		CategoryId int,
		ParentCategoryId int
	)
	insert into @CategoryTable
	(CategoryId, ParentCategoryId)
	select a.Id, a.ParentCategoryId
	from Category a 
			left join CompanyCategory c (nolock) on a.Id = c.CategoryId
			left join CategoryY z (nolock) on a.Id = z.CategoryId and z.SystemLanguageId = @pSystemLanguageId
	where ((c.Id is not null and c.CompanyId = @pCompanyId and c.Available = 1)
				or (c.Id is null and a.SystemCategory = 1))
		and a.Available = 1
	if(not exists(
		select * from @CategoryTable a
		where a.CategoryId = @pCategoryId
	))
	begin
		return
	end
	declare @pParentCategoryId int = 0

	--select * from Category
	select @pParentCategoryId = a.ParentCategoryId
	from Category a (nolock)
	where a.Id = @pCategoryId
	
	insert into @Ret_Table
	(
		[CategoryId],
		[ParentCategoryId],
		[Level],
		[Name],
		[OrderCode],
		[Available],
		[SystemCategory],
		[FinalLevel],
		[Selected]
	)
	select	a2.Id,
			a2.ParentCategoryId,
			a2.Level,
			isnull(z.Name, a2.Name),
			a2.OrderCode,
			a2.Available,
			a2.SystemCategory,
			0,
			case when a.CategoryId = a1.CategoryId then 1 else 0 end
	from @CategoryTable a 
		inner join @CategoryTable a1 on a.ParentCategoryId = a1.ParentCategoryId
		inner join Category a2 on a1.CategoryId = a2.Id
		left join CompanyCategory b (nolock) on a2.Id = b.CategoryId
		left join CategoryY z (nolock) on a2.Id = z.CategoryId and z.SystemLanguageId = @pSystemLanguageId
		--left join Category y (nolock) on a.Id = y.ParentCategoryId and y.Available = 1
	where a.CategoryId = @pCategoryId
	while(@pParentCategoryId <> 0)
	begin
		insert into @Ret_Table
		(
			[CategoryId],
			[ParentCategoryId],
			[Level],
			[Name],
			[OrderCode],
			[Available],
			[SystemCategory],
			[FinalLevel],
			[Selected]
		)
		select	a2.Id,
				a2.ParentCategoryId,
				a2.Level,
				isnull(z.Name, a2.Name),
				a2.OrderCode,
				a2.Available,
				a2.SystemCategory,
				0,
				case when a.CategoryId = a1.CategoryId then 1 else 0 end
		from @CategoryTable a 
			inner join @CategoryTable a1 on a.ParentCategoryId = a1.ParentCategoryId
			inner join Category a2 on a1.CategoryId = a2.Id
			left join CompanyCategory b (nolock) on a2.Id = b.CategoryId
			left join CategoryY z (nolock) on a2.Id = z.CategoryId and z.SystemLanguageId = @pSystemLanguageId
			--left join Category y (nolock) on a.Id = y.ParentCategoryId and y.Available = 1
		where a.CategoryId = @pParentCategoryId
		select @pParentCategoryId = a.ParentCategoryId
		from @CategoryTable a
		where a.CategoryId = @pParentCategoryId
		
	end
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
select * from [dbo].[tfnCompanyCategoryListGetByCategoryId](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

