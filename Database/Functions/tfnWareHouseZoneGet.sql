
--drop function [dbo].[tfnWareHouseZoneGet]


/****** Object:  UserDefinedFunction [dbo].[tfnWareHouseZoneGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnWareHouseZoneGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnWareHouseZoneGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnWareHouseZoneGet] 
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


print 'Update function [dbo].[tfnWareHouseZoneGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnWareHouseZoneGet]
(
	@pWarehouseZoneId int
)  
RETURNS @Ret_Table Table
(
	[WareHouseLevelId] int NOT NULL,
	[WareHouseZoneId] int NOT NULL,
	[ZoneCode] nvarchar(256) NOT NULL,
	[ZoneName] nvarchar(256) NOT NULL,
	[Available] bit NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[WareHouseLevelId],
		[WareHouseZoneId],
		[ZoneCode],
		[ZoneName],
		[Available]
	)
	select	b.Id, a.Id, a.ZoneCode, a.ZoneName, a.Available 
	from WareHouseZone a (nolock)
		inner join WarehouseLevel b (nolock) on a.WareHouseLevelId = b.Id
	where a.Id = @pWarehouseZoneId
	and b.Available = 1
	and a.Available = 1
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnWareHouseZoneGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

