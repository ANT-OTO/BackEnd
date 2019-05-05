
--drop function [dbo].[tfnItemVariationInfoGet]


/****** Object:  UserDefinedFunction [dbo].[tfnItemVariationInfoGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnItemVariationInfoGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnItemVariationInfoGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnItemVariationInfoGet] 
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


print 'Update function [dbo].[tfnItemVariationInfoGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnItemVariationInfoGet]
(
    @pItemId int,
	@pWizardSessionId int
)  
RETURNS @Ret_Table Table
(
	[VariationTitle] nvarchar(256),
	[VariationReasonCodeId] int
)
as
Begin 
	if(isnull(@pItemId, 0) = 0)
	begin
		select @pItemId = b.Id
		from WizardSession a (nolock)
			inner join Item b (nolock) on a.SourceId = b.Id and a.SourceTable = 'Item'
		where a.Id = @pWizardSessionId
	end
	insert into @Ret_Table
	(
		[VariationTitle],
		[VariationReasonCodeId]
	)
	select	isnull(v.PropertyValue, '') as VariationTitle,
			convert(int, isnull(v1.PropertyValue, '0')) as VariationReasonCodeId
	from Item a (nolock) 
		left join ItemProperty v (nolock) on v.ItemId = a.Id and v.PropertyName = 'VariationTitle'
		left join ItemProperty v1 (nolock) on v1.ItemId = a.Id and v1.PropertyName = 'VariationReasonCodeId'
	where a.Id = @pItemId
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnItemVariationInfoGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

