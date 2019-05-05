
--drop function [dbo].[tfnShippingOrderBatchHandlerActionGet]


/****** Object:  UserDefinedFunction [dbo].[tfnShippingOrderBatchHandlerActionGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnShippingOrderBatchHandlerActionGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnShippingOrderBatchHandlerActionGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnShippingOrderBatchHandlerActionGet] 
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


print 'Update function [dbo].[tfnShippingOrderBatchHandlerActionGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnShippingOrderBatchHandlerActionGet]
(
	@pShippingOrderBatchHandlerId int
)  
RETURNS @Ret_Table Table
(
	[ShippingOrderBatchHandlerId] int NOT NULL,
	[SubOrderTypeCodeId] int NULL,--select * from CodeList where Category = 'SubOrderType'
	[SubOrderType] nvarchar(256), 
	[SubOrderCode] nvarchar(256) NULL,
    [SubOrderDescription] nvarchar(max) NULL,
	[Available] bit NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[ShippingOrderBatchHandlerId],
		[SubOrderTypeCodeId],
		[SubOrderType],
		[SubOrderCode],
		[SubOrderDescription],
		[Available]
	)
	select	a.Id,
			b.SubOrderTypeCodeId, d.CodeShort, b.SubOrderCode,
			b.SubOrderDescription, b.Available
	from ShippingOrderBatchHandler a (nolock)
		inner join ShippingOrderBatchHandlerAction b (nolock) on a.Id = b.ShippingOrderBatchHandlerId
		inner join CodeList d (nolock) on b.SubOrderTypeCodeId = d.CodeId and d.Category = 'SubOrderType'
	where a.Id = @pShippingOrderBatchHandlerId
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnShippingOrderBatchHandlerActionGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

