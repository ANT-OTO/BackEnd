IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderBatchHandlerDetailPreUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderBatchHandlerDetailPreUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderBatchHandlerDetailPreUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderBatchHandlerDetailPreUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderBatchHandlerDetailPreUpdate] 
	@pShippingOrderCode nvarchar(256),
	@pShippingOrderBatchHandlerId int,
	@pError nvarchar(256) output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	declare @pShippingOrderChannelId int = 0
	declare @pShippingOrderStatusCodeId int = 0

	declare @pRealShippingOrderCode nvarchar(256) = ''
	select @pRealShippingOrderCode = a.ShippingOrderCode
	from ShippingOrder a (nolock)
		inner join ShippingOrderSubOrder b (nolock) on a.Id = b.ShippingOrderId and b.SubOrderTypeCodeId = 4 --select * from CodeList where Category = 'SubOrderType'
	where b.SubOrderCode = @pShippingOrderCode

	if(len(isnull(@pRealShippingOrderCode, '')) > 0)
	begin
		select @pShippingOrderCode = @pRealShippingOrderCode
	end

	select	@pShippingOrderChannelId = a.ShippingChannelId,
			@pShippingOrderStatusCodeId = a.ShippingOrderStatusCodeId --select * from CodeList where Category = 'ShippingOrderStatus'
	from ShippingOrder a (nolock) 
	where a.ShippingOrderCode = @pShippingOrderCode

	declare @pBatchHandlerChannelId int = 0
	declare @pBatchHandlerStatusCodeId int = 0
	declare @pShippingOrderActionTypeCodeId int = 0
	select	@pBatchHandlerChannelId = a.ShippingChannelId,
			@pBatchHandlerStatusCodeId = a.BatchHandlerStatusCodeId, --select * from CodeList where Category = 'BatchHandlerStatus'
			@pShippingOrderActionTypeCodeId = a.ShippingOrderActionTypeCodeId
	from ShippingOrderBatchHandler a (nolock)
	where a.Id = @pShippingOrderBatchHandlerId

	if(isnull(@pShippingOrderChannelId, 0) = 0)
	begin
		select @pError = N'包裹未选渠道'
		return
	end

	if(@pBatchHandlerStatusCodeId = 2)
	begin
		select @pError = N'批次已取消'
		return
	end

	if(@pBatchHandlerStatusCodeId = 3)
	begin
		select @pError = N'批次已完成'
		return
	end

	if(isnull(@pBatchHandlerChannelId, 0) <> isnull(@pShippingOrderChannelId, 0))
	begin
		select @pError = N'包裹渠道不符合'
		return
	end

	if(isnull(@pShippingOrderStatusCodeId, 0) in (1, 2) ) --select * from CodeList where Category = 'ShippingOrderStatus'
	begin
		select @pError = N'包裹未经过审核'
		return
	end

	if(isnull(@pShippingOrderStatusCodeId, 0) in (10,11) ) --select * from CodeList where Category = 'ShippingOrderStatus'
	begin
		select @pError = N'包裹已被拦截'
		return
	end

	if(isnull(@pShippingOrderStatusCodeId, 0) in (4,5,6,7,8,9) ) --select * from CodeList where Category = 'ShippingOrderStatus'
	begin
		select @pError = N'包裹应已出库'
		return
	end

	declare @UnPaidPrice decimal(10,2) = 0.0
	select @UnPaidPrice = [dbo].[sfnShippingOrderUnPaidPrice]
(
	null,
	@pShippingOrderCode
)
	if(isnull(@UnPaidPrice, 1.0) <> 0.0)
	begin
		select @pError = N'包裹付款不符'
		return
	end

	if(exists(
		select * 
		from ShippingOrderBatchHandler a (nolock)
			inner join ShippingOrderBatchHandlerDetail b (nolock) on a.Id = b.ShippingOrderBatchHandlerId
		where b.ShippingOrderCode = @pShippingOrderCode
		and a.BatchHandlerStatusCodeId in (1, 2)
		and a.ShippingChannelId = @pBatchHandlerChannelId
		and a.ShippingOrderActionTypeCodeId = @pShippingOrderActionTypeCodeId
		and b.Available = 1
	))
	begin
		select @pError = N'此包裹存在于某一批次'
		return
	end

	--身份证查验
	declare @pIDCheckRequired bit = 0
	declare @pIDDuplicationCheckRequired bit = 0
	declare @pIDDuplicationLimitation int = 0

	select	@pIDCheckRequired = isnull(z.IDCheckBeforeShipping, 0),
			@pIDDuplicationCheckRequired = isnull(z.IDCheckDuplicateBeforeShipping, 0),
			@pIDDuplicationLimitation = isnull(z.IDDuplicateNumberLimitation, 0) 
	from ShippingChannel a (nolock)
	left join ShippingChannelIDCheck z (nolock) on a.Id = z.ShippingChannelId
	where a.Id = @pBatchHandlerChannelId

	if(@pIDCheckRequired = 1)
	begin
		if(not exists(
			select * from ShippingOrder a (nolock)
				inner join ShippingOrderIdentityProfile b (nolock) on a.Id = b.ShippingOrderId
				inner join ShippingOrderIdentityProfileFiles c (nolock) on b.Id = c.ShippingOrderIdentityProfileId
			where a.ShippingOrderCode = @pShippingOrderCode
		)
		and not exists(
			select * from ShippingOrder a (nolock)
				inner join ShippingOrderIdentityProfile b (nolock) on a.Id = b.ShippingOrderId
				inner join ShippingOrderIdentityProfileSFValidate c (nolock) on b.Id = c.ShippingOrderIdentityProfileId
			where a.ShippingOrderCode = @pShippingOrderCode
			and c.SFValidate = 1
		))
		begin
			select @pError = N'身份证信息缺失'
			return
		end
	end

	if(@pIDDuplicationCheckRequired = 1)
	begin
		declare @pLast24Hour datetime = CONVERT(date, getutcdate())

		if(@pIDDuplicationLimitation <> 0)
		begin
			declare @SumInToday int = 0
			declare @IDNumber nvarchar(256) = ''
			select @IDNumber = b.IdentityNumber
			from ShippingOrder a (nolock)
				inner join ShippingOrderIdentityProfile b (nolock) on a.Id = b.ShippingOrderId
			where a.ShippingOrderCode = @pShippingOrderCode
			select @SumInToday = Count(d.Id)
			from ShippingOrderBatchHandler a (nolock)
				inner join ShippingOrderBatchHandlerDetail b (nolock) on a.Id = b.ShippingOrderBatchHandlerId
				inner join ShippingOrder c (nolock) on b.ShippingOrderId = c.Id
				inner join ShippingOrderIdentityProfile d (nolock) on c.Id = d.ShippingOrderId
			where a.CreateDate >= @pLast24Hour
			and a.BatchHandlerStatusCodeId in (1, 2)
			and d.IdentityNumber = @IDNumber
			and b.Available = 1
			and a.ShippingChannelId = @pBatchHandlerChannelId
			and a.ShippingOrderActionTypeCodeId = @pShippingOrderActionTypeCodeId

			if(@SumInToday >= @pIDDuplicationLimitation)
			begin
				select @pError = N'此包裹相关身份证信息今日出货达到上限'
				return
			end
		end
	end
	--运单是否付费
return

/*

*/



GO


