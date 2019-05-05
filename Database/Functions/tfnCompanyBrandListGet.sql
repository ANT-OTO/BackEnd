
--drop function [dbo].[tfnCompanyBrandListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnCompanyBrandListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCompanyBrandListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCompanyBrandListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCompanyBrandListGet] 
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


print 'Update function [dbo].[tfnCompanyBrandListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCompanyBrandListGet]
(
    @pCompanyId int,
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
		left join CompanyBrand b (nolock) on a.Id = b.BrandId
	where (b.Id is not null and b.CompanyId = @pCompanyId and b.Available = 1)
	or (b.Id is null and a.SystemBrand = 1)
	order by a.BrandName
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnCompanyBrandListGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

