--drop function [dbo].[tfnCodeList]


/****** Object:  UserDefinedFunction [dbo].[tfnCodeList]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCodeList]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCodeList] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCodeList] 
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


print 'Update function [dbo].[tfnCodeList] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCodeList]
(
    @pSystemLanguageId int,
	@pCategory [nvarchar](128)
)  


RETURNS @Ret_Table Table
(
	[CodeId] [int] NOT NULL,
	[CodeShort] [nvarchar](1024) NOT NULL,
	[CodeLong] [nvarchar](1024) NOT NULL,
	[SortOrder] [varchar](8) NOT NULL,
	[SystemLanguageId] int NOT NULL,
	[Available] bit NOT NULL
)
as
Begin 


insert into @Ret_Table
([CodeId], [CodeShort], [CodeLong], [SortOrder], [SystemLanguageId], [Available])
select a.CodeId, isnull(z.CodeShort, a.CodeShort), isnull(z.[CodeLong], a.[CodeLong]), a.SortOrder, isnull(z.SystemLanguageId, 1), a.[Available]
from CodeList a (nolock) 
	left join CodeListY z (nolock) on a.Id = z.CodeListId and z.SystemLanguageId = @pSystemLanguageId
where a.Category = @pCategory 
	-- and a.Available = 1
order by a.SortOrder
		
Return 


/*
--select * from CodeList
--select * from SystemLanguage

select * from [dbo].[tfnCodeList](2, 'CallType')

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

