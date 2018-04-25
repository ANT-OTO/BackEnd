
--drop function [dbo].[tfnUserCompanyListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnUserCompanyListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnUserCompanyListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnUserCompanyListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnUserCompanyListGet] 
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


print 'Update function [dbo].[tfnUserCompanyListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnUserCompanyListGet]
(
	@pUserId int
)  
RETURNS @Ret_Table Table
(
	[CompanyId] int,
	[CompanyName] nvarchar(256),
	[RoleId] int
)
as
Begin 
	
	insert into @Ret_Table
	(
		[CompanyId],
		[CompanyName],
		[RoleId]
	)
	select c.Id, c.CompanyName, e.SecRoleId
	from [User] a (nolock)
		inner join CompanyUser b (nolock) on a.Id = b.UserId
		inner join Company c (nolock) on b.CompanyId = c.Id
		inner join SecRoleCompany d (nolock) on c.Id = d.CompanyId
		inner join SecRoleUser e (nolock) on d.SecRoleId = e.SecRoleId and a.Id = e.UserId
	where a.Id = @pUserId
	and e.Available = 1
	and b.Available = 1
	and c.Active = 1
	and a.Available = 1
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnUserCompanyListGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

