
--drop function [dbo].[tfnCompanyShippingChannelListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnCompanyShippingChannelListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCompanyShippingChannelListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCompanyShippingChannelListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCompanyShippingChannelListGet] 
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


print 'Update function [dbo].[tfnCompanyShippingChannelListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCompanyShippingChannelListGet]
(
	@pCompanyId int
)  
RETURNS @Ret_Table Table
(
	[CompanyId] int NOT NULL,
	[ShippingChannelId] int NOT NULL,
	[ShippingChannelCompanyId] int NULL,
	[ShippingChannelName] nvarchar(256) NOT NULL,
	[ShippingChannelCode] nvarchar(256) NOT NULL,
	[ShippingChannelTypeCodeId] int NOT NULL,
	[TaxRate] decimal(10,2) NOT NULL, --%
	[PriceFirstRate] decimal(10,2) NOT NULL,
	[PriceAdditionRate] decimal(10, 2) NOT NULL,
	[WeightUnit] int NOT NULL, -- lb, kg, g
	[WeightFirst] int NOT NULL, --first weight
	[UnitPriceFirst] decimal(10,2) NOT NULL,
	[UnitPriceAdditional] decimal(10,2) NOT NULL, 
	[JumpToInt] bit NOT NULL,
	TaxPaymentMethodAvailable bit NOT NULL,
	[IDCheckBeforeShipping] bit NOT NULL,
	[IDCheckDuplicateBeforeShipping] bit NOT NULL,
	[IDDuplicateNumberLimitation] int NOT NULL,
	[Display] bit NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[CompanyId],
		[ShippingChannelId],
		[ShippingChannelCompanyId],
		[ShippingChannelName],
		[ShippingChannelCode],
		[ShippingChannelTypeCodeId],
		[TaxRate], --%
		[PriceFirstRate],
		[PriceAdditionRate],
		[WeightUnit], -- lb, kg, g
		[WeightFirst], --first weight
		[UnitPriceFirst],
		[UnitPriceAdditional], 
		[JumpToInt],
		[TaxPaymentMethodAvailable],
		[IDCheckBeforeShipping],
		[IDCheckDuplicateBeforeShipping],
		[IDDuplicateNumberLimitation],
		[Display]
	)
	select	a.LogisticCompanyId, b.Id, 0, b.ChannelName, b.ChannelCode, b.[ShippingChannelTypeCodeId],
			b.TaxRate, b.PriceFirstRate, b.PriceAdditionRate,
			b.WeightUnit, b.WeightFirst, b.UnitPriceFirst, b.UnitPriceAdditional,
			b.JumpToInt,b.TaxPaymentMethodAvailable,
			isnull(z.IDCheckBeforeShipping, 0), isnull(z.IDCheckDuplicateBeforeShipping, 0),
			isnull(z.IDDuplicateNumberLimitation, 0), 1
	from ShippingChannelLogisticCompany a (nolock)  
		inner join ShippingChannel b (nolock) on a.ShippingChannelId = b.Id
		left join ShippingChannelIDCheck z (nolock) on b.Id = z.ShippingChannelId
	where a.LogisticCompanyId = @pCompanyId
	and a.Available = 1


	insert into @Ret_Table
	(
		[CompanyId],
		[ShippingChannelId],
		[ShippingChannelCompanyId],
		[ShippingChannelName],
		[ShippingChannelCode],
		[ShippingChannelTypeCodeId],
		[TaxRate], --%
		[PriceFirstRate],
		[PriceAdditionRate],
		[WeightUnit], -- lb, kg, g
		[WeightFirst], --first weight
		[UnitPriceFirst],
		[UnitPriceAdditional], 
		[JumpToInt],  
		[TaxPaymentMethodAvailable], 
		[IDCheckBeforeShipping],
		[IDCheckDuplicateBeforeShipping],
		[IDDuplicateNumberLimitation],
		[Display]
	)
	select	a.LogisticCompanyId, b.Id,isnull(z.Id, 0), b.ChannelName, b.ChannelCode, b.[ShippingChannelTypeCodeId],
			isnull(z.TaxRate, b.TaxRate),isnull(b.PriceFirstRate, b.PriceFirstRate), isnull(z.PriceAdditionRate, b.PriceAdditionRate),
			isnull(z.WeightUnit, b.WeightUnit), isnull(z.WeightFirst, b.WeightFirst), 
			isnull(z.UnitPriceFirst, b.UnitPriceFirst), isnull(z.UnitPriceAdditional, b.UnitPriceAdditional),
			isnull(z.JumpToInt, b.JumpToInt), isnull(z.TaxPaymentMethodAvailable, b.TaxPaymentMethodAvailable),
			isnull(y.IDCheckBeforeShipping, 0), isnull(y.IDCheckDuplicateBeforeShipping, 0),
			isnull(y.IDDuplicateNumberLimitation, 0), 1
	from ShippingChannelLogisticCompany a (nolock)  
		inner join ShippingChannel b (nolock) on a.ShippingChannelId = b.Id
		inner join CompanyLogisticCompany c (nolock) on a.LogisticCompanyId = c.CompanyId
		left join ShippingChannelCompany z (nolock) on c.CustomerCompanyId = z.SourceCompanyId
		left join ShippingChannelIDCheck y (nolock) on b.Id = y.ShippingChannelId
		left join ShippingChannelCompanyDisplay x (nolock) on b.Id = x.ShippingChannelId and x.SourceCompanyId = @pCompanyId and x.HandlerCompanyId = a.LogisticCompanyId
	where c.CustomerCompanyId = @pCompanyId
	and a.Available = 1
	and (x.Id is null or x.Display = 1)
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnCompanyShippingChannelListGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

