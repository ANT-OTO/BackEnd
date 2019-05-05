
--drop function [dbo].[tfnShippingOrderBatchHandlerGet]


/****** Object:  UserDefinedFunction [dbo].[tfnShippingOrderBatchHandlerGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnShippingOrderBatchHandlerGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnShippingOrderBatchHandlerGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnShippingOrderBatchHandlerGet] 
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


print 'Update function [dbo].[tfnShippingOrderBatchHandlerGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnShippingOrderBatchHandlerGet]
(
	@pShippingOrderBatchHandlerId int
)  
RETURNS @Ret_Table Table
(
	[ShippingOrderBatchHandlerId] int NOT NULL,
	[CompanyId] int NOT NULL,
	ShippingOrderActionTypeCodeId int NOT NULL,
	ShippingOrderActionType nvarchar(256) NOT NULL,
	[ShippingChannelId] int NOT NULL,
	[ShippingChannelName] nvarchar(256) NOT NULL,
	[BatchHandlerCode] nvarchar(256) NOT NULL, 
	[BatchHandlerStatusCodeId] int NOT NULL, --select * from CodeList where Category = 'BatchHandlerStatus'
	[BatchHandlerStatus] nvarchar(256) NOT NULL,
	[UserId] int NOT NULL,
	[UserName] nvarchar(256) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[ShippingOrderBatchHandlerId],
		[CompanyId],
		ShippingOrderActionTypeCodeId,
		ShippingOrderActionType,
		[ShippingChannelId],
		[ShippingChannelName],
		[BatchHandlerCode], 
		[BatchHandlerStatusCodeId], --select * from CodeList where Category = 'BatchHandlerStatus'
		[BatchHandlerStatus],
		[UserId],
		[UserName],
		[CreateDate],
		[LastUpdate]
	)
	select	a.Id, a.CompanyId, a.ShippingOrderActionTypeCodeId, d1.CodeShort, a.ShippingChannelId,
			c.ChannelName, a.BatchHandlerCode, a.BatchHandlerStatusCodeId,
			d.CodeShort, e.Id, isnull(e.FirstName, '') + ' ' + isnull(e.LastName, ''),
			a.CreateDate, a.LastUpdate
	from ShippingOrderBatchHandler a (nolock)
		left join ShippingOrderBatchHandlerDetail b (nolock) on a.Id = b.ShippingOrderBatchHandlerId
		inner join ShippingChannel c (nolock) on a.ShippingChannelId = c.Id
		inner join CodeList d (nolock) on d.CodeId = a.BatchHandlerStatusCodeId and d.Category = 'BatchHandlerStatus'
		inner join CodeList d1 (nolock) on d1.CodeId = a.ShippingOrderActionTypeCodeId and d1.Category = 'ShippingOrderActionType'
		inner join [User] e (nolock) on a.UserId = e.Id
	where a.Id = @pShippingOrderBatchHandlerId
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnShippingOrderBatchHandlerGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

