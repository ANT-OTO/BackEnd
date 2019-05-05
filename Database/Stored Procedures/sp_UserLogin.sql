IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_UserLogin]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_UserLogin] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_UserLogin] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_UserLogin] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_UserLogin] 
	@pEmail nvarchar(256),
	@pPwd nvarchar(512)
AS

SET NOCOUNT ON

	declare @Ret_Table Table
	(
		UserId int,
		CompanyId int,
		CompanyName nvarchar(256),
		isDefault bit,
		RoleId int
	)

	insert into @Ret_Table
	(
		UserId,
		CompanyId,
		CompanyName,
		isDefault,
		RoleId
	)
	select top 1 a.Id, e.Id, e.CompanyName, 0, d.SecRoleId
	from [User] a (nolock)
		inner join CompanyUser b (nolock) on a.Id = b.UserId
		inner join SecRoleCompany c (nolock) on b.CompanyId = c.CompanyId
		inner join SecRoleUser d (nolock) on c.SecRoleId = d.SecRoleId
		inner join Company e (nolock) on b.CompanyId = e.Id
		inner join PhoneNumber f (nolock) on a.PhoneNumberId = f.Id
	where (a.LoginName = @pEmail or f.PhoneNumber = @pEmail or a.Email = @pEmail) 
	and a.Password = @pPwd
	and e.Active = 1


	declare @defaultCompanyId int = 0
	declare @userId int = 0
	select @userId = a.UserId
	from @Ret_Table a

	select top 1 @defaultCompanyId = a.CompanyId
	from UserSession a (nolock)
	where a.UserId = @userId
	order by Id desc

	update a
	set a.isDefault = 1
	from @Ret_Table a
	where a.CompanyId = @defaultCompanyId

	if(not exists(
		select * 
		from @Ret_Table a
		where a.isDefault = 1
	))
	begin
		select @defaultCompanyId = min(a.CompanyId)
		from @Ret_Table a

		update a
		set a.isDefault = 1
		from @Ret_Table a
		where a.CompanyId = @defaultCompanyId
	end

	select * from @Ret_Table




	

return

/*

*/



GO


