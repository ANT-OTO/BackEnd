
--drop function [dbo].[tfnWareHouseGet]


/****** Object:  UserDefinedFunction [dbo].[tfnWareHouseGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnWareHouseGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnWareHouseGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnWareHouseGet] 
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


print 'Update function [dbo].[tfnWareHouseGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnWareHouseGet]
(
	@pWareHouseId int
)  
RETURNS @Ret_Table Table
(
	[WareHouseId] int NOT NULL,
	[CompanyId] int NOT NULL,
	[AddressId] int NOT NULL,
	[Address1] [nvarchar](256) NOT NULL,
	[Address2] [nvarchar](256) NOT NULL,
	[City] [nvarchar](128) NOT NULL,
	[District] [nvarchar](128) NULL,
	[State] [nvarchar](128) NOT NULL,
	[Zip] [nvarchar](32) NOT NULL,
	[CountryId] [int] NOT NULL,
	[ManagerName] nvarchar(256) NOT NULL,
	[ContactNumber] nvarchar(256) NOT NULL,
	[ContactNumberCountryId] int NOT NULL,
	[WareHouse_Code] nvarchar(256) NOT NULL,
	[WareHouse_Name] nvarchar(256) NOT NULL,
	[Available] bit NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[WareHouseId],
		[CompanyId],
		[AddressId],
		[Address1],
		[Address2],
		[City],
		[District],
		[State],
		[Zip],
		[CountryId],
		[ManagerName],
		[ContactNumber],
		[ContactNumberCountryId],
		[WareHouse_Code],
		[WareHouse_Name],
		[Available]
	)
	select	a.Id, a.CompanyId, a.AddressId, b.Address1, b.Address2,
			b.City, b.District, b.[State], b.Zip, b.CountryId,
			a.ManagerName, a.ContactNumber, a.ContactNumberCountryId,
			a.WareHouse_Code, a.WareHouse_Name, a.Available
	from WareHouse a (nolock)
		inner join [Address] b (nolock) on a.AddressId = b.Id
	where a.Id = @pWareHouseId
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnWareHouseGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

