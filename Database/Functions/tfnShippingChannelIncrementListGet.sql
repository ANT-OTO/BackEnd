
--drop function [dbo].[tfnShippingChannelIncrementListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnShippingChannelIncrementListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnShippingChannelIncrementListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnShippingChannelIncrementListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnShippingChannelIncrementListGet] 
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


print 'Update function [dbo].[tfnShippingChannelIncrementListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnShippingChannelIncrementListGet]
(
	@pShippingChannelId int
)  
RETURNS @Ret_Table Table
(
	[ShippingChannelId] int,
	[ShippingChannelIncrementServiceId] int,
	[ServiceName] nvarchar(256),
	[ServicePrice] decimal(10,2),
	[CurrencyId] int,
	[Optional] bit,
	[Available] bit
)
as
Begin 
	
	insert into @Ret_Table
	(
		[ShippingChannelId],
		[ShippingChannelIncrementServiceId],
		[ServiceName],
		[ServicePrice],
		[CurrencyId],
		[Optional],
		[Available]
	)
	select	a.ShippingChannelId, a.Id, a.ServiceName, a.ServicePrice,
			a.CurrencyId, a.Optional, a.Available
	from ShippingChannelIncrementService a (nolock)
	where a.ShippingChannelId = @pShippingChannelId
	and a.Available = 1
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnShippingChannelIncrementListGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

