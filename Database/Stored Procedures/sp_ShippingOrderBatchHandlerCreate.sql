IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderBatchHandlerCreate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderBatchHandlerCreate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderBatchHandlerCreate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderBatchHandlerCreate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderBatchHandlerCreate] 
	@pCompanyId int,
	@pUserId int,
	@pShippingChannelId int,
	@pShippingOrderActionTypeCodeId int,
	@pShippingOrderBatchHandlerId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	declare @pBatchHandlerCode nvarchar(256) = ''

	insert into [dbo].[ShippingOrderBatchHandler]
	(
		[CompanyId],
		[BatchHandlerCode], 
		[BatchHandlerStatusCodeId], --select * from CodeList where Category = 'BatchHandlerStatus'
		[ShippingOrderActionTypeCodeId],
		[UserId],
		[ShippingChannelId],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	a.CompanyId, a.BatchHandlerCode,
			a.BatchHandlerStatusCodeId,
			a.ShippingOrderActionTypeCodeId,
			a.UserId, a.ShippingChannelId,
			a.CreateDate, a.LastUpdate,
			a.LastUpdateBy, a.LastUpdateByType
	from (
		select	@pCompanyId as [CompanyId],
				@pBatchHandlerCode as [BatchHandlerCode],
				1 as [BatchHandlerStatusCodeId],
				@pShippingOrderActionTypeCodeId as [ShippingOrderActionTypeCodeId],
				@pShippingChannelId as [ShippingChannelId],
				@pUserId as [UserId],
				@pTime as [CreateDate],
				@pTime as [LastUpdate],
				@pUserId as [LastUpdateBy],
				1 as [LastUpdateByType]
	) a

	select @pShippingOrderBatchHandlerId = SCOPE_IDENTITY()

	select @pBatchHandlerCode = 'ASBH' + RIGHT('000000'+CAST(@pShippingOrderBatchHandlerId AS VARCHAR(6)),6)

	update a
	set a.BatchHandlerCode = @pBatchHandlerCode
	from ShippingOrderBatchHandler a
	where a.Id = @pShippingOrderBatchHandlerId

return

/*

*/



GO


