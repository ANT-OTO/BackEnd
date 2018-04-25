IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_UserSession_Create]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_UserSession_Create] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_UserSession_Create] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_UserSession_Create] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_UserSession_Create] 
	@pUserId int,
	@pExpiredSeconds int,
	@pSystemLanguageId int,
	@pCompanyId int,
	@pLastUpdateBy int,
	@pLastUpdateByType int,
	@pUserSessionId int output,
	@pToken nvarchar(256) output

AS

SET NOCOUNT ON

	declare @pTime datetime = getutcdate()
	
	update a
	set a.Expired = 1,
		a.LastUpdate = @pTime,
		a.LastUpdateBy = @pLastUpdateBy,
		a.LastUpdateByType = @pLastUpdateByType
	from UserSession a 
	where a.UserId = @pUserId
	and a.Expired = 0

	select @pToken = replace(NEWID(), '-', '')

	insert into UserSession
	(
		[UserId],
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
	select	@pUserId, @pToken, @pSystemLanguageId, 0, @pExpiredSeconds,@pCompanyId,
			@pTime, @pTime, @pLastUpdateBy, @pLastUpdateByType

	if(@@ROWCOUNT > 0)
	BEGIN
		select @pUserSessionId = SCOPE_IDENTITY()
	END
	else
	begin
		select @pUserSessionId = 0
		select @pToken = ''
	end

	

return

/*

*/



GO


