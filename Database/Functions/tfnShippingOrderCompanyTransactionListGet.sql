
--drop function [dbo].[tfnShippingOrderCompanyTransactionListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnShippingOrderCompanyTransactionListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnShippingOrderCompanyTransactionListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnShippingOrderCompanyTransactionListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnShippingOrderCompanyTransactionListGet] 
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


print 'Update function [dbo].[tfnShippingOrderCompanyTransactionListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnShippingOrderCompanyTransactionListGet]
(
	@pShippingOrderId int
)  
RETURNS @Ret_Table Table
(
	[CompanyId] int NOT NULL,
	[CompanyName] nvarchar(256) NOT NULL,
	[CompanyTransactionId] int NOT NULL,
	[TransactionTypeCodeId] int NOT NULL,
	[TransactionTypeCode] nvarchar(256) NOT NULL,
	[Amount] decimal(10,2) NOT NULL,
	[CurrencyId] int NOT NULL,
	[Currency] nvarchar(256) NOT NULL,
	[Description] nvarchar(256) NOT NULL,
	[UserId] int NOT NULL,
	[UserName] nvarchar(256) NOT NULL,
	[isSourceCompany] bit NOT NULL
)
as
Begin 
	
	declare @pSourceCompanyId int = 0
	declare @pHandlerCompanyId int = 0

	select	@pSourceCompanyId = b.SourceCompanyId,
			@pHandlerCompanyId = b.HandlerCompanyId
	from ShippingOrder a (nolock)
		inner join ShippingOrderCompany b (nolock) on a.Id = b.ShippingOrderId
	where a.Id = @pShippingOrderId

	insert into @Ret_Table
	(
		[CompanyId],
		[CompanyName],
		[CompanyTransactionId],
		[TransactionTypeCodeId],
		[TransactionTypeCode],
		[Amount],
		[CurrencyId],
		[Currency],
		[Description],
		[UserId],
		[UserName],
		[isSourceCompany]
	)
	select	b.Id, b.CompanyName, a.Id, a.TransactionTypeCodeId,
			c.CodeShort, a.Amount, a.CurrencyId, d.Code, a.[Description], a.UserId, isnull(z.FirstName, ''), 1
	from CompanyTransaction a (nolock)
		inner join Company b (nolock) on a.CompanyId = b.Id
		inner join CodeList c (nolock) on a.TransactionTypeCodeId = c.CodeId and c.Category = 'CompanyTransaction'
		inner join Currency d (nolock) on a.CurrencyId = d.Id
		left join [User] z (nolock) on a.UserId = z.Id
	where a.SourceId = @pShippingOrderId
	and a.SourceTable = 'ShippingOrder'
	and a.CompanyId = @pSourceCompanyId

	insert into @Ret_Table
	(
		[CompanyId],
		[CompanyName],
		[CompanyTransactionId],
		[TransactionTypeCodeId],
		[TransactionTypeCode],
		[Amount],
		[CurrencyId],
		[Currency],
		[Description],
		[UserId],
		[UserName],
		[isSourceCompany]
	)
	select	b.Id, b.CompanyName, a.Id, a.TransactionTypeCodeId,
			c.CodeShort, a.Amount, a.CurrencyId, d.Code, a.[Description], a.UserId, isnull(z.FirstName, ''), 0
	from CompanyTransaction a (nolock)
		inner join Company b (nolock) on a.CompanyId = b.Id
		inner join CodeList c (nolock) on a.TransactionTypeCodeId = c.CodeId and c.Category = 'CompanyTransaction'
		inner join Currency d (nolock) on a.CurrencyId = d.Id
		left join [User] z (nolock) on a.UserId = z.Id
	where a.SourceId = @pShippingOrderId
	and a.SourceTable = 'ShippingOrder'
	and a.CompanyId = @pHandlerCompanyId
	


	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnShippingOrderCompanyTransactionListGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

