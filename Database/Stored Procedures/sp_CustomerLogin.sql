IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CustomerLogin]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CustomerLogin] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CustomerLogin] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CustomerLogin] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CustomerLogin] 
	@pLoginName nvarchar(256),
	@pPassword nvarchar(256),
	@pWechatUId nvarchar(256),
	@pAlibabaUId nvarchar(256),
	@pNickName nvarchar(256),
	@pSystemLanguageId int,
	@pExpiredSeconds int,
	@pCompanyCode nvarchar(256),
	@pCustomerSessionId int output,
	@pToken nvarchar(256) output
AS

SET NOCOUNT ON
	
	select @pToken = ''
	declare @pTime datetime = getutcdate()
	declare @pCustomerId int = 0
	if(len(isnull(@pLoginName, ''))> 0)
	begin
		select @pCustomerId = a.Id
		from Customers a (nolock)
		where a.Available = 1
		and a.LoginName = @pLoginName
		and a.Password = @pPassword
	end

	if(len(isnull(@pWechatUId, '')) > 0)
	begin
		select @pCustomerId = a.Id
		from Customers a (nolock)
			inner join CustomerThirdParty b (nolock) on a.Id = b.CustomerId
		where b.UnifiedId = @pWechatUId
		and b.CustomerTypeCodeId = 2
	end

	if(len(isnull(@pAlibabaUId, '')) > 0)
	begin
		select @pCustomerId = a.Id
		from Customers a (nolock)
			inner join CustomerThirdParty b (nolock) on a.Id = b.CustomerId
		where b.UnifiedId = @pAlibabaUId
		and b.CustomerTypeCodeId = 1
	end
	declare @pCompanyId int = 0
	select @pCompanyId = a.CompanyId
	from CustomerCompany a (nolock)
	where a.CustomerId = @pCustomerId
	and a.Available = 1

	select @pCompanyId = a.CompanyId
	from CustomerSession a (nolock)
	where a.Id in (
		select max(a.Id)
		from CustomerSession a (nolock)
		where a.CustomerId = @pCustomerId
	)

	if(isnull(@pCompanyCode, '') <> '')
	begin
		select @pCompanyId = a.Id
		from Company a (nolock)
		where a.CompanyCode = @pCompanyCode
	end
	

	if(@pCompanyId > 0 and @pCustomerId > 0)
	begin
		update a
		set a.Expired = 1,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = 1,
			a.LastUpdateByType = 1
		from CustomerSession a 
		where a.CustomerId = @pCustomerId
		and a.Expired = 0

		select @pToken = replace(NEWID(), '-', '')

		insert into CustomerSession
		(
			[CustomerId],
			[Token],
			[SystemLanguageId],
			[Expired],
			[ExpireSeconds],
			[CompanyId],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	@pCustomerId, @pToken, @pSystemLanguageId, 0, @pExpiredSeconds,@pCompanyId,
				@pTime, @pTime, 1, 1

		if(@@ROWCOUNT > 0)
		BEGIN
			select @pCustomerSessionId = SCOPE_IDENTITY()
		END
		else
		begin
			select @pCustomerSessionId = 0
			select @pToken = ''
		end
	end

	


return

/*

*/



GO


