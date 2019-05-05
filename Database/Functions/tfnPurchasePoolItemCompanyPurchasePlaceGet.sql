
--drop function [dbo].[tfnPurchasePoolItemCompanyPurchasePlaceGet]


/****** Object:  UserDefinedFunction [dbo].[tfnPurchasePoolItemCompanyPurchasePlaceGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnPurchasePoolItemCompanyPurchasePlaceGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnPurchasePoolItemCompanyPurchasePlaceGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnPurchasePoolItemCompanyPurchasePlaceGet] 
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


print 'Update function [dbo].[tfnPurchasePoolItemCompanyPurchasePlaceGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnPurchasePoolItemCompanyPurchasePlaceGet]
(
	@pCompanyId int
)  
RETURNS @Ret_Table Table
(
	[ItemPurchasePoolCompanyId] int NOT NULL,
	[ItemPurchasePoolId] int NOT NULL,
	[ItemId] int NOT NULL,
	[Quantity] int NOT NULL,
	[AvailableQuantity] int NOT NULL,
	[PurchasePrice] decimal(10,2) NOT NULL,
	[CurrencyId] int NOT NULL,
	[PurchasePlace] nvarchar(256) NOT NULL,
	[PurchaseDetail] nvarchar(256) NOT NULL,
	[LastQueryDate] datetime NOT NULL
)
as
Begin 
	
	--To be continue
	insert into @Ret_Table
	(
		[ItemPurchasePoolCompanyId],
		[ItemPurchasePoolId],
		[ItemId],
		[Quantity],
		[AvailableQuantity],
		[PurchasePrice],
		[CurrencyId],
		[PurchasePlace],
		[PurchaseDetail],
		[LastQueryDate]
	)
	select	b.Id,
			a.Id,
			a.ItemId,
			a.Quantity,
			a.AvailableQuantity,
			a.PurchasePrice,
			a.CurrencyId,
			a.PurchasePlace,
			a.PurchaseDetail,
			b.LastUpdateUtcDate
	from ItemPurchasePool a (nolock)
		inner join ItemPurchasePoolCompany b (nolock) on a.ItemPurchasePoolCompanyId = b.Id
	where b.CompanyId = @pCompanyId
	order by a.PurchasePlace



Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnPurchasePoolItemCompanyPurchasePlaceGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

