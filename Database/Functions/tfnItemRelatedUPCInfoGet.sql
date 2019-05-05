
--drop function [dbo].[tfnItemRelatedUPCInfoGet]


/****** Object:  UserDefinedFunction [dbo].[tfnItemRelatedUPCInfoGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnItemRelatedUPCInfoGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnItemRelatedUPCInfoGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnItemRelatedUPCInfoGet] 
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


print 'Update function [dbo].[tfnItemRelatedUPCInfoGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnItemRelatedUPCInfoGet]
(
    @pItemRelatedUPCInfoId int
)  
RETURNS @Ret_Table Table
(
	[ItemRelatedUPCInfoId] int NOT NULL,
	[UPC] nvarchar(256) NOT NULL,
	[Description] nvarchar(256) NOT NULL,
	[SaleTag] nvarchar(128) NULL,
	[Available] bit NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[ItemRelatedUPCInfoId],
		[UPC],
		[Description],
		[SaleTag],
		[Available]
	)
	select	a.Id, a.UPC, a.Description, a.SaleTag, a.Available
	from ANTOTO.dbo.ItemRelatedUPCInfo a (nolock)
	where a.Id = @pItemRelatedUPCInfoId
	and a.Available = 1
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnItemRelatedUPCInfoGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

