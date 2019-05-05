
--drop function [dbo].[tfnItemOnSaleInfoGet]


/****** Object:  UserDefinedFunction [dbo].[tfnItemOnSaleInfoGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnItemOnSaleInfoGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnItemOnSaleInfoGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnItemOnSaleInfoGet] 
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


print 'Update function [dbo].[tfnItemOnSaleInfoGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnItemOnSaleInfoGet]
(
    @pItemOnSaleId int,
	@pItemId int
)  
RETURNS @Ret_Table Table
(
	[ItemId] int NOT NULL,
	[ItemOnSaleId] int NOT NULL,
	[Title] nvarchar(256) NOT NULL,
	[Description] nvarchar(256) NOT NULL,
	[VariationTitle] nvarchar(256) NOT NULL,
	[Price] decimal(10,2) NOT NULL,
	[CurrencyId] int NOT NULL,
	[OnMarket] bit NOT NULL
)
as
Begin 
	
	if(isnull(@pItemId, 0) > 0)
	begin
		select @pItemOnSaleId = a.Id 
		from ItemOnSale a (nolock)
		where a.ItemId = @pItemId
		and a.Available = 1
	end
	declare @pOnMarket bit = 0
	if(exists(
		select *
		from ItemOnSale a
		where a.Id = @pItemOnSaleId
		and a.Available = 1
	))
	begin
		select @pOnMarket = 1
	end
	if(@pOnMarket = 0
	and exists(
		select * 
		from ItemOnSale a (nolock)
		where a.ItemId = @pItemId
	))
	begin
		insert into @Ret_Table
		(
			[ItemId],
			[ItemOnSaleId],
			[Title],
			[Description],
			[VariationTitle],
			[Price],
			[CurrencyId],
			[OnMarket]
		)
		select	top 1 a.ItemId,
				a.Id,
				a.Title,
				a.Description,
				a.VariationTitle,
				a.Price,
				a.CurrencyId,
				@pOnMarket
		from ItemOnSale a (nolock)
		where a.ItemId = @pItemId
		order by a.Id desc
	end
	else if(@pOnMarket = 0 and not exists(
		select * 
		from ItemOnSale a (nolock)
		where a.ItemId = @pItemId
	))
	begin
		declare @pWizardSessionId int = 0
		select @pWizardSessionId = a.Id
		from WizardSession a (nolock)
		where a.SourceId = @pItemId
		and a.SourceTable = 'Item'
		declare @pItemName nvarchar(256) = ''
		declare @pItemDescription nvarchar(max) = ''

		select @pItemName = a.InputTextValue
		from [dbo].[tfnWizardSessionInputGet]
		(
			@pWizardSessionId,
			'ProductName'
		) a

		select @pItemDescription = a.InputTextValue
		from [dbo].[tfnWizardSessionInputGet]
		(
			@pWizardSessionId,
			'ProductDesc'
		) a

		declare @pVariationTitle nvarchar(256) = ''
		select @pVariationTitle = a.VariationTitle
		from tfnItemVariationInfoGet(@pItemId, @pWizardSessionId) a
		
		--select * from Currency where Code = 'CNY'
		declare @pCurrencyId int = 0
		select @pCurrencyId = a.Id 
		from Currency a (nolock)
		where a.Code = 'CNY'
		insert into @Ret_Table
		(
			[ItemId],
			[ItemOnSaleId],
			[Title],
			[Description],
			[VariationTitle],
			[Price],
			[CurrencyId],
			[OnMarket]
		)
		select	top 1 a.ItemId,
				a.Id,
				@pItemId,
				@pItemDescription,
				@pVariationTitle,
				0.0,
				@pCurrencyId,
				@pOnMarket
		from ItemOnSale a (nolock)
		where a.ItemId = @pItemId
		order by a.Id desc

		if(@@ROWCOUNT = 0)
		begin
			insert into @Ret_Table
			(
				[ItemId],
				[ItemOnSaleId],
				[Title],
				[Description],
				[VariationTitle],
				[Price],
				[CurrencyId],
				[OnMarket]
			)
			select	@pItemId,
					0,
					@pItemName,
					@pItemDescription,
					@pVariationTitle,
					0.0,
					@pCurrencyId,
					@pOnMarket
		end
	end
	else
	begin
		insert into @Ret_Table
		(
			[ItemId],
			[ItemOnSaleId],
			[Title],
			[Description],
			[VariationTitle],
			[Price],
			[CurrencyId],
			[OnMarket]
		)
		select	a.ItemId,
				a.Id,
				a.Title,
				a.Description,
				a.VariationTitle,
				a.Price,
				a.CurrencyId,
				@pOnMarket
		from ItemOnSale a (nolock)
		where a.ItemId = @pItemId
		and a.Id = @pItemOnSaleId
		and a.Available = 1
		order by a.Id desc
	end
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnItemOnSaleInfoGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

