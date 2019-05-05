
--drop function [dbo].[tfnBatchHandlerGet]


/****** Object:  UserDefinedFunction [dbo].[tfnBatchHandlerGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnBatchHandlerGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnBatchHandlerGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnBatchHandlerGet] 
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


print 'Update function [dbo].[tfnBatchHandlerGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnBatchHandlerGet]
(
	@pBatchHandlerId int
)  
RETURNS @Ret_Table Table
(
	[BatchHandlerId] int NOT NULL,
	[BatchNumber] nvarchar(256) NOT NULL,
	[BatchTemplateId] int NOT NULL, 
	[UserId] int NOT NULL,
	[BatchStatusCodeId] int NOT NULL --select * from CodeList where Category = 'BatchStatus'
)
as
Begin 
	
	insert into @Ret_Table
	(
		BatchHandlerId,
		BatchNumber,
		BatchTemplateId,
		UserId,
		BatchStatusCodeId
	)
	select	a.Id, a.BatchNumber, a.BatchTemplateId, a.UserId, a.BatchStatusCodeId
	from BatchHandler a (nolock)
	where a.Id = @pBatchHandlerId
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnBatchHandlerGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

