
--drop function [dbo].[tfnShippingOrderLabelNeedHtmlConvertPdf]


/****** Object:  UserDefinedFunction [dbo].[tfnShippingOrderLabelNeedHtmlConvertPdf]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnShippingOrderLabelNeedHtmlConvertPdf]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnShippingOrderLabelNeedHtmlConvertPdf] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnShippingOrderLabelNeedHtmlConvertPdf] 
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


print 'Update function [dbo].[tfnShippingOrderLabelNeedHtmlConvertPdf] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnShippingOrderLabelNeedHtmlConvertPdf]
(
	
)  
RETURNS @Ret_Table Table
(
	ShippingOrderLabelId int,
	FileId int
)
as
Begin 
	
	insert into @Ret_Table
	(
		ShippingOrderLabelId,
		FileId
	)
	select top 50 a.Id, a.FileId
	from ShippingOrderLabel a (nolock)
		inner join [File] b (nolock) on a.FileId = b.Id
		left join ShippingOrderLabelPdfFile z (nolock) on a.Id = z.ShippingOrderLabelId
	where a.LabelName = 'ANTOTOLabel'
		and a.Available = 1
		and b.FileExt = 'html'
		and z.Id is null
	order by a.Id desc
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnShippingOrderLabelNeedHtmlConvertPdf](1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

