IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_UserSession_Validate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_UserSession_Validate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_UserSession_Validate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_UserSession_Validate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_UserSession_Validate] 
	@pToken nvarchar(256) 
AS

SET NOCOUNT ON

	declare @pTime datetime = getutcdate()
	


	select	a.Id as UserId,
			b.SystemLanguageId as SystemLanguageId,
			b.CompanyId as CompanyId
	from [User] a (nolock)
		inner join UserSession b (nolock) on a.Id = b.UserId
	where b.Token = @pToken
	and a.Available = 1
	and b.Expired = 0
	and DATEADD(second, b.ExpireSeconds, b.LastUpdate) > @pTime 




	

return

/*

*/



GO


