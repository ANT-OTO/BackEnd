IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderBatchHandlerDetailUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderBatchHandlerDetailUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderBatchHandlerDetailUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderBatchHandlerDetailUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderBatchHandlerDetailUpdate] 
	@pShippingOrderCode nvarchar(256),
	@pShippingOrderBatchHandlerId int,
	@pAvailable bit,
	@pUserId int,
	@pShippingOrderBatchHandlerDetailId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	declare @pShippingOrderId int = 0
	select @pShippingOrderId = a.Id
	from ShippingOrder a (nolock)
	where a.ShippingOrderCode = @pShippingOrderCode
	if(exists(
		select * from ShippingOrderBatchHandler a
	))

	if(exists(
		select *
		from ShippingOrderBatchHandler a (nolock)
			inner join ShippingOrderBatchHandlerDetail b (nolock) on a.Id = b.ShippingOrderBatchHandlerId
		where b.Id = @pShippingOrderBatchHandlerDetailId
	))
	begin
		update a
		set a.Available = @pAvailable
		from ShippingOrderBatchHandlerDetail a
		where a.Id = @pShippingOrderBatchHandlerDetailId
	end
	else
	begin
		insert into [dbo].[ShippingOrderBatchHandlerDetail]
		(
			[ShippingOrderBatchHandlerId], 
			[ShippingOrderId],
			[ShippingOrderCode],
			[Available],
			[UserId],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	@pShippingOrderBatchHandlerId,
				@pShippingOrderId,
				@pShippingOrderCode,
				@pAvailable,
				@pUserId,
				@pTime,
				@pTime,
				@pUserId,
				1
		select @pShippingOrderBatchHandlerDetailId = SCOPE_IDENTITY()
	end



return

/*

*/



GO


