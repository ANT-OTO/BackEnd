
--drop function [dbo].[tfnBatchHandlerColumnListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnBatchHandlerColumnListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnBatchHandlerColumnListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnBatchHandlerColumnListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnBatchHandlerColumnListGet] 
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


print 'Update function [dbo].[tfnBatchHandlerColumnListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnBatchHandlerColumnListGet]
(
	@pBatchHandlerId int
)  
RETURNS @Ret_Table Table
(
	[Id] int identity(1, 1) NOT NULL,
	[BatchHandlerColumnId] int NOT NULL,
	[ColumnName] nvarchar(256) NOT NULL,
	[ColumnTypeCodeId] int NOT NULL,
	[ColumnOrder] int NOT NULL,
	[Required] bit NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[BatchHandlerColumnId],
		[ColumnName],
		[ColumnTypeCodeId],
		[ColumnOrder],
		[Required]
	)
	select a.Id, a.ColumnName, a.ColumnTypeCodeId, a.ColumnOrder, a.Required
	from BatchHandlerColumn a (nolock)
	where a.BatchHandlerId = @pBatchHandlerId
	order by a.ColumnOrder
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnBatchHandlerColumnListGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

