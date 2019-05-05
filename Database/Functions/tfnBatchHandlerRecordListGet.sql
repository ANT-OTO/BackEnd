
--drop function [dbo].[tfnBatchHandlerRecordListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnBatchHandlerRecordListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnBatchHandlerRecordListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnBatchHandlerRecordListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnBatchHandlerRecordListGet] 
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


print 'Update function [dbo].[tfnBatchHandlerRecordListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnBatchHandlerRecordListGet]
(
	@pBatchHandlerId int
)  
RETURNS @Ret_Table Table
(
	[BatchHandlerRecordId] [int] NOT NULL,
	[BatchHandlerId] int NOT NULL,
	[RecordNumber] nvarchar(256) NOT NULL,
	[BatchHandlerRecordStatusCodeId] int NOT NULL, --select * from CodeList where Category = 'BatchHandlerRecordStatus'
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[LastUpdateBy] [int] NOT NULL,
	[LastUpdateByType] [smallint] NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[BatchHandlerRecordId],
		[BatchHandlerId],
		[RecordNumber],
		[BatchHandlerRecordStatusCodeId], --select * from CodeList where Category = 'BatchHandlerRecordStatus'
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	b.Id, b.BatchHandlerId, b.RecordNumber, b.BatchHandlerRecordStatusCodeId,
			b.CreateDate, b.LastUpdate, b.LastUpdateBy, b.LastUpdateByType
	from BatchHandler a (nolock)
		inner join BatchHandlerRecord b (nolock) on a.Id = b.BatchHandlerId
	where a.Id = @pBatchHandlerId
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnBatchHandlerRecordListGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

