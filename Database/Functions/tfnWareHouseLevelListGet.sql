
--drop function [dbo].[tfnWareHouseLevelListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnWareHouseLevelListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnWareHouseLevelListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnWareHouseLevelListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnWareHouseLevelListGet] 
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


print 'Update function [dbo].[tfnWareHouseLevelListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnWareHouseLevelListGet]
(
	@pWarehouseId int
)  
RETURNS @Ret_Table Table
(
	[WareHouseId] int NOT NULL,
	[WareHouseLevelId] int NOT NULL,
	[LevelCode] nvarchar(256) NOT NULL,
	[LevelName] nvarchar(256) NOT NULL,
	[Available] bit NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[WareHouseId],
		[WareHouseLevelId],
		[LevelCode],
		[LevelName],
		[Available]
	)
	select	a.Id, b.Id, b.LevelCode, b.LevelName, b.Available
	from WareHouse a (nolock)
		inner join WarehouseLevel b (nolock) on a.Id = b.WareHouseId
	where b.WareHouseId = @pWarehouseId
	and b.Available = 1
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnWareHouseLevelListGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

