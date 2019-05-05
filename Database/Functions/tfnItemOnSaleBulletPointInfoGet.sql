
--drop function [dbo].[tfnItemOnSaleBulletPointInfoGet]


/****** Object:  UserDefinedFunction [dbo].[tfnItemOnSaleBulletPointInfoGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnItemOnSaleBulletPointInfoGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnItemOnSaleBulletPointInfoGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnItemOnSaleBulletPointInfoGet] 
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


print 'Update function [dbo].[tfnItemOnSaleBulletPointInfoGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnItemOnSaleBulletPointInfoGet]
(
    @pItemOnSaleId int,
	@pItemId int
)  
RETURNS @Ret_Table Table
(
	[ItemOnSaleId] int NOT NULL,
	[BulletPoint] nvarchar(256) NOT NULL,
	[Order] int NOT NULL,
	[Available] bit NOT NULL
)
as
Begin 
	
	if(isnull(@pItemId, 0) > 0)
	begin
		select @pItemOnSaleId = a.Id 
		from ItemOnSale a (nolock)
		where a.ItemId = @pItemId
		and a.Available = 1
	end
	insert into @Ret_Table
	(
		[ItemOnSaleId],
		[BulletPoint],
		[Order],
		[Available]
	)
	select	a.ItemOnSaleId,
			a.BulletPoint,
			a.[Order],
			a.Available
	from ItemOnSaleDetail a (nolock)
	where a.ItemOnSaleId = @pItemOnSaleId
	and a.Available = 1
	order by a.[Order]
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnItemOnSaleBulletPointInfoGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

