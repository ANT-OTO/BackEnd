
--drop function [dbo].[tfnChinaIdentityProfileGetByIdentityNumber]


/****** Object:  UserDefinedFunction [dbo].[tfnChinaIdentityProfileGetByIdentityNumber]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnChinaIdentityProfileGetByIdentityNumber]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnChinaIdentityProfileGetByIdentityNumber] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnChinaIdentityProfileGetByIdentityNumber] 
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


print 'Update function [dbo].[tfnChinaIdentityProfileGetByIdentityNumber] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnChinaIdentityProfileGetByIdentityNumber]
(
	@pIdentityNumber nvarchar(256)
)  
RETURNS @Ret_Table Table
(
	[IdentityNumber] nvarchar(256),
	[Name] nvarchar(256),
	[PhoneNumber] nvarchar(256),
	[FrontFileId] int,
	[BackFileId] int,
	[Available] bit
)
as
Begin 
	
	insert into @Ret_Table
	(
		[IdentityNumber],
		[Name],
		[PhoneNumber],
		[FrontFileId],
		[BackFileId],
		[Available]
	)
	select	a.[IdentityNumber],
			a.[Name],
			a.[PhoneNumber],
			a.[FrontFileId],
			a.[BackFileId],
			a.[Available]
	from ChinaIdentityProfile a (nolock)
	where a.IdentityNumber = @pIdentityNumber
	and a.Available = 1

Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnChinaIdentityProfileGetByIdentityNumber](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

