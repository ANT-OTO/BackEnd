
--drop function [dbo].[tfnShippingOrderLabelGet]


/****** Object:  UserDefinedFunction [dbo].[tfnShippingOrderLabelGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnShippingOrderLabelGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnShippingOrderLabelGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnShippingOrderLabelGet] 
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


print 'Update function [dbo].[tfnShippingOrderLabelGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnShippingOrderLabelGet]
(
	@pShippingOrderLabelId int
)  
RETURNS @Ret_Table Table
(
	[ShippingOrderId] int NOT NULL,
	[ShippingOrderLabelId] int NOT NULL,
	[LabelName] nvarchar(256) NOT NULL,
	[LabelNumber] nvarchar(256) NOT NULL,
	[FileId] int NOT NULL,
	[Order] int NOT NULL,
	[Available] bit NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[ShippingOrderId],
		[ShippingOrderLabelId],
		[LabelName],
		[LabelNumber],
		[FileId],
		[Order],
		[Available]
	)
	select b.Id, a.Id, a.LabelName, a.LabelNumber, a.FileId, a.[Order], a.Available
	from ShippingOrderLabel a (nolock)
		inner join ShippingOrder b (nolock) on a.ShippingOrderId = b.Id
	where a.Id = @pShippingOrderLabelId
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnShippingOrderLabelGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

