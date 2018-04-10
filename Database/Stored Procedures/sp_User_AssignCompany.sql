IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_User_AssignCompany]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_User_AssignCompany] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_User_AssignCompany] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_User_AssignCompany] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_User_AssignCompany] 
	@pUserId int,
	@pRoleId int,
	@pCompanyId int,
	@pError nvarchar(256) output,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON

	declare @pTime datetime = getutcdate()
	
    
	if(@pUserId > 0)
	begin
		if(not exists(
			select * from SecRole a (nolock)
				inner join SecRoleCompany b (nolock) on a.Id = b.CompanyId
			where a.Id = @pRoleId
			and b.CompanyId = @pCompanyId
			and b.Available = 1
			and a.Available = 1
		))
		begin
			select @pError = 'Role not exists in selected company.'
			return
		end
		if(exists(
			select * from [User] a (nolock)
				inner join CompanyUser b (nolock) on a.Id = b.UserId
			where a.Available = 1
			and b.Available = 1
			and b.CompanyId = @pCompanyId
			and a.Id = @pUserId
		))
		begin
			select @pError = 'User already exists in this company'
			return
		end

		insert into CompanyUser
		(
			[CompanyId],
			[UserId],
			[Available],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select a.CompanyId, a.UserId, a.Available, a.CreateDate, a.LastUpdate, a.LastUpdateBy, a.LastUpdateByType
		from
		( 
			select	@pCompanyId as [CompanyId],
					@pUserId as [UserId],
					1 as [Available],
					1 as [CreateDate],
					@pTime as [LastUpdate],
					@pLastUpdateBy as [LastUpdateBy],
					@pLastUpdateByType as [LastUpdateByType]
		) a
		left join CompanyUser z (nolock) on a.CompanyId = z.CompanyId and a.UserId = z.UserId
		where z.Id is null

		update a
		set a.Available = 1,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = @pLastUpdateBy,
			a.LastUpdateByType = @pLastUpdateByType
		from CompanyUser a
		where a.CompanyId = @pCompanyId
		and a.UserId = @pUserId

		insert into SecRoleUser
		(
			[SecRoleId],
			[UserId],
			[Available],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select a.SecRoleId, a.UserId, a.Available, a.CreateDate, a.LastUpdate, a.LastUpdateBy, a.LastUpdateByType
		from 
		(
			select	@pRoleId as [SecRoleId],
					@pUserId as [UserId],
					1 as [Available],
					@pTime as [CreateDate],
					@pTime as [LastUpdate],
					@pLastUpdateBy as [LastUpdateBy],
					@pLastUpdateByType [LastUpdateByType]
		) a
		left join SecRoleUser z (nolock) on a.SecRoleId = z.SecRoleId and a.UserId = z.UserId
		where z.Id is null

		update a
		set a.Available = 1,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = @pLastUpdateBy,
			a.LastUpdateByType = @pLastUpdateByType
		from SecRoleUser a
		where a.SecRoleId = @pRoleId 
		and a.UserId = @pUserId
	end

	

return

/*

*/



GO


