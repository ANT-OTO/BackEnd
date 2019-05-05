IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_RoleFunctionUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_RoleFunctionUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_RoleFunctionUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_RoleFunctionUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_RoleFunctionUpdate] 
	@pSecRoleId int,
	@pSecFunctionId int,
	@pGranted bit,
	@pActionForSubRole bit,
	@pActionForSubFunction bit,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON

	declare @pTime datetime = getutcdate()
	if(@pGranted = 0)
	begin
		select @pActionForSubFunction = 1
		select @pActionForSubRole = 1
	end
    declare @pFunctionTable Table
	(
		[SecFunctionKey] nvarchar(256)
	)
	CREATE TABLE #FunctionTable
	(
		[SecFunctionKey] nvarchar(256),
		[ParentSecFunctionKey] nvarchar(256)
	)

	;with #FunctionTable ([SecFunctionKey], [ParentSecFunctionKey])as
	(
	  SELECT a.FunctionKey, a.ParentFunctionKey
	  FROM SecFunction a (nolock)
	  WHERE a.Id = @pSecFunctionId
	  UNION ALL

	  SELECT b.FunctionKey, b.ParentFunctionKey
	  FROM SecFunction b (nolock)
	  INNER JOIN #FunctionTable c
	  ON c.SecFunctionKey = b.ParentFunctionKey
	  where @pActionForSubFunction = 1
	 )
	insert into @pFunctionTable
	(
		[SecFunctionKey]
	)
	select a.SecFunctionKey from #FunctionTable a

	declare @pRoleTable Table
	(
		[SecRoleId] int
	)
	CREATE TABLE #RoleTable
	(
		[SecRoleId] int,
		[ParentRoleId] int
	)

	;with #RoleTable ([SecRoleId], [ParentRoleId])as
	(
	  SELECT a.Id, a.ParentRoleId
	  FROM SecRole a (nolock)
	  WHERE a.Id = @pSecRoleId

	  UNION ALL

	  SELECT b.Id, b.ParentRoleId
	  FROM SecRole b (nolock)
	  INNER JOIN #RoleTable c
	  ON c.SecRoleId = b.ParentRoleId
	  where @pActionForSubRole = 1
	)
	insert into @pRoleTable
	(SecRoleId)
	select a.SecRoleId
	from #RoleTable a

	insert into [SecRoleFunction]
	(
		[SecRoleId],
		[SecFunctionId],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	a.SecRoleId,
			c.Id,
			@pGranted,
			@pTime,
			@pTime,
			@pLastUpdateBy,
			@pLastUpdateByType
	from @pRoleTable a
		cross join @pFunctionTable b
		inner join SecFunction c (nolock) on b.SecFunctionKey = c.FunctionKey
		left join SecRoleFunction z (nolock) on a.SecRoleId = z.SecRoleId and c.Id = z.SecFunctionId
	where z.Id is null 
	

	update a
	set a.Available = @pGranted,
		a.LastUpdate = @pTime,
		a.LastUpdateBy = @pLastUpdateBy,
		a.LastUpdateByType = @pLastUpdateByType
	from SecRoleFunction a 
		inner join @pRoleTable b on a.SecRoleId = b.SecRoleId
		inner join SecFunction c (nolock) on a.SecFunctionId = c.Id
		inner join @pFunctionTable d on c.FunctionKey = d.SecFunctionKey


	

return

/*

*/



GO


