
--drop function [dbo].[tfnShippingChannelGetById]


/****** Object:  UserDefinedFunction [dbo].[tfnShippingChannelGetById]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnShippingChannelGetById]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnShippingChannelGetById] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnShippingChannelGetById] 
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


print 'Update function [dbo].[tfnShippingChannelGetById] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnShippingChannelGetById]
(
	@pShippingChannelId int,
	@pCompanyId int
)  
RETURNS @Ret_Table Table
(
	[CompanyId] int NOT NULL,
	[ShippingChannelId] int NOT NULL,
	[ShippingChannelCompanyId] int NOT NULL,
	[ShippingChannelName] nvarchar(256) NOT NULL,
	[ShippingChannelCode] nvarchar(256) NOT NULL,
	[ShippingChannelTypeCodeId] int NOT NULL,  --select * from CodeList where Category = 'ShippingChannelType'
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
	[SFExpressType] nvarchar(256) NOT NULL
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
		TaxPaymentMethodAvailable,
		[IDCheckBeforeShipping],
		[IDCheckDuplicateBeforeShipping],
		[IDDuplicateNumberLimitation],
		[SFExpressType]
	)
	select	a.LogisticCompanyId, b.Id, 0, b.ChannelName, b.ChannelCode, b.ShippingChannelTypeCodeId, 
			b.TaxRate, b.PriceFirstRate, b.PriceAdditionRate,
			b.WeightUnit, b.WeightFirst, b.UnitPriceFirst, b.UnitPriceAdditional,
			b.JumpToInt, isnull(b.TaxPaymentMethodAvailable, 0),
			isnull(z.[IDCheckBeforeShipping], 0),
			isnull(z.[IDCheckDuplicateBeforeShipping], 0),
			isnull(z.[IDDuplicateNumberLimitation], 0),
			isnull(y.SFExpressType, '')
	from ShippingChannelLogisticCompany a (nolock)  
		inner join ShippingChannel b (nolock) on a.ShippingChannelId = b.Id
		left join [ShippingChannelIDCheck] z (nolock) on b.Id = z.ShippingChannelId and z.Available = 1
		left join [ShippingChannelSFExpressType] y (nolock) on b.Id = y.ShippingChannelId
	where a.LogisticCompanyId = @pCompanyId
	and a.Available = 1
	and b.Id = @pShippingChannelId


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
		TaxPaymentMethodAvailable,
		[IDCheckBeforeShipping],
		[IDCheckDuplicateBeforeShipping],
		[IDDuplicateNumberLimitation],
		[SFExpressType]
	)
	select	a.LogisticCompanyId, b.Id, isnull(z.Id, 0), b.ChannelName, b.ChannelCode, b.[ShippingChannelTypeCodeId],
			isnull(z.TaxRate, b.TaxRate),isnull(z.PriceFirstRate, b.PriceFirstRate), isnull(z.PriceAdditionRate, b.PriceAdditionRate),
			isnull(z.WeightUnit, b.WeightUnit), isnull(z.WeightFirst, b.WeightFirst), 
			isnull(z.UnitPriceFirst, b.UnitPriceFirst), isnull(z.UnitPriceAdditional, b.UnitPriceAdditional),
			isnull(z.JumpToInt, b.JumpToInt), isnull(b.TaxPaymentMethodAvailable, 0),
			isnull(y.[IDCheckBeforeShipping], 0),
			isnull(y.[IDCheckDuplicateBeforeShipping], 0),
			isnull(y.[IDDuplicateNumberLimitation], 0),
			isnull(x.SFExpressType, '')
	from ShippingChannelLogisticCompany a (nolock)  
		inner join ShippingChannel b (nolock) on a.ShippingChannelId = b.Id
		inner join CompanyLogisticCompany c (nolock) on a.LogisticCompanyId = c.CompanyId
		left join ShippingChannelCompany z (nolock) on c.CustomerCompanyId = z.SourceCompanyId and b.Id = z.ShippingChannelId
		left join [ShippingChannelIDCheck] y (nolock) on b.Id = y.ShippingChannelId and y.Available = 1
		left join [ShippingChannelSFExpressType] x (nolock) on b.Id = x.ShippingChannelId
	where c.CustomerCompanyId = @pCompanyId
	and a.Available = 1
	and b.Id = @pShippingChannelId
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnShippingChannelGetById](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

