IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_BatchHandlerRecordPropertySet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_BatchHandlerRecordPropertySet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_BatchHandlerRecordPropertySet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_BatchHandlerRecordPropertySet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
Alter procedure [dbo].[sp_BatchHandlerRecordPropertySet] 
	@pBatchHandlerRecordId int,
	@pPropertyName nvarchar(64),
	@pPropertyValue nvarchar(256),
	@pUserId int,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	insert into [dbo].BatchHandlerRecordProperty
	(
		[BatchHandlerRecordId],
		[PropertyName],
		[PropertyValue],   
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	a.BatchHandlerRecordId, a.PropertyName, a.PropertyValue,
			a.CreateDate, a.LastUpdate, a.LastUpdateBy, a.LastUpdateByType
	from
	(
		select	@pBatchHandlerRecordId as BatchHandlerRecordId, @pPropertyName as PropertyName,
				@pPropertyValue as PropertyValue, @pTime as CreateDate,
				@pTime as LastUpdate, @pLastUpdateBy as LastUpdateBy,
				@pLastUpdateByType as LastUpdateByType
	) a
	left join [dbo].BatchHandlerRecordProperty z (nolock) on a.BatchHandlerRecordId = z.BatchHandlerRecordId
	where z.Id is null
	
	if(@@ROWCOUNT = 0)
	begin
		update a
		set a.PropertyName = @pPropertyName,
			a.PropertyValue = @pPropertyValue,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = @pLastUpdateBy,
			a.LastUpdateByType = @pLastUpdateByType
		from dbo.BatchHandlerRecordProperty a
		where a.BatchHandlerRecordId = @pBatchHandlerRecordId
	end

	
	


return

/*

*/



GO


