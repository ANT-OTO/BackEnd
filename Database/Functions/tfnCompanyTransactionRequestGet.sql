
--drop function [dbo].[tfnCompanyTransactionRequestGet]


/****** Object:  UserDefinedFunction [dbo].[tfnCompanyTransactionRequestGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCompanyTransactionRequestGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCompanyTransactionRequestGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCompanyTransactionRequestGet] 
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


print 'Update function [dbo].[tfnCompanyTransactionRequestGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCompanyTransactionRequestGet]
(
	@pCompanyTransactionRequestId int
)  
RETURNS @Ret_Table Table
(
	CompanyTransactionRequestId int,
	Amount decimal(10, 2),
	CurrencyId int,
	Currency nvarchar(256),
	SourceCompanyId int,
	SourceCompanyName nvarchar(256),
	HandlerCompanyId int,
	HandlerCompanyName nvarchar(256),
	CompanyTransactionRequestStatusCodeId int,
	CompanyTransactionRequestStatus nvarchar(256),
	UserId int,
	UserName nvarchar(256)
)
as
Begin 
	
	

	insert into @Ret_Table
	(
		CompanyTransactionRequestId,
		Amount,
		CurrencyId,
		Currency,
		SourceCompanyId,
		SourceCompanyName,
		HandlerCompanyId,
		HandlerCompanyName,
		CompanyTransactionRequestStatusCodeId,
		CompanyTransactionRequestStatus,
		UserId,
		UserName
	)
	select	a.Id, a.Amount, a.CurrencyId, b.EnglishName, c.Id, c.CompanyName,
			isnull(z.Id, 0), isnull(z.CompanyName, N'总公司'),
			a.CompanyTransactionRequestStatusCodeId, d.CodeShort,
			isnull(y.Id, 0), isnull(y.FirstName, '') + ' ' + isnull(y.LastName, '')
	from CompanyTransactionRequest a (nolock)
		inner join Currency b (nolock) on a.CurrencyId = b.Id
		inner join Company c (nolock) on a.SourceCompanyId = c.Id
		left join Company z (nolock) on a.TargetCompanyId = z.Id
		inner join CodeList d (nolock) on a.CompanyTransactionRequestStatusCodeId = d.CodeId and d.Category = 'CompanyTransactionRequestStatus'
		left join [User] y (nolock) on a.UserId = y.Id
	where a.Id = @pCompanyTransactionRequestId
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnCompanyTransactionRequestGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

