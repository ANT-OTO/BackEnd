IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Agent_AutoLogout]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Agent_AutoLogout] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Agent_AutoLogout] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Agent_AutoLogout] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Agent_AutoLogout] 
	@pAgentId int
AS

SET NOCOUNT ON

declare @Time datetime = getutcdate()

update a
set a.Expired = 1, a.LastUpdate = @Time
from AgentSession a where a.AgentId = @pAgentId and a.Expired = 0 and a.Id < (
select max(Id) as Id from AgentSession a (nolock) where a.AgentId = @pAgentId and Expired = 0)

return

/*

*/



GO


