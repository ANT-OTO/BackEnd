
--drop function [dbo].[tfnItemPurchaseTaskResourceGet]


/****** Object:  UserDefinedFunction [dbo].[tfnItemPurchaseTaskResourceGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnItemPurchaseTaskResourceGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnItemPurchaseTaskResourceGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnItemPurchaseTaskResourceGet] 
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


print 'Update function [dbo].[tfnItemPurchaseTaskResourceGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnItemPurchaseTaskResourceGet]
(
    @pItemPurchaseTaskId int
)  
RETURNS @Ret_Table Table
(
	[ItemPurchaseTaskId] int NOT NULL,
	[ResourceTypeCodeId] int NOT NULL, --image, video
	[FileId] int NOT NULL,
	[Description_1] nvarchar(max) NULL,
	[Description_2] nvarchar(max) NULL,
	[Available] bit NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[ItemPurchaseTaskId],
		[ResourceTypeCodeId], --image, video
		[FileId],
		[Description_1],
		[Description_2],
		[Available]
	)
	select	a.Id, b.ResourceTypeCodeId, b.FileId,
			b.Description_1, b.Description_2, b.Available
	from ItemPurchaseTask a (nolock)
		inner join ItemPurchaseTaskResource b (nolock) on a.Id = b.ItemPurchaseTaskId
	where a.Id = @pItemPurchaseTaskId
	and b.Available = 1
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnItemPurchaseTaskResourceGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

