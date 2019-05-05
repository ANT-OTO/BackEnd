IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ErrorLog_Insert]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ErrorLog_Insert] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ErrorLog_Insert] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ErrorLog_Insert] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ErrorLog_Insert] 
	@pValue nvarchar(max),
	@pType nvarchar(64)
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	insert into ErrorLog
	(
		Type,
		Detail,
		CreateDate
	)
	select @pType, @pValue, @pTime

	


return

/*

*/



GO


