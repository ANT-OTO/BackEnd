
--drop function [dbo].[tfnWareHouseRackLevelGet]


/****** Object:  UserDefinedFunction [dbo].[tfnWareHouseRackLevelGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnWareHouseRackLevelGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnWareHouseRackLevelGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnWareHouseRackLevelGet] 
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


print 'Update function [dbo].[tfnWareHouseRackLevelGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnWareHouseRackLevelGet]
(
	@pWareHouseRackLevelId int
)  
RETURNS @Ret_Table Table
(
	[WareHouseRackId] int NOT NULL,
	[WareHouseRackLevelId] int NOT NULL,
	[RackLevelCode] nvarchar(256) NOT NULL,
	[RackLevelName] nvarchar(256) NOT NULL,
	[Available] bit NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[WareHouseRackId],
		[WareHouseRackLevelId],
		[RackLevelCode],
		[RackLevelName],
		[Available]
	)
	select a.Id, b.Id, b.RackLevelCode, b.RackLevelName, b.Available
	from WarehouseRack a (nolock)
		inner join WarehouseRackLevel b (nolock) on a.Id = b.WarehouseRackId
	where b.Id = @pWareHouseRackLevelId
	and a.Available = 1
	and b.Available = 1
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnWareHouseRackLevelGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

