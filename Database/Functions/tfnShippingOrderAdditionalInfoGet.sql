
--drop function [dbo].[tfnShippingOrderAdditionalInfoGet]


/****** Object:  UserDefinedFunction [dbo].[tfnShippingOrderAdditionalInfoGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnShippingOrderAdditionalInfoGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnShippingOrderAdditionalInfoGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnShippingOrderAdditionalInfoGet] 
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


print 'Update function [dbo].[tfnShippingOrderAdditionalInfoGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnShippingOrderAdditionalInfoGet]
(
	@pShippingOrderId int,
	@pShippingOrderCode nvarchar(256)
)  
RETURNS @Ret_Table Table
(
	[ShippingOrderId] int NOT NULL,
	[Width] decimal(10, 2) NOT NULL,
	[Height] decimal(10, 2) NOT NULL,
	[Length] decimal(10, 2) NOT NULL,
	PackageCount int NOT NULL,
	ShippingOrderTaxPaymentTypeCodeId int NOT NULL,
	ShippingOrderTaxPaymentType nvarchar(256) NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[ShippingOrderId],
		[Width],
		[Height],
		[Length],
		PackageCount,
		ShippingOrderTaxPaymentTypeCodeId,
		ShippingOrderTaxPaymentType
	)
	select	a.ShippingOrderId, a.Width, a.Height,
			a.[Length], a.PackageCount, a.ShippingOrderTaxPaymentTypeCodeId, c.CodeShort
	from ShippingOrderAdditionalInfo a (nolock)
		inner join ShippingOrder b (nolock) on a.ShippingOrderId = b.Id
		inner join CodeList c (nolock) on c.Category = 'ShippingOrderTaxPaymentType' and c.CodeId = a.ShippingOrderTaxPaymentTypeCodeId
	where b.Id = @pShippingOrderId
	or b.ShippingOrderCode = @pShippingOrderCode

Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnShippingOrderAdditionalInfoGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

