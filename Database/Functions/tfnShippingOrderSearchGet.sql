
--drop function [dbo].[tfnShippingOrderSearchGet]


/****** Object:  UserDefinedFunction [dbo].[tfnShippingOrderSearchGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnShippingOrderSearchGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnShippingOrderSearchGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnShippingOrderSearchGet] 
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


print 'Update function [dbo].[tfnShippingOrderSearchGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnShippingOrderSearchGet]
(
	@pShippingOrderId int
)  
RETURNS @Ret_Table Table
(
	ShippingOrderId int,
	CustomerId int NULL,
	CustomerOrderId int NULL,
	SourceCompanyId int NOT NULL,
	HandlerCompanyId int NOT NULL,
	ReferenceOrderCode nvarchar(256) NULL,
	BatchHandlerNumber nvarchar(256) NOT NULL,
	ShippingFromAddressId int NOT NULL,
	ShippingToAddressId int NOT NULL,
	ShippingChannelId int NULL,
	Price decimal(10,2) NULL,
	CurrencyId int NULL,
	TotalWeight decimal(10,2) NULL,
	WeightUnitId int NULL,
	ShippingOrderStatusCodeId int NOT NULL,
	ShippingOrderStatus nvarchar(256) NOT NULL,
	ShippingOrderCode nvarchar(256) NOT NULL,
	UserId int NOT NULL,
	CreateDate datetime NOT NULL,
	LastUpdate datetime NOT NULL,
	ShippingOrderIdentityProfileId int NULL,
	LabelReady bit NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		ShippingOrderId,
		CustomerId,
		CustomerOrderId,
		SourceCompanyId,
		HandlerCompanyId,
		ReferenceOrderCode,
		BatchHandlerNumber,
		ShippingFromAddressId,
		ShippingToAddressId,
		ShippingChannelId,
		Price,
		CurrencyId,
		TotalWeight,
		WeightUnitId,
		ShippingOrderStatusCodeId,
		ShippingOrderStatus,
		ShippingOrderCode,
		UserId,
		CreateDate,
		LastUpdate,
		ShippingOrderIdentityProfileId,
		LabelReady
	)
	select	a.Id, a.CustomerId, a.CustomerOrderId, b.SourceCompanyId, b.HandlerCompanyId, a.ReferenceOrderCode, isnull(y2.BatchNumber,''),
			a.ShippingFromAddressId, a.ShippingToAddressId, a.ShippingChannelId,
			a.Price, a.CurrencyId, a.TotalWeight, a.WeightUnitId, a.ShippingOrderStatusCodeId,
			a1.CodeShort, a.ShippingOrderCode, a.UserId, a.CreateDate, a.LastUpdate, z.Id, 0
	from ShippingOrder a (nolock)
		inner join CodeList a1 (nolock) on a.ShippingOrderStatusCodeId = a1.CodeId and a1.Category = 'ShippingOrderStatus'
		inner join ShippingOrderCompany b (nolock) on a.Id = b.ShippingOrderId
		left join ShippingOrderIdentityProfile z (nolock) on a.Id = z.ShippingOrderId
		left join ShippingOrderBatchHandlerRecord y (nolock) on a.Id = y.ShippingOrderId
		left join BatchHandlerRecord y1 (nolock) on y.BatchHandlerRecordId = y1.Id and y.Available = 1
		left join BatchHandler y2 (nolock) on y1.BatchHandlerId = y2.Id
		inner join ShippingAddress c (nolock) on a.ShippingFromAddressId = c.Id
		inner join ShippingAddress d (nolock) on a.ShippingToAddressId = d.Id
		inner join [Address] d1 (nolock) on d.AddressId = d1.Id
	where a.Id = @pShippingOrderId
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnShippingOrderSearchGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

