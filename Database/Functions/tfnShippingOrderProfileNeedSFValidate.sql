
--drop function [dbo].[tfnShippingOrderProfileNeedSFValidate]


/****** Object:  UserDefinedFunction [dbo].[tfnShippingOrderProfileNeedSFValidate]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnShippingOrderProfileNeedSFValidate]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnShippingOrderProfileNeedSFValidate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnShippingOrderProfileNeedSFValidate] 
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


print 'Update function [dbo].[tfnShippingOrderProfileNeedSFValidate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnShippingOrderProfileNeedSFValidate]
(
	
)  
RETURNS @Ret_Table Table
(
	Id int identity(1, 1),
	ShippingOrderId int
)
as
Begin 
	
	insert into @Ret_Table
	(
		ShippingOrderId
	)
	select a.Id
	from ShippingOrder a (nolock)
		inner join ShippingOrderIdentityProfile b (nolock) on a.Id = b.ShippingOrderId
		left join [ShippingOrderIdentityProfileSFValidate] z (nolock) on b.Id = z.ShippingOrderIdentityProfileId
	where z.Id is null or z.[SFValidate] = 0
	order by a.Id desc
	--and a.ShippingOrderStatusCodeId in (1, 2, 3, 4, 5, 6) --select * from CodeList where Category = 'ShippingOrderStatus'
	--select * from Country
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnShippingOrderProfileNeedSFValidate](1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

