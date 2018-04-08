
--drop function [dbo].[tfnCompanyRoleListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnCompanyRoleListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCompanyRoleListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCompanyRoleListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCompanyRoleListGet] 
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


print 'Update function [dbo].[tfnCompanyRoleListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCompanyRoleListGet]
(
    @pCompanyId int,
	@pUserId int
)  
RETURNS @Ret_Table Table
(
	[SecRoleId] int NOT NULL,
	[ParentRoleId] int NOT NULL,
	[CompanyId] int NOT NULL,
	[RoleName] nvarchar(256) NOT NULL,
	[Changable] bit NOT NULL,
	[Available] bit NOT NULL
)
as
Begin 
	
	declare @UserRoleId int = 0
	select @UserRoleId = a.SecRoleId
	from SecRoleUser a (nolock)
		inner join SecRoleCompany b (nolock) on a.SecRoleId = b.SecRoleId
	where a.UserId = @pUserId
	and b.CompanyId = @pCompanyId

	declare @pRoleTable Table
	(
		[SecRoleId] int
	)

	;with PagedQuery as
	(
	  SELECT a.Id, a.ParentRoleId
	  FROM SecRole a (nolock)
	  WHERE a.ParentRoleId = 0 or a.ParentRoleId is null
	  and a.Id = @UserRoleId

	  UNION ALL

	  SELECT b.Id, b.ParentRoleId
	  FROM SecRole b (nolock)
	  INNER JOIN PagedQuery c
	  ON c.Id = b.ParentRoleId
	)
	insert into @pRoleTable
	(SecRoleId)
	select a.Id
	from PagedQuery a

	insert into @Ret_Table
	(
		[SecRoleId],
		[ParentRoleId],
		[CompanyId],
		[RoleName],
		[Changable],
		[Available]
	)
	select b.Id, b.ParentRoleId, a.CompanyId, b.RoleName, case when z.SecRoleId is null then 0 else 1 end, b.Available
	from SecRoleCompany a (nolock)
		inner join SecRole b (nolock) on a.SecRoleId = b.Id
		left join @pRoleTable z on b.Id = z.SecRoleId
	where a.CompanyId = @pCompanyId
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnCompanyRoleListGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

