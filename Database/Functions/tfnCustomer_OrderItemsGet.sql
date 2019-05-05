
--drop function [dbo].[tfnCustomer_OrderItemsGet]


/****** Object:  UserDefinedFunction [dbo].[tfnCustomer_OrderItemsGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCustomer_OrderItemsGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCustomer_OrderItemsGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCustomer_OrderItemsGet] 
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


print 'Update function [dbo].[tfnCustomer_OrderItemsGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCustomer_OrderItemsGet]
(
	@pCustomer_OrderId int
)  
RETURNS @Ret_Table Table
(
	[Customer_OrderId] int NOT NULL,
	[ItemId] int NOT NULL,
	[SaleTitle] nvarchar(256) NOT NULL,
	[SaleDescription] nvarchar(256) NOT NULL,
	[VariationTitle] nvarchar(256) NOT NULL,
	[UnitAmount] decimal(10,2) NOT NULL,
	[Quantity] int NOT NULL,
	[TotalAmount] decimal(10,2) NOT NULL,
	[CurrencyId] int NOT NULL
)
as
Begin 
	
	--To be continue
	insert into @Ret_Table
	(
		[Customer_OrderId],
		[ItemId],
		[SaleTitle],
		[SaleDescription],
		[VariationTitle],
		[UnitAmount],
		[Quantity],
		[TotalAmount],
		[CurrencyId]
	)
	select	a.Customer_OrderId,
			c.ItemId,
			c.Title,
			c.[Description],
			c.VariationTitle,
			a.UnitAmount,
			a.Quantity,
			a.TotalAmount,
			a.CurrencyId
	from Customer_Order_Items a (nolock)
		inner join Customer_Orders b (nolock) on a.Customer_OrderId = b.Id
		inner join ItemOnSale c (nolock) on a.ItemId = c.ItemId
		inner join (
			select a.ItemId as ItemId, max(a.Id) as ItemOnSaleId
			from ItemOnSale a (nolock) 
			group by a.ItemId
		) d on d.ItemOnSaleId = c.Id and d.ItemId = c.ItemId
	where b.Id = @pCustomer_OrderId
	and a.Quantity > 0	


Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnCustomer_OrderItemsGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

