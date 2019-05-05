IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_BatchHandlerRecordDetailUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_BatchHandlerRecordDetailUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_BatchHandlerRecordDetailUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_BatchHandlerRecordDetailUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_BatchHandlerRecordDetailUpdate] 
	@pBatchHandlerRecordDetailId int,
	@pValue nvarchar(256),
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	update a
	set a.Value = @pValue,
		a.LastUpdateBy = @pLastUpdateBy,
		a.LastUpdateByType = @pLastUpdateByType
	from BatchHandlerRecordDetail a
	where a.Id = @pBatchHandlerRecordDetailId

return

/*

*/



GO


