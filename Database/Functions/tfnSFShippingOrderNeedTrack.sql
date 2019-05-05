
--drop function [dbo].[tfnSFShippingOrderNeedTrack]


/****** Object:  UserDefinedFunction [dbo].[tfnSFShippingOrderNeedTrack]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnSFShippingOrderNeedTrack]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnSFShippingOrderNeedTrack] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnSFShippingOrderNeedTrack] 
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


print 'Update function [dbo].[tfnSFShippingOrderNeedTrack] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnSFShippingOrderNeedTrack]
(
	
)  
RETURNS @Ret_Table Table
(
	ShippingOrderId int,
	ShippingOrderSubOrderId int,
	SFBillWayNo nvarchar(256)
)
as
Begin 
	
	insert into @Ret_Table
	(
		ShippingOrderId,
		ShippingOrderSubOrderId,
		SFBillWayNo
	)
	select b.Id, a.Id, a.SubOrderCode
	from ShippingOrderSubOrder a (nolock)
		inner join ShippingOrder b (nolock) on a.ShippingOrderId = b.Id
	where b.ShippingOrderStatusCodeId not in (8, 9, 10, 11) --select * from CodeList where Category = 'ShippingOrderStatus'
	and a.SubOrderTypeCodeId = 4 --select * from CodeList where Category = 'SubOrderType'
	and b.Id <> 5
	
	--select * from Country
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnSFShippingOrderNeedTrack](1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

