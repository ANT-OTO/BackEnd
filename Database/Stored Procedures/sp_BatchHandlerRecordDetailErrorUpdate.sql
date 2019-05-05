IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_BatchHandlerRecordDetailErrorUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_BatchHandlerRecordDetailErrorUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_BatchHandlerRecordDetailErrorUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_BatchHandlerRecordDetailErrorUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_BatchHandlerRecordDetailErrorUpdate] 
	@pBatchHandlerRecordDetailId int,
	@pError bit,
	@pErrorReason nvarchar(256)
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	if(exists(
		select * from BatchHandlerRecordDetailError a (nolock)
		where a.BatchHandlerRecordDetailId = @pBatchHandlerRecordDetailId
	))
	begin
		update a
		set a.Error = @pError,
			a.ErrorReason = @pErrorReason
		from BatchHandlerRecordDetailError a
		where a.BatchHandlerRecordDetailId = @pBatchHandlerRecordDetailId
	end
	else
	begin
		insert into [dbo].[BatchHandlerRecordDetailError]
		(
			[BatchHandlerRecordDetailId],
			[Error],
			[ErrorReason],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	@pBatchHandlerRecordDetailId,
				@pError,
				@pErrorReason,
				@pTime,
				@pTime,
				1,
				1
	end
		
	

	


return

/*

*/



GO


