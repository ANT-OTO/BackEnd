IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Role_Update]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Role_Update] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Role_Update] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Role_Update] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Role_Update] 
	@pSecRoleId int output,
	@pRoleName nvarchar(128),
	@pParentRoleId int,
	@pSystemRole bit,
	@pAvailable bit,
	@pCompanyId int,
	@pCopeFromRoleId int,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON

declare @pTime datetime = getutcdate()
declare @pSecRoleCompanyId int = 0
select @pSecRoleId = 0
if(@pSecRoleCompanyId is null or @pSecRoleCompanyId = 0)
begin
	insert into ANTOTO.[dbo].[SecRole]
	(
		[RoleName],
		[ParentRoleId],
		[SystemRole],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	@pRoleName,
			@pParentRoleId,
			@pSystemRole,
			@pAvailable,
			@pTime,
			@pTime,
			@pLastUpdateBy,
			@pLastUpdateByType

	if(@@ROWCOUNT > 0)
	begin
		select @pSecRoleId = SCOPE_IDENTITY()
		insert into [dbo].[SecRoleCompany]
		(
			[SecRoleId],
			[CompanyId],
			[Available],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	@pSecRoleId,
				@pCompanyId,
				@pAvailable,
				@pTime,
				@pTime,
				@pLastUpdateBy,
				@pLastUpdateByType

		if(@@ROWCOUNT > 0)
		begin
			select @pSecRoleCompanyId = SCOPE_IDENTITY()
		end

		-- Copy
		if(@pCopeFromRoleId = 0)
		begin
			-- default function
			if(@pParentRoleId > 0)
			begin
				insert into [dbo].[SecRoleFunction]
				(
					[SecRoleId],
					[SecFunctionId],
					[Available],
					[CreateDate],
					[LastUpdate],
					[LastUpdateBy],
					[LastUpdateByType]
				)
				select	@pSecRoleId,
						a.SecFunctionId,
						a.Available,
						@pTime,
						@pTime,
						@pLastUpdateBy,
						@pLastUpdateByType
				from dbo.SecRoleFunction a (nolock)
				where a.SecRoleId = @pParentRoleId
				and a.Available = 1
			end
			else
			begin
				insert into [dbo].[SecRoleFunction]
				(
					[SecRoleId],
					[SecFunctionId],
					[Available],
					[CreateDate],
					[LastUpdate],
					[LastUpdateBy],
					[LastUpdateByType]
				)
				select	@pSecRoleId,
						a.SecFunctionId,
						a.Available,
						@pTime,
						@pTime,
						@pLastUpdateBy,
						@pLastUpdateByType
				from dbo.SecFunctionCompany a (nolock)
				where a.Available = 1
				and a.CompanyId = @pCompanyId
			end
		end
		else
		begin
				insert into [dbo].[SecRoleFunction]
				(
					[SecRoleId],
					[SecFunctionId],
					[Available],
					[CreateDate],
					[LastUpdate],
					[LastUpdateBy],
					[LastUpdateByType]
				)
				select	@pSecRoleId,
						a.SecFunctionId,
						a.Available,
						@pTime,
						@pTime,
						@pLastUpdateBy,
						@pLastUpdateByType
				from dbo.SecRoleFunction a (nolock)
				where a.SecRoleId = @pCopeFromRoleId
				and a.Available = 1
		end
	end
end
else
begin
	update a
	set a.Available = @pAvailable,
		a.RoleName = @pRoleName
	from ANTOTO.[dbo].[SecRole] a
	where a.Id = @pSecRoleId

	select @pSecRoleId = @pSecRoleId
end


return

/*

*/



GO


