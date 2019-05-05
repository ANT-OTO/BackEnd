
--drop function [dbo].[tfnCompanyTransactionRequestFileGet]


/****** Object:  UserDefinedFunction [dbo].[tfnCompanyTransactionRequestFileGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCompanyTransactionRequestFileGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCompanyTransactionRequestFileGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCompanyTransactionRequestFileGet] 
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


print 'Update function [dbo].[tfnCompanyTransactionRequestFileGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCompanyTransactionRequestFileGet]
(
	@pCompanyTransactionRequestId int
)  
RETURNS @Ret_Table Table
(
	[CompanyTransactionRequestFileId] int NOT NULL,
	[CompanyTransactionRequestId] int NOT NULL,
	[FileId] int NOT NULL,
	[Available] bit NOT NULL
)
as
Begin 
	
	

	insert into @Ret_Table
	(
		[CompanyTransactionRequestFileId],
		[CompanyTransactionRequestId],
		[FileId],
		[Available]
	)
	select	a.Id, a.[CompanyTransactionRequestId],
			a.FileId, a.Available
	from CompanyTransactionRequestFile a (nolock)
	where a.[CompanyTransactionRequestId] = @pCompanyTransactionRequestId
	and a.Available = 1
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnCompanyTransactionRequestFileGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

