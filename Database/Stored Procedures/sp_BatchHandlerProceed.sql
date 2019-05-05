IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_BatchHandlerProceed]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_BatchHandlerProceed] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_BatchHandlerProceed] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_BatchHandlerProceed] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_BatchHandlerProceed] 
	@pBatchHandlerId int output,
	@pUserId int,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	update a
	set a.BatchStatusCodeId = 2, --select * from CodeList where Category = 'BatchStatus'
		a.LastUpdate = @pTime,
		a.LastUpdateBy = @pLastUpdateBy,
		a.LastUpdateByType = @pLastUpdateByType
	from BatchHandler a
	where a.Id = @pBatchHandlerId
	

	


return

/*

*/



GO


