IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_BatchHandlerRecordInsert]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_BatchHandlerRecordInsert] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_BatchHandlerRecordInsert] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_BatchHandlerRecordInsert] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_BatchHandlerRecordInsert] 
	@pBatchHandlerId int,
	@pBatchHandlerRecordId int output,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	insert into [dbo].[BatchHandlerRecord]
	(
		[BatchHandlerId],
		[RecordNumber],
		[BatchHandlerRecordStatusCodeId], --select * from CodeList where Category = 'BatchHandlerRecordStatus'
		Reason,
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select @pBatchHandlerId, '', 1, '', @pTime, @pTime, @pLastUpdateBy, @pLastUpdateByType

	select @pBatchHandlerRecordId = SCOPE_IDENTITY()

	update a
	set a.RecordNumber = convert(nvarchar(256), a.Id)
	from BatchHandlerRecord a 
	where a.Id = @pBatchHandlerRecordId
	

	


return

/*

*/



GO


