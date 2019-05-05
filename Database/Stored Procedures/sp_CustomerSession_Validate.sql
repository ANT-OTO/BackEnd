IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CustomerSession_Validate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CustomerSession_Validate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CustomerSession_Validate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CustomerSession_Validate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CustomerSession_Validate] 
	@pToken nvarchar(256) 
AS

SET NOCOUNT ON

	declare @pTime datetime = getutcdate()
	


	select	a.Id as CustomerId,
			b.SystemLanguageId as SystemLanguageId,
			b.CompanyId as CompanyId
	from Customers a (nolock)
		inner join CustomerSession b (nolock) on a.Id = b.CustomerId
	where b.Token = @pToken
	and a.Available = 1
	and b.Expired = 0
	--and DATEADD(second, b.ExpireSeconds, b.LastUpdate) > @pTime 




	

return

/*

*/



GO


