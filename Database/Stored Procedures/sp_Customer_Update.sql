IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Customer_Update]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Customer_Update] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Customer_Update] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Customer_Update] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Customer_Update] 
	@pFirstName nvarchar(256),
	@pLastName nvarchar(256),
	@pPhoneNumber nvarchar(256),
	@pCountryId int,
	@pNickName nvarchar(256),
	@pEmail nvarchar(256),
	@pLoginName nvarchar(256),
	@pPassword nvarchar(256),
	@pDescription nvarchar(256),
	@pAvailable bit,
	@pLastUpdateBy int,
	@pCompanyId int,
	@pCustomerId int output

AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()


	if(exists(
		select * from Customers a (nolock)
			inner join CustomerCompany b (nolock) on a.Id = b.CustomerId
		where b.CompanyId = @pCompanyId
		and a.Id = @pCustomerId
	))
	begin
		
		update a
		set a.FirstName = isnull(@pFirstName, ''),
			a.LastName = isnull(@pLastName, ''),
			a.Email = isnull(@pEmail, ''),
			a.LoginName = isnull(@pLoginName, ''),
			a.NickName = isnull(@pNickName, ''),
			a.Password = case when isnull(@pPassword, '') = '' then a.[Password] else @pPassword end,
			a.PhoneNumber = isnull(@pPhoneNumber, ''),
			a.CountryId = isnull(@pCountryId, 37),
			a.Available = isnull(@pAvailable, 1),
			a.LastUpdate = @pTime,
			a.LastUpdateBy = 1,
			a.LastUpdateByType = 1
		from Customers a (nolock)
		where a.Id = @pCustomerId

		select @pCustomerId = @pCustomerId

		--if(@@ROWCOUNT > 0)
		--begin
			
		--end
		--else
		--begin
		--	select @pCustomerId = 0
		--end
	end
	else
	begin
		select @pCustomerId = 0
	end


return

/*

*/



GO


