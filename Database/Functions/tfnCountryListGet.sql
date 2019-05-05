
--drop function [dbo].[tfnCountryListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnCountryListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCountryListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCountryListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCountryListGet] 
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


print 'Update function [dbo].[tfnCountryListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCountryListGet]
(
	@pSystemLanguageId int
)  
RETURNS @Ret_Table Table
(
	Id int identity(1,1) NOT NULL,
	CountryId int NOT NULL,
	CountryName nvarchar(256) NOT NULL,
	Abbreviation nvarchar(64) NOT NULL,
	Available bit NOT NULL,
	ISOCode nvarchar(64) NOT NULL,
	RegionCode nvarchar(64) NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		CountryId,
		CountryName,
		Abbreviation,
		Available,
		ISOCode,
		RegionCode
	)
	select	a.Id, isnull(z.CountryYName, a.CountryName), a.Abbreviation,
			a.Available, a.ISOCode, a.RegionCode
	from Country a (nolock)
		left join CountryY z (nolock) on a.Id = z.CountryId and z.SystemLanguageId = @pSystemLanguageId and z.Available = 1
	where a.Available = 1
	order by case when a.Abbreviation in ('US', 'CN') then 1 when a.Abbreviation in ('TW', 'HK', 'MO', 'CA') then 2 else 3 end,
	a.CountryName

	--select * from Country
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnCountryListGet](1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

