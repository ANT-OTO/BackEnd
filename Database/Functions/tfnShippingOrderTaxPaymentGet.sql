
--drop function [dbo].[tfnShippingOrderTaxPaymentGet]


/****** Object:  UserDefinedFunction [dbo].[tfnShippingOrderTaxPaymentGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnShippingOrderTaxPaymentGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnShippingOrderTaxPaymentGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnShippingOrderTaxPaymentGet] 
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


print 'Update function [dbo].[tfnShippingOrderTaxPaymentGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnShippingOrderTaxPaymentGet]
(
	@pShippingOrderId int
)  
RETURNS @Ret_Table Table
(
	[ShippingOrderTaxPaymentId] int NOT NULL,
	[ShippingOrderId] int NOT NULL,
	[TaxPaymentMethod] int NOT NULL, --shipper, receiver 1, 2
	[TaxPrice] decimal(10,2) NOT NULL,
	[CurrencyId] int NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[ShippingOrderTaxPaymentId],
		[ShippingOrderId],
		[TaxPaymentMethod], --shipper, receiver 1, 2
		[TaxPrice],
		[CurrencyId]
	)
	select b.Id, b.ShippingOrderId, b.TaxPaymentMethod, b.TaxPrice, b.CurrencyId
	from ShippingOrder a (nolock)
		inner join ShippingOrderTaxPayment b (nolock) on a.Id = b.ShippingOrderId
	where a.Id = @pShippingOrderId
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnShippingOrderTaxPaymentGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

