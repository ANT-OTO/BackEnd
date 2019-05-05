
--drop function [dbo].[tfnShippingOrderItemsGet]


/****** Object:  UserDefinedFunction [dbo].[tfnShippingOrderItemsGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnShippingOrderItemsGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnShippingOrderItemsGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnShippingOrderItemsGet] 
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


print 'Update function [dbo].[tfnShippingOrderItemsGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnShippingOrderItemsGet]
(
	@pShippingOrderId int
)  
RETURNS @Ret_Table Table
(
	[ShippingOrderId] int NOT NULL,
	[ShippingOrderItemId] int NOT NULL,
	[ItemId] int NULL,
	[StockItemId] int NULL,
	[ItemName] nvarchar(256) NOT NULL,
	[Quantity] int NOT NULL,
	[Unit] nvarchar(64) NOT NULL,
	[Weight] decimal(10,2) NOT NULL,
	[WeightUnit] int NOT NULL, --1 lb 2 kg 3 g
	[Price] decimal(10, 2) NOT NULL,
	[CurrencyId] int NOT NULL,
	[TaxPrice] decimal(10,2) NOT NULL,
	[SourceArea] nvarchar(64) NOT NULL,
	[GoodCode] nvarchar(256) NOT NULL, --SKU Number
	[StateBarCode] nvarchar(256) NULL, --UPC Number
	[Brand] nvarchar(256) NULL,
	[Specifications] nvarchar(256) NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[LastUpdateBy] int NOT NULL,
	[LastUpdateByType] int NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[ShippingOrderId],
		[ShippingOrderItemId],
		[ItemId],
		[StockItemId],
		[ItemName],
		[Quantity],
		[Unit],
		[Weight],
		[WeightUnit], --1 lb 2 kg 3 g
		[Price],
		[CurrencyId],
		[TaxPrice],
		[SourceArea],
		[GoodCode], --SKU Number
		[StateBarCode], --UPC Number
		[Brand],
		[Specifications],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	a.ShippingOrderId, a.Id, a.ItemId, a.StockItemId, a.ItemName,
			a.Quantity, a.Unit, a.[Weight], a.WeightUnit, a.Price,
			a.CurrencyId, a.TaxPrice, a.SourceArea, a.GoodCode, a.StateBarCode,
			a.Brand, a.Specifications, a.CreateDate, a.LastUpdate, a.LastUpdateBy,
			a.LastUpdateByType
	from ShippingOrderItems a (nolock)
		inner join ShippingOrder b (nolock) on a.ShippingOrderId = b.Id
	where b.Id = @pShippingOrderId
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnShippingOrderItemsGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

