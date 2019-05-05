
--drop function [dbo].[tfnCompanyCategoryBrandRelationListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnCompanyCategoryBrandRelationListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCompanyCategoryBrandRelationListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCompanyCategoryBrandRelationListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCompanyCategoryBrandRelationListGet] 
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


print 'Update function [dbo].[tfnCompanyCategoryBrandRelationListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCompanyCategoryBrandRelationListGet]
(
    @pCompanyId int,
	@pCategoryId int,
	@pBrandId int,
	@pSystemLanguageId int
)  
RETURNS @Ret_Table Table
(
	[Id] int identity(1,1) NOT NULL,
	[CategoryBrandId] int NOT NULL,
	[CategoryId] int NOT NULL,
	[Level] int NOT NULL,
	[Name] nvarchar(128) NOT NULL,
	[OrderCode] nvarchar(10) NOT NULL,
	[BrandId] int NOT NULL,
	[BrandName] nvarchar(256) NOT NULL,
	[BrandDescription] nvarchar(max) NOT NULL,
	[BrandCategoryDescription] nvarchar(max) NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[CategoryBrandId],
		[CategoryId],
		[Level],
		[Name],
		[OrderCode],
		[BrandId],
		[BrandName],
		[BrandDescription],
		[BrandCategoryDescription]
	)
	select	a.Id,
			b.Id,
			b.Level,
			isnull(b1.Name, b.Name),
			b.OrderCode,
			c.Id,
			c.BrandName,
			c.BrandDescription,
			C.BrandCategoryDescription
	from CategoryBrand a (nolock)
		inner join Category b (nolock) on a.CategoryId = b.Id
		left join CategoryY b1 (nolock) on b.Id = b1.CategoryId and b1.SystemLanguageId = @pSystemLanguageId
		inner join Brand c (nolock) on a.BrandId = c.Id
		left join CompanyCategory z (nolock) on b.Id = z.CategoryId and z.CompanyId = @pCompanyId and z.Available = 1
		left join CompanyBrand y (nolock) on c.Id = y.BrandId and y.CompanyId = @pCompanyId and y.Available = 1
	where (b.SystemCategory = 1 or (b.SystemCategory = 0 and z.Id is not null))
	and (c.SystemBrand = 1 or (c.SystemBrand = 0 and y.Id is not null))
	and (@pCategoryId = 0 or b.Id = @pCategoryId)
	and (@pBrandId = 0 or c.Id = @pBrandId)
	and b.Available = 1
	and c.Available = 1
	and a.Available = 1
	order by c.BrandName
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnCompanyCategoryBrandRelationListGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

