
--drop function [dbo].[tfnShippingOrderIdentityProfileGet]


/****** Object:  UserDefinedFunction [dbo].[tfnShippingOrderIdentityProfileGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnShippingOrderIdentityProfileGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnShippingOrderIdentityProfileGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnShippingOrderIdentityProfileGet] 
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


print 'Update function [dbo].[tfnShippingOrderIdentityProfileGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnShippingOrderIdentityProfileGet]
(
	@pShippingOrderId int,
	@pShippingOrderCode nvarchar(256)
)  
RETURNS @Ret_Table Table
(
	[ShippingOrderId] int NOT NULL,
	[ShippingOrderIdentityProfileId] int NOT NULL,
	[IdentityNumber] nvarchar(256) NOT NULL,
	[Name] nvarchar(256) NOT NULL,
	[PhoneNumber] nvarchar(256) NOT NULL,
	[Available] bit NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[ShippingOrderId],
		[ShippingOrderIdentityProfileId],
		[IdentityNumber],
		[Name],
		[PhoneNumber],
		[Available]
	)
	select	b.Id, a.Id,
			a.IdentityNumber, a.Name, a.PhoneNumber,
			a.Available
	from ShippingOrderIdentityProfile a (nolock)
		inner join ShippingOrder b (nolock) on a.ShippingOrderId = b.Id
	where b.Id = @pShippingOrderId
	or b.ShippingOrderCode = @pShippingOrderCode
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnShippingOrderIdentityProfileGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

