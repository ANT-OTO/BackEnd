
--drop function [dbo].[tfnCompanyGetByCode]


/****** Object:  UserDefinedFunction [dbo].[tfnCompanyGetByCode]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCompanyGetByCode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCompanyGetByCode] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCompanyGetByCode] 
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


print 'Update function [dbo].[tfnCompanyGetByCode] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCompanyGetByCode]
(
	@pCompanyCode nvarchar(256)
)  
RETURNS @Ret_Table Table
(
	CompanyId int,
	CompanyCode nvarchar(256),
	CompanyName nvarchar(256),
	CompanyDescription nvarchar(256)
)
as
Begin 
	
	insert into @Ret_Table
	(
		CompanyId,
		CompanyCode,
		CompanyName,
		CompanyDescription
	)
	select a.Id, a.CompanyCode, a.CompanyName, ''
	from Company a (nolock)
	where a.CompanyCode = @pCompanyCode
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnCompanyGetByCode](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

