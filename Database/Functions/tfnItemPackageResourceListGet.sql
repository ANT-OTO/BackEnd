
--drop function [dbo].[tfnItemPackageResourceListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnItemPackageResourceListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnItemPackageResourceListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnItemPackageResourceListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnItemPackageResourceListGet] 
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


print 'Update function [dbo].[tfnItemPackageResourceListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnItemPackageResourceListGet]
(
    @pSourceTable nvarchar(256),
	@pSourceId int
)  
RETURNS @Ret_Table Table
(
	[SourceTable] nvarchar(64) NOT NULL,
	[SourceId] int NOT NULL,
	[ResourceTypeCodeId] int NOT NULL, --image, video
	[FileId] int NOT NULL,
	[Description_1] nvarchar(max) NULL,
	[Description_2] nvarchar(max) NULL,
	[Available] bit NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[SourceTable],
		[SourceId],
		[ResourceTypeCodeId] , --image, video
		[FileId] ,
		[Description_1],
		[Description_2],
		[Available]
	)
	select a.SourceTable, a.SourceId, a.ResourceTypeCodeId, a.FileId, a.Description_1, a.Description_2, a.Available
	from ItemPackageResouce a (nolock)
	where a.SourceTable = @pSourceTable
	and a.SourceId = @pSourceId
	and a.Available = 1
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnItemPackageResourceListGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

