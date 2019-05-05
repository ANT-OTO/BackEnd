
--drop function [dbo].[tfnBatchHandlerRecordDetailGet]


/****** Object:  UserDefinedFunction [dbo].[tfnBatchHandlerRecordDetailGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnBatchHandlerRecordDetailGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnBatchHandlerRecordDetailGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnBatchHandlerRecordDetailGet] 
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


print 'Update function [dbo].[tfnBatchHandlerRecordDetailGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnBatchHandlerRecordDetailGet]
(
	@pBatchHandlerRecordId int
)  
RETURNS @Ret_Table Table
(
	[BatchHandlerRecordDetailId] int NOT NULL,
	[BatchHandlerRecordId] int NOT NULL,
	[BatchHandlerColumnId] int NOT NULL,
	[Value] nvarchar(256) NOT NULL,
	[ColumnName] nvarchar(256) NOT NULL,
	[ColumnTypeCodeId] int NOT NULL,
	[ColumnOrder] int NOT NULL,
	[HasError] bit NOT NULL,
	[ErrorReason] nvarchar(256) NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[BatchHandlerRecordDetailId],
		[BatchHandlerRecordId],
		[BatchHandlerColumnId],
		[Value],
		[ColumnName],
		[ColumnTypeCodeId],
		[ColumnOrder],
		[HasError],
		[ErrorReason]
	)
	select	b.Id, a.Id, b.BatchHandlerColumnId, b.Value,
			c.ColumnName, c.ColumnTypeCodeId, c.ColumnOrder,
			isnull(z.Error, 0), isnull(z.ErrorReason, '')
	from BatchHandlerRecord a (nolock)
		inner join BatchHandlerRecordDetail b (nolock) on a.Id = b.BatchHandlerRecordId
		left join BatchHandlerRecordDetailError z (nolock) on b.Id = z.BatchHandlerRecordDetailId
		inner join BatchHandlerColumn c (nolock) on b.BatchHandlerColumnId = c.Id
	where a.Id = @pBatchHandlerRecordId
	order by c.ColumnOrder
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnBatchHandlerRecordDetailGet](1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

