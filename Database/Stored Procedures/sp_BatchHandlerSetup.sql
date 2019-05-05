IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_BatchHandlerSetup]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_BatchHandlerSetup] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_BatchHandlerSetup] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_BatchHandlerSetup] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_BatchHandlerSetup] 
	@pBatchHandlerId int output,
	@pBatchTemplateId int,
	@pBatchStatusCodeId int,
	@pUserId int,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	insert into [dbo].[BatchHandler]
	(
		[BatchNumber],
		[BatchTemplateId], 
		[UserId],
		[BatchStatusCodeId], --select * from CodeList where Category = 'BatchStatus'
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select '', @pBatchTemplateId, @pUserId, 1, @pTime, @pTime, @pLastUpdateBy, @pLastUpdateByType


	select @pBatchHandlerId = SCOPE_IDENTITY()

	update a
	set a.BatchNumber = 'AEBH' + RIGHT('00000000' + CAST(@pBatchHandlerId AS NCHAR(8)), 8 )
	from BatchHandler a
	where a.Id = @pBatchHandlerId

	-- Column Setup
	insert into [dbo].[BatchHandlerColumn]
	(
		[BatchHandlerId],
		[ColumnTypeCodeId], -- select * from CodeList where Category = 'ColumnType'
		[ColumnName],
		[ColumnOrder],
		[Required],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	@pBatchHandlerId,
			b.ColumnTypeCodeId,
			b.ColumnName,
			b.ColumnOrder,
			b.[Required],
			b.Available,
			@pTime,
			@pTime,
			1,
			1
	from BatchTemplate a (nolock)
		inner join BatchTemplateContent b (nolock) on a.Id = b.BatchTemplateId
	where a.Id = @pBatchTemplateId
	order by b.ColumnOrder
	

	


return

/*

*/



GO


