
--drop function [dbo].[tfnCustomerShoppingCartContentGet]


/****** Object:  UserDefinedFunction [dbo].[tfnCustomerShoppingCartContentGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCustomerShoppingCartContentGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCustomerShoppingCartContentGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCustomerShoppingCartContentGet] 
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


print 'Update function [dbo].[tfnCustomerShoppingCartContentGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCustomerShoppingCartContentGet]
(
	@pCustomerId int
)  
RETURNS @Ret_Table Table
(
	[Customer_ShoppingCart_ItemsId] int NOT NULL,
	[CustomerId] int NOT NULL,
	[ItemId] int NOT NULL,
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
		[Customer_ShoppingCart_ItemsId],
		[CustomerId],
		[ItemId],
		[UnitAmount],
		[Quantity],
		[TotalAmount],
		[CurrencyId]
	)
	select	a.Id, @pCustomerId, a.ItemId, a.UnitAmount, a.Quantity,
			a.TotalAmount, a.CurrencyId
	from Customer_ShoppingCart_Items a (nolock)
	where a.CustomerId = @pCustomerId
	and a.Quantity > 0



Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnCustomerShoppingCartContentGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

