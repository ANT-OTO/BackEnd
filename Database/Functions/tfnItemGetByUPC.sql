
--drop function [dbo].[tfnItemGetByUPC]


/****** Object:  UserDefinedFunction [dbo].[tfnItemGetByUPC]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnItemGetByUPC]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnItemGetByUPC] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnItemGetByUPC] 
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


print 'Update function [dbo].[tfnItemGetByUPC] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnItemGetByUPC]
(
    @pUPC nvarchar(256),
	@pCompanyId int,
	@pUserId int
)  
RETURNS @Ret_Table Table
(
	[ItemId] int,
	[WizardSessionId] int
)
as
Begin 
	
	insert into @Ret_Table
	(
		[ItemId],
		[WizardSessionId]
	)
	select a.Id, c.Id
	from Item a (nolock)
		inner join CompanyItem b (nolock) on a.Id = b.ItemId
		inner join WizardSession c (nolock) on a.Id = c.SourceId and c.SourceTable = 'Item'
	where a.ProductCode = @pUPC
	and a.ItemStatusCodeId not in (2) --select * from CodeList where Category = 'ItemStatus'
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnItemGetByUPC](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

