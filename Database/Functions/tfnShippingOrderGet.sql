
--drop function [dbo].[tfnShippingOrderGet]


/****** Object:  UserDefinedFunction [dbo].[tfnShippingOrderGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnShippingOrderGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnShippingOrderGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnShippingOrderGet] 
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


print 'Update function [dbo].[tfnShippingOrderGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnShippingOrderGet]
(
	@pShippingOrderId int,
	@pShippingOrderCode nvarchar(256)
)  
RETURNS @Ret_Table Table
(
	[ShippingOrderId] int NOT NULL,
	[CustomerId] int NOT NULL,
	[CustomerOrderId] int NULL,
	[ReferenceOrderCode] nvarchar(256) NULL,
	[FromShippingAddressId] int NOT NULL,
	[ToShippingAddressId] int NOT NULL,
	[ShippingChannelId] int NULL,
	[Price] decimal(10,2) NOT NULL,
	[CurrencyId] int NOT NULL,
	[TotalWeight] decimal(10, 2) NOT NULL,
	[WeightUnitId] int NOT NULL,
	[ShippingOrderStatusCodeId] int NOT NULL,
	[ShippingOrderCode] nvarchar(256) NOT NULL,
	[SourceCompanyId] int NOT NULL,
	[HandlerCompanyId] int NOT NULL,
	[UserId] int NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[ShippingOrderId],
		[CustomerId],
		[CustomerOrderId],
		[ReferenceOrderCode],
		[FromShippingAddressId],
		[ToShippingAddressId],
		[ShippingChannelId],
		[Price],
		[CurrencyId],
		[TotalWeight],
		[WeightUnitId],
		[ShippingOrderStatusCodeId],
		[ShippingOrderCode],
		[SourceCompanyId],
		[HandlerCompanyId],
		[UserId]
	)
	select	a.Id, a.CustomerId, a.CustomerOrderId, 
			a.ReferenceOrderCode, a.ShippingFromAddressId, a.ShippingToAddressId,
			a.ShippingChannelId, a.Price, a.CurrencyId, a.TotalWeight,
			a.WeightUnitId, a.ShippingOrderStatusCodeId, a.ShippingOrderCode,
			b.SourceCompanyId, b.HandlerCompanyId, a.UserId
	from ShippingOrder a (nolock)
		inner join ShippingOrderCompany b (nolock) on a.Id = b.ShippingOrderId
	where a.Id = @pShippingOrderId
	or a.ShippingOrderCode = @pShippingOrderCode 
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnShippingOrderGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

