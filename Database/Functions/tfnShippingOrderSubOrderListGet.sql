
--drop function [dbo].[tfnShippingOrderSubOrderListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnShippingOrderSubOrderListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnShippingOrderSubOrderListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnShippingOrderSubOrderListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnShippingOrderSubOrderListGet] 
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


print 'Update function [dbo].[tfnShippingOrderSubOrderListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnShippingOrderSubOrderListGet]
(
	@pShippingOrderId int,
	@pShippingOrderCode nvarchar(256)
)  
RETURNS @Ret_Table Table
(
	[ShippingOrderId] int NOT NULL,
	[ShippingOrderSubOrderId] int NOT NULL,
	[SubOrderTypeCodeId] int NOT NULL,
	[SubOrderType] nvarchar(256) NOT NULL,
	[SubOrderCode] nvarchar(256) NOT NULL,
	[SubOrderStatus] nvarchar(256) NOT NULL,
	[SubOrderDescription] nvarchar(max) NOT NULL,
	[UserId] int NOT NULL,
	[UserName] nvarchar(256) NOT NULL
)
as
Begin 
	
	declare @pTime datetime = getutcdate()

	declare @pRealShippingOrderCode nvarchar(256) = ''
	select @pRealShippingOrderCode = a.ShippingOrderCode
	from ShippingOrder a (nolock)
		inner join ShippingOrderSubOrder b (nolock) on a.Id = b.ShippingOrderId and b.SubOrderTypeCodeId = 4 --select * from CodeList where Category = 'SubOrderType'
	where b.SubOrderCode = @pShippingOrderCode

	if(len(isnull(@pRealShippingOrderCode, '')) > 0)
	begin
		select @pShippingOrderCode = @pRealShippingOrderCode
	end

	insert into @Ret_Table
	(
		[ShippingOrderId],
		[ShippingOrderSubOrderId],
		[SubOrderTypeCodeId],
		[SubOrderType],
		[SubOrderCode],
		[SubOrderStatus],
		[SubOrderDescription],
		[UserId],
		[UserName] 
	)
	select	a.Id, b.Id, b.SubOrderTypeCodeId, c.CodeShort, b.SubOrderCode, b.SubOrderStatus,
			b.[SubOrderDescription], isnull(z.Id, 0), 
			isnull(z.FirstName, '') + ' ' + isnull(z.LastName, '')
	from ShippingOrder a (nolock)
		inner join ShippingOrderSubOrder b (nolock) on a.Id = b.ShippingOrderId
		inner join CodeList c (nolock) on b.SubOrderTypeCodeId = c.CodeId and c.Category = 'SubOrderType'
		left join [User] z (nolock) on b.UserId = z.Id
	where (a.Id = @pShippingOrderId
	or a.ShippingOrderCode = @pShippingOrderCode)
	and b.SubOrderStatus <> 'Cancelled'
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnShippingOrderSubOrderListGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

