
--drop function [dbo].[tfnCustomer_OrderPaymentGet]


/****** Object:  UserDefinedFunction [dbo].[tfnCustomer_OrderPaymentGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCustomer_OrderPaymentGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCustomer_OrderPaymentGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCustomer_OrderPaymentGet] 
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


print 'Update function [dbo].[tfnCustomer_OrderPaymentGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCustomer_OrderPaymentGet]
(
	@pCustomer_OrderId int
)  
RETURNS @Ret_Table Table
(
	[Customer_OrderId] int NOT NULL,
	[Customer_Order_PaymentMethodCodeId] int NOT NULL, --Wechat pay, alipay, card, directPay
	[Customer_Order_PaymentMethodCode] nvarchar(256) NOT NULL, 
	[TotalAmount] decimal(10,2) NOT NULL,
	[CurrencyId] int NOT NULL,
	[Detail] nvarchar(max) NOT NULL,
	[CreateDate] [datetime] NOT NULL
)
as
Begin 
	
	--To be continue
	insert into @Ret_Table
	(
		[Customer_OrderId],
		[Customer_Order_PaymentMethodCodeId], --Wechat pay, alipay, card, directPay
		[Customer_Order_PaymentMethodCode],
		[TotalAmount],
		[CurrencyId],
		[Detail],
		[CreateDate]
	)
	select	a.Customer_OrderId,
			a.Customer_Order_PaymentMethodCodeId,
			c.CodeShort,
			a.TotalAmount,
			a.CurrencyId,
			a.Detail,
			a.CreateDate
	from Customer_Order_Payment a (nolock)
		inner join Customer_Orders b (nolock) on a.Customer_OrderId = b.Id
		inner join CodeList c (nolock) on a.Customer_Order_PaymentMethodCodeId = c.CodeId and c.Category = 'Customer_Order_PaymentMethod'
	where a.Customer_OrderId = @pCustomer_OrderId

Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnCustomer_OrderPaymentGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

