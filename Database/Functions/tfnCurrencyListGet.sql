
--drop function [dbo].[tfnCurrencyListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnCurrencyListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCurrencyListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCurrencyListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCurrencyListGet] 
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


print 'Update function [dbo].[tfnCurrencyListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCurrencyListGet]
(
	@pSystemLanguageId int
)  
RETURNS @Ret_Table Table
(
	Id int identity(1,1) NOT NULL,
	CurrencyId int NOT NULL,
	CurrencyCode nvarchar(10) NOT NULL,
	CurrencyName nvarchar(64) NOT NULL,
	CurrencySymbol nvarchar(8) NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		CurrencyId ,
		CurrencyCode,
		CurrencyName,
		CurrencySymbol
	)
	select a.Id, a.Code, isnull(z.Name, a.EnglishName), a.Symbol
	from Currency (nolock) a
		left join CurrencyY z (nolock) on a.Id = z.CurrencyId and z.SystemLanguageId = @pSystemLanguageId
	order by case when a.Code = 'USD' then 0 else 1 end, a.Code
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnCurrencyListGet](1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

