
--drop function [dbo].[tfnShippingOrderLabelNeedGenerate]


/****** Object:  UserDefinedFunction [dbo].[tfnShippingOrderLabelNeedGenerate]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnShippingOrderLabelNeedGenerate]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnShippingOrderLabelNeedGenerate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnShippingOrderLabelNeedGenerate] 
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


print 'Update function [dbo].[tfnShippingOrderLabelNeedGenerate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnShippingOrderLabelNeedGenerate]
(
	
)  
RETURNS @Ret_Table Table
(
	ShippingOrderId int
)
as
Begin 
	
	insert into @Ret_Table
	(
		ShippingOrderId
	)
	select a.Id
	from ShippingOrder a 
		left join ShippingOrderLabel z on a.Id = z.ShippingOrderId
	where z.Id is null
	and datediff(second, a.CreateDate, getutcdate()) > 20
	and a.Id > 596
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnShippingOrderLabelNeedGenerate](1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

