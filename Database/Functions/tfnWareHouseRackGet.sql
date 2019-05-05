
--drop function [dbo].[tfnWareHouseRackGet]


/****** Object:  UserDefinedFunction [dbo].[tfnWareHouseRackGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnWareHouseRackGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnWareHouseRackGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnWareHouseRackGet] 
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


print 'Update function [dbo].[tfnWareHouseRackGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnWareHouseRackGet]
(
	@pWareHouseRackId int
)  
RETURNS @Ret_Table Table
(
	[WareHouseZoneId] int NOT NULL,
	[WareHouseRackId] int NOT NULL,
	[RackCode] nvarchar(256) NOT NULL,
	[RackName] nvarchar(256) NOT NULL,
	[Available] bit NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[WareHouseZoneId],
		[WareHouseRackId],
		[RackCode],
		[RackName],
		[Available]
	)
	select b.Id, a.Id, a.RackCode, a.RackName, a.Available
	from WarehouseRack a (nolock)
		inner join WarehouseZone b (nolock) on a.WareHouseZoneId = b.Id
	where a.Id = @pWareHouseRackId
	and a.Available = 1
	and b.Available = 1
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnWareHouseRackGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

