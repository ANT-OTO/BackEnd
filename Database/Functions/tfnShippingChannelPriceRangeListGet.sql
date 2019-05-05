
--drop function [dbo].[tfnShippingChannelPriceRangeListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnShippingChannelPriceRangeListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnShippingChannelPriceRangeListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnShippingChannelPriceRangeListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnShippingChannelPriceRangeListGet] 
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


print 'Update function [dbo].[tfnShippingChannelPriceRangeListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnShippingChannelPriceRangeListGet]
(
	@pShippingChannelId int,
	@pCompanyId int
)  
RETURNS @Ret_Table Table
(
	[Id] int identity(1,1) NOT NULL,
	[CompanyId] int NOT NULL,
	[ShippingChannelCompanyId] int NULL,
	[ShippingChannelId] int NOT NULL,
	[CurrencyId] int NOT NULL,
	[WeightMin] decimal(10, 2) NOT NULL, --greater than
	[WeightMax] decimal(10, 2) NOT NULL, --less than or equal to
	[Price] decimal(10, 2) NOT NULL,
	[ShippingChannelPriceRangeId] int NOT NULL,
	[Customized] bit NOT NULL
)
as
Begin 
	
	if(exists(
		select *
		from CompanyLogisticCompany a (nolock)
		where a.CompanyId = @pCompanyId
	))
	begin
		insert into @Ret_Table
		(
			[CompanyId],
			[ShippingChannelCompanyId],
			[ShippingChannelId],
			[CurrencyId],
			[WeightMin], --greater than
			[WeightMax], --less than or equal to
			[Price],
			[ShippingChannelPriceRangeId],
			[Customized]
		)
		select @pCompanyId, 0, a.Id, c.CurrencyId, c.WeightMin, c.WeightMax, c.Price, c.Id, 1
		from ShippingChannel a (nolock)
			inner join ShippingChannelLogisticCompany b (nolock) on a.Id = b.ShippingChannelId
			inner join ShippingChannelPriceRange c (nolock) on a.Id = c.ShippingChannelId
		where b.Available = 1 
		and c.Available = 1
		and b.LogisticCompanyId = @pCompanyId
		and a.Id = @pShippingChannelId
		order by c.WeightMin
	end
	else
	begin
		insert into @Ret_Table
		(
			[CompanyId],
			[ShippingChannelCompanyId],
			[ShippingChannelId],
			[CurrencyId],
			[WeightMin], --greater than
			[WeightMax], --less than or equal to
			[Price],
			[ShippingChannelPriceRangeId],
			[Customized]
		)
		select @pCompanyId, isnull(d.Id, 0), a.Id, c.CurrencyId, c.WeightMin, c.WeightMax, c.Price, c.Id, 0
		from ShippingChannel a (nolock)
			inner join ShippingChannelLogisticCompany b (nolock) on a.Id = b.ShippingChannelId
			inner join CompanyLogisticCompany b1 (nolock) on b.LogisticCompanyId = b1.CompanyId
			inner join ShippingChannelPriceRange c (nolock) on a.Id = c.ShippingChannelId
			left join ShippingChannelCompany d (nolock) on a.Id = d.ShippingChannelId and d.SourceCompanyId = @pCompanyId
		where b.Available = 1 
		and c.Available = 1
		and b1.Available = 1
		--and d.SourceCompanyId = @pCompanyId
		and b1.CustomerCompanyId = @pCompanyId
		and a.Id = @pShippingChannelId
		order by c.WeightMin

		update a
		set a.Customized = 1,
			a.Price = c.Price
		from @Ret_Table a
			inner join ShippingChannelCompany b (nolock) on a.ShippingChannelId = b.ShippingChannelId and b.SourceCompanyId = @pCompanyId
			inner join ShippingChannelPriceRangeCompany c (nolock) on a.ShippingChannelPriceRangeId = c.ShippingChannelPriceRangeId and b.Id = c.ShippingChannelCompanyId
		where b.Available = 1
		and c.Available = 1
		
	end

	


	
	
	
Return 


/* 
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnShippingChannelPriceRangeListGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

