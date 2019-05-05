
--drop function [dbo].[tfnFileGet]


/****** Object:  UserDefinedFunction [dbo].[tfnFileGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnFileGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnFileGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnFileGet] 
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


print 'Update function [dbo].[tfnFileGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnFileGet]
(
    @pFileId int
)  
RETURNS @Ret_Table Table
(
	[FileName] nvarchar(256) NOT NULL,
	[FileExt] nvarchar(64) NOT NULL,
	[FileStoreTypeCodeId] int NOT NULL, --select * from CodeList where Category = 'FileStoreType'
	[FilePath] nvarchar(512) NOT NULL,
	[FilePublicUrl] nvarchar(512) NOT NULL,
	[MFilePublicUrl] nvarchar(512) NULL,
	[SFilePublicUrl] nvarchar(512) NULL,
	[Para1] nvarchar(256) NULL,
	[Para2] nvarchar(256) NULL,
	[Para3] nvarchar(256) NULL,
	[Para4] nvarchar(256) NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[FileName],
		[FileExt],
		[FileStoreTypeCodeId], --select * from CodeList where Category = 'FileStoreType'
		[FilePath],
		[FilePublicUrl],
		[MFilePublicUrl],
		[SFilePublicUrl],
		[Para1],
		[Para2],
		[Para3],
		[Para4]
	)
	select	a.[FileName],
			a.FileExt,
			a.FileStoreTypeCodeId,
			a.FilePath,
			a.FilePublicUrl,
			a.MFilePublicUrl,
			a.SFilePublicUrl,
			a.Para1,
			a.Para2,
			a.Para3,
			a.Para4
	from [File] a (nolock)
	where a.Id = @pFileId
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnFileGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

