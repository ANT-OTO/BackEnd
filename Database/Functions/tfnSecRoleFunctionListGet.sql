
--drop function [dbo].[tfnSecRoleFunctionListGet]


/****** Object:  UserDefinedFunction [dbo].[tfnSecRoleFunctionListGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnSecRoleFunctionListGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnSecRoleFunctionListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnSecRoleFunctionListGet] 
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


print 'Update function [dbo].[tfnSecRoleFunctionListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnSecRoleFunctionListGet]
(
    @pSecRoleId int,
	@pUserId int
)  
RETURNS @Ret_Table Table
(
	[SecFunctionId] int NOT NULL,
	[FunctionKey] nvarchar(256) NOT NULL,
	[FunctionName] nvarchar(256) NOT NULL,
	[ParentFunctionKey] nvarchar(256) NOT NULL,
	[ParentSecFunctionId] int NOT NULL,
	[Available] bit NOT NULL,
	[Granted] bit NOT NULL
)
as
Begin 
	
	declare @UserRoleId int = 0
	select @UserRoleId = a.SecRoleId
	from SecRoleUser a (nolock)
		inner join SecRole b (nolock) on a.SecRoleId = b.Id
	where a.UserId = @pUserId

	declare @CompanyId int = 0
	select @CompanyId = a.CompanyId
	from SecRoleCompany a (nolock)
	where a.SecRoleId = @pSecRoleId

	declare @ParentRoleId int = 0
	select @ParentRoleId = a.ParentRoleId
	from SecRole a (nolock)
	where a.Id = @pSecRoleId

	if(@ParentRoleId = 0)
	begin
		insert into @Ret_Table
		(
			[SecFunctionId],
			[FunctionKey],
			[FunctionName],
			[ParentFunctionKey],
			[ParentSecFunctionId],
			[Available],
			[Granted]
		)
		select b.Id, b.FunctionKey, b.FunctionName, b.ParentFunctionKey, isnull(z.Id, 0), b.Id, 
				case when y.Id is null then 0 else 1 end
		from SecFunctionCompany a (nolock)
			inner join SecFunction b (nolock) on a.SecFunctionId = b.Id
			left join SecFunction z (nolock) on b.ParentFunctionKey = z.FunctionKey
			left join SecRoleFunction y (nolock) on b.Id = y.SecFunctionId and y.SecRoleId = @pSecRoleId and y.Available = 1
		where a.CompanyId = @CompanyId
		and a.Available = 1
		and b.Available = 1
	end
	else
	begin
		insert into @Ret_Table
		(
			[SecFunctionId],
			[FunctionKey],
			[FunctionName],
			[ParentFunctionKey],
			[ParentSecFunctionId],
			[Available],
			[Granted]
		)
		select b.Id, b.FunctionKey, b.FunctionName, b.ParentFunctionKey, isnull(z.Id, 0), b.Id, 
				case when y.Id is null then 0 else 1 end
		from SecRoleFunction a (nolock)
			inner join SecFunction b (nolock) on a.SecFunctionId = b.Id
			left join SecFunction z (nolock) on b.ParentFunctionKey = z.FunctionKey
			left join SecRoleFunction y (nolock) on b.Id = y.SecFunctionId and y.SecRoleId = @pSecRoleId and y.Available = 1
		where a.SecRoleId = @ParentRoleId
		and a.Available = 1
		and b.Available = 1
	end
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnSecRoleFunctionListGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

