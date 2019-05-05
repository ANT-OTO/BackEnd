IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_BatchHandlerRecordCheck]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_BatchHandlerRecordCheck] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_BatchHandlerRecordCheck] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_BatchHandlerRecordCheck] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_BatchHandlerRecordCheck] 
	@pBatchHandlerId int,
	@pUserId int,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()


	declare @pCheck bit = 1
	declare @pBatchHandlerRecordId int = 0
	declare @pBatchHandlerRecordDetailId int = 0
	declare @pBatchHandlerColumnId int = 0
	declare @pValue nvarchar(256) = ''
	declare @pReason nvarchar(256) = ''

	DECLARE db_cursor CURSOR FOR 
	SELECT a.Id
	from BatchHandlerRecord a (nolock)
	where a.BatchHandlerId = @pBatchHandlerId

	OPEN db_cursor  
	FETCH NEXT FROM db_cursor INTO @pBatchHandlerRecordId

	WHILE @@FETCH_STATUS = 0  
	BEGIN  
		DECLARE db_cursor_2 CURSOR FOR 
		SELECT a.Id
		from BatchHandlerRecordDetail a (nolock)
		where a.BatchHandlerRecordId = @pBatchHandlerRecordId

		OPEN db_cursor_2  
		FETCH NEXT FROM db_cursor_2 INTO @pBatchHandlerRecordDetailId

		WHILE @@FETCH_STATUS = 0  
		BEGIN  
			

			select	@pBatchHandlerColumnId = a.BatchHandlerColumnId,
					@pValue = a.Value
			from BatchHandlerRecordDetail a (nolock)
			where a.Id = @pBatchHandlerRecordDetailId
			
			select @pReason = [dbo].[sfnBatchHandlerColumnValueCheck](@pBatchHandlerColumnId, @pValue)
			
			if(len(isnull(@pReason, '')) > 0)
			begin
				update a
				set a.Reason = @pReason,
					a.BatchHandlerRecordStatusCodeId = 3, --select* from CodeList where Category = 'BatchHandlerRecordStatus'
					a.LastUpdate = @pTime,
					a.LastUpdateBy = @pLastUpdateBy,
					a.LastUpdateByType = @pLastUpdateByType
				from BatchHandlerRecord a
				where a.Id = @pBatchHandlerRecordId

				exec [dbo].[sp_BatchHandlerRecordDetailErrorUpdate] 
					@pBatchHandlerRecordDetailId,
					1,
					@pReason
			end
			else
			begin
				exec [dbo].[sp_BatchHandlerRecordDetailErrorUpdate] 
					@pBatchHandlerRecordDetailId,
					0,
					''
			end
			

			FETCH NEXT FROM db_cursor_2 INTO @pBatchHandlerRecordDetailId
		END 

		CLOSE db_cursor_2  
		DEALLOCATE db_cursor_2 
		
		

		if(exists(
			select *
			from BatchHandlerRecord a (nolock)
				inner join BatchHandlerRecordDetail b (nolock) on a.Id = b.BatchHandlerRecordId
				inner join BatchHandlerRecordDetailError c (nolock) on b.Id = c.BatchHandlerRecordDetailId
			where c.Error = 1
			and a.Id = @pBatchHandlerRecordId
		))
		begin
			update a
			set a.BatchHandlerRecordStatusCodeId = 3, --select * from CodeList where Category = 'BatchHandlerRecordStatus'
				a.Reason = '',
				a.LastUpdate = @pTime,
				a.LastUpdateBy = @pLastUpdateBy,
				a.LastUpdateByType = @pLastUpdateByType
			from BatchHandlerRecord a
			where a.Id = @pBatchHandlerRecordId
		end
		else
		begin
			update a
			set a.BatchHandlerRecordStatusCodeId = 2, --select * from CodeList where Category = 'BatchHandlerRecordStatus'
				a.Reason = '',
				a.LastUpdate = @pTime,
				a.LastUpdateBy = @pLastUpdateBy,
				a.LastUpdateByType = @pLastUpdateByType
			from BatchHandlerRecord a
			where a.Id = @pBatchHandlerRecordId
		end
			
		FETCH NEXT FROM db_cursor INTO @pBatchHandlerRecordId
	END 

	CLOSE db_cursor  
	DEALLOCATE db_cursor 
	
	--delete all empty rows
	declare @BatchHandlerTable Table
	(
		BatchHandlerRecordId int NOT NULL
	)
	insert into @BatchHandlerTable
	(BatchHandlerRecordId)
	select b.Id
	from BatchHandler a (nolock)
		inner join BatchHandlerRecord b (nolock) on a.Id = b.BatchHandlerId
		left join BatchHandlerRecordDetail c (nolock) on c.BatchHandlerRecordId = b.Id and c.Value <> ''
	where c.Id is null
	and a.Id = @pBatchHandlerId

	delete
	from BatchHandlerRecordDetailError 
	where BatchHandlerRecordDetailId in (
		select a.Id
		from BatchHandlerRecordDetail a (nolock)
		where a.BatchHandlerRecordId in (
			select BatchHandlerRecordId
			from @BatchHandlerTable
		)
	)

	delete
	from BatchHandlerRecordDetail
	where BatchHandlerRecordId in (
		select BatchHandlerRecordId
			from @BatchHandlerTable
	)

	delete
	from BatchHandlerRecord
	where Id in (
		select BatchHandlerRecordId
			from @BatchHandlerTable
	)
	

	


return

/*

*/



GO


