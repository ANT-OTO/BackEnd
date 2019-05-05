
--drop function [dbo].[tfnItemPurchaseTaskGet]


/****** Object:  UserDefinedFunction [dbo].[tfnItemPurchaseTaskGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnItemPurchaseTaskGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnItemPurchaseTaskGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnItemPurchaseTaskGet] 
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


print 'Update function [dbo].[tfnItemPurchaseTaskGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnItemPurchaseTaskGet]
(
	@pItemPurchaseTaskId int
)  
RETURNS @Ret_Table Table
(
	[ItemPurchaseTaskId] [int] NOT NULL,
	[ItemPurchasePoolId] int NOT NULL,
	[ItemId] int NOT NULL,
	[Quantity] int NOT NULL,
	[ItemPurchaseStatusCodeId] int NOT NULL, --select * from CodeList where Category = 'ItemPurchaseStatus'
	[ItemPurchaseStatus] nvarchar(256) NOT NULL,
	[UpdateQuantity] int NOT NULL,
	[Reason] nvarchar(max) NOT NULL,
	DiscountDetail nvarchar(max) NOT NULL,
	[PurchasePlace] nvarchar(256) NOT NULL,
	[FinalUnitPrice] decimal(10, 2) NULL,
	[FinalTotalPrice] decimal(10, 2) NULL,
	[CurrencyId] int NOT NULL,
	[UserId] int NOT NULL,
	[UserName] nvarchar(256) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[LastUpdateBy] int NOT NULL,
	[LastUpdateByType] int NOT NULL
)
as
Begin 
	
	--To be continue
	insert into @Ret_Table
	(
		[ItemPurchaseTaskId],
		[ItemPurchasePoolId],
		[ItemId],
		[Quantity],
		[ItemPurchaseStatusCodeId], --select * from CodeList where Category = 'ItemPurchaseStatus'
		[ItemPurchaseStatus],
		[UpdateQuantity],
		[Reason],
		DiscountDetail,
		[PurchasePlace],
		[FinalUnitPrice],
		[FinalTotalPrice],
		[CurrencyId],
		[UserId],
		[UserName],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	a.Id, b.Id, b.ItemId, a.Quantity, a.ItemPurchaseStatusCodeId, a1.CodeShort,
			a.UpdateQuantity, a.Reason, isnull(b.PurchaseDetail, ''), isnull(b.PurchasePlace, N'未知'), a.FinalUnitPrice, a.FinalTotalPrice, a.CurrencyId,
			a.UserId, isnull(c.FirstName, '') + ' ' + isnull(c.LastName, ''), a.CreateDate,
			a.LastUpdate, a.LastUpdateBy, a.LastUpdateByType
	from ItemPurchaseTask a (nolock)
		inner join CodeList a1 (nolock) on a.ItemPurchaseStatusCodeId = a1.CodeId and a1.Category = 'ItemPurchaseStatus'
		inner join ItemPurchasePool b (nolock) on a.ItemPurchasePoolId = b.Id
		inner join [User] c (nolock) on a.UserId = c.Id
	where a.Id = @pItemPurchaseTaskId



Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnItemPurchaseTaskGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

