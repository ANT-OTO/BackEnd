IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_BatchHandlerRecordDetailInsert]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_BatchHandlerRecordDetailInsert] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_BatchHandlerRecordDetailInsert] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_BatchHandlerRecordDetailInsert] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_BatchHandlerRecordDetailInsert] 
	@pBatchHandlerRecordId int,
	@pColumnName nvarchar(256),
	@pBatchHandlerRecordDetailId int output,
	@pValue nvarchar(256),
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	declare @pBatchHandlerColumnId int = 0
	declare @pBatchHandlerId int = 0
	select @pValue = replace(@pValue, N'非必填项', '')
	select @pBatchHandlerId = a.Id
	from BatchHandler a (nolock)
		inner join BatchHandlerRecord b (nolock) on a.Id = b.BatchHandlerId
	where b.Id = @pBatchHandlerRecordId

	select @pBatchHandlerColumnId = a.Id 
	from BatchHandlerColumn a (nolock)
	where a.BatchHandlerId = @pBatchHandlerId
	and a.ColumnOrder = convert(int, @pColumnName)

	if(isnull(@pBatchHandlerColumnId, 0) <= 0)
	begin
		return
	end

	insert into [dbo].[BatchHandlerRecordDetail]
	(
		[BatchHandlerRecordId],
		[BatchHandlerColumnId],
		[Value],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	@pBatchHandlerRecordId,
			@pBatchHandlerColumnId,
			@pValue,
			@pTime,
			@pTime,
			@pLastUpdateBy,
			@pLastUpdateByType

	select @pBatchHandlerRecordDetailId = SCOPE_IDENTITY()
		
	

	


return

/*

*/



GO


