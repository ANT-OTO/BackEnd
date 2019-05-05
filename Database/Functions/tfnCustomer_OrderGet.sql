
--drop function [dbo].[tfnCustomer_OrderGet]


/****** Object:  UserDefinedFunction [dbo].[tfnCustomer_OrderGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCustomer_OrderGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCustomer_OrderGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCustomer_OrderGet] 
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


print 'Update function [dbo].[tfnCustomer_OrderGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCustomer_OrderGet]
(
	@pCustomer_OrderId int
)  
RETURNS @Ret_Table Table
(
	[Customer_OrderId] int NOT NULL,
	[OrderCode] nvarchar(256) NOT NULL, --Unified Order Code
	[CustomerId] int NOT NULL,
	[CustomerOrderStatusCodeId] int NOT NULL,
	[CustomerOrderStatus] nvarchar(256) NOT NULL,
	[CustomerAddressId] int NOT NULL,
	[Date_Placed] datetime NOT NULL,
	[Date_Paid] datetime NULL,
	[OrderDiscountId] int NULL,
	[TotalPriceAmount] decimal(10,2) NOT NULL,
	[CurrencyId] int NOT NULL,
	[SourceId] int NULL,
	[SourceTable] nvarchar(64) NULL
)
as
Begin 
	
	--To be continue
	insert into @Ret_Table
	(
		[Customer_OrderId],
		[OrderCode], --Unified Order Code
		[CustomerId],
		[CustomerOrderStatusCodeId],
		[CustomerOrderStatus],
		[CustomerAddressId],
		[Date_Placed],
		[Date_Paid],
		[OrderDiscountId],
		[TotalPriceAmount],
		[CurrencyId],
		[SourceId],
		[SourceTable]
	)
	select	a.Id,
			a.OrderCode,
			a.CustomerId,
			a.CustomerOrderStatusCodeId,
			b.CodeShort,
			c.Customer_AddressId,
			a.Date_Placed,
			a.Date_Paid,
			a.OrderDiscountId,
			a.TotalPriceAmount,
			a.CurrencyId,
			a.SourceId,
			a.SourceTable
	from Customer_Orders a (nolock)
		inner join CodeList b (nolock) on a.CustomerOrderStatusCodeId = b.CodeId and b.Category = 'CustomerOrderStatus'
		inner join Customer_Order_ShippingAddress c (nolock) on a.Id = c.Customer_OrderId
	where a.Id = @pCustomer_OrderId



Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnCustomer_OrderGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

