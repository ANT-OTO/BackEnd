
--drop function [dbo].[tfnShippingOrderSubOrderRoutingTransactionListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnShippingOrderSubOrderRoutingTransactionListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnShippingOrderSubOrderRoutingTransactionListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnShippingOrderSubOrderRoutingTransactionListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnShippingOrderSubOrderRoutingTransactionListGet] 
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


print 'Update function [dbo].[tfnShippingOrderSubOrderRoutingTransactionListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnShippingOrderSubOrderRoutingTransactionListGet]
(
	@pShippingOrderSubOrderId int
)  
RETURNS @Ret_Table Table
(
	[Id] int identity(1,1) NOT NULL,
	[ShippingOrderSubOrderId] int NOT NULL,
	ShippingOrderSubOrderRoutingTrackId int NOT NULL,
	[AcceptedAddress] nvarchar(256) NOT NULL,
	[OpCode] nvarchar(256) NOT NULL,
	[RemarkDetail] nvarchar(max) NOT NULL,
	[AcceptTime] datetime NOT NULL, 
	[SourceId] int NOT NULL,
	[SourceTable] nvarchar(256) NOT NULL,
	[UserId] int NOT NULL,
	[UserName] nvarchar(256) NOT NULL,
	[CreateDate] [datetime] NOT NULL
)
as
Begin 
	
	declare @pTime datetime = getutcdate()

	insert into @Ret_Table
	(
		[ShippingOrderSubOrderId],
		ShippingOrderSubOrderRoutingTrackId,
		[AcceptedAddress],
		[OpCode],
		[RemarkDetail],
		[AcceptTime], 
		[SourceId],
		[SourceTable],
		[UserId],
		[UserName],
		[CreateDate]
	)
	select	a.Id, b.Id, b.AcceptedAddress, b.OpCode, b.RemarkDetail,
			b.AcceptTime, b.SourceId, b.SourceTable, isnull(b.UserId, 0), isnull(z.FirstName, '') + ' ' + isnull(z.LastName, ''),
			b.CreateDate
	from ShippingOrderSubOrder a (nolock)
		inner join ShippingOrderSubOrderRoutingTrack b (nolock) on a.Id = b.ShippingOrderSubOrderId
		left join [User] z (nolock) on b.UserId = z.Id
	where a.Id = @pShippingOrderSubOrderId
	and b.Available = 1
	order by b.AcceptTime
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnShippingOrderSubOrderRoutingTransactionListGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

