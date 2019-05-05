IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderSubOrderTrackRecordInsert]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderSubOrderTrackRecordInsert] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderSubOrderTrackRecordInsert] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderSubOrderTrackRecordInsert] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderSubOrderTrackRecordInsert] 
	@pShippingOrderSubOrderId int,
	@pAcceptedAddress nvarchar(256),
	@pOpCode nvarchar(256),
	@pRemarkDetail nvarchar(max),
	@pAcceptTime datetime, 
	@pSourceId int,
	@pSourceTable nvarchar(256),
	@pUserId int,
	@pAvailable bit,
	@pShippingOrderSubOrderRoutingTrackId int output

AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	select @pShippingOrderSubOrderRoutingTrackId = a.Id
	from ShippingOrderSubOrderRoutingTrack a (nolock)
	where a.AcceptedAddress = @pAcceptedAddress
	and a.AcceptTime = @pAcceptTime
	and a.OpCode = @pOpCode
	and a.RemarkDetail = @pRemarkDetail
	and a.Available = 1
	and a.ShippingOrderSubOrderId = @pShippingOrderSubOrderId



	if(isnull(@pShippingOrderSubOrderRoutingTrackId, 0) = 0)
	begin
		insert into [dbo].[ShippingOrderSubOrderRoutingTrack]
		(
			[ShippingOrderSubOrderId],
			[AcceptedAddress],
			[OpCode],
			[RemarkDetail],
			[AcceptTime], 
			[SourceId],
			[SourceTable],
			[UserId],
			[Available],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	a.ShippingOrderSubOrderId,
				a.AcceptedAddress,
				a.OpCode,
				a.RemarkDetail,
				a.AcceptTime,
				a.SourceId,
				a.SourceTable,
				a.UserId,
				a.Available,
				a.CreateDate,
				a.LastUpdate,
				a.LastUpdateBy,
				a.LastUpdateByType
		from 
		(
			select	@pShippingOrderSubOrderId as [ShippingOrderSubOrderId], @pAcceptedAddress as [AcceptedAddress], 
					@pOpCode as [OpCode], @pRemarkDetail as [RemarkDetail],
					@pAcceptTime as [AcceptTime], isnull(@pSourceId, 0) as SourceId, 
					isnull(@pSourceTable, '') as SourceTable, @pUserId as UserId, 
					isnull(@pAvailable, 1) as Available, @pTime as CreateDate, @pTime as LastUpdate,
					@pUserId as [LastUpdateBy], 1 as [LastUpdateByType]
		) a
		left join [dbo].[ShippingOrderSubOrderRoutingTrack] z (nolock) on a.ShippingOrderSubOrderId = z.ShippingOrderSubOrderId
			and a.AcceptedAddress = z.AcceptedAddress and a.OpCode = z.OpCode and a.RemarkDetail = z.RemarkDetail
		where z.Id is null

		select @pShippingOrderSubOrderRoutingTrackId = SCOPE_IDENTITY() 

		if(exists(
			select *
			from ShippingOrderSubOrder a (nolock)
				inner join ShippingOrder b (nolock) on a.ShippingOrderId = b.Id
			where b.ShippingOrderStatusCodeId not in (8, 9, 10, 11) --select * from CodeList where Category = 'ShippingOrderStatus'
			and a.SubOrderTypeCodeId = 4 --select * from CodeList where Category = 'SubOrderType'
			and a.Id = @pShippingOrderSubOrderId
		))
		begin
			if(@pOpCode = '612' or @pOpCode = '606')
			begin
				update a
				set a.ShippingOrderStatusCodeId = 6,
					a.LastUpdate = @pTime
				from ShippingOrder a
					inner join ShippingOrderSubOrder b (nolock) on a.Id = b.ShippingOrderId
				where b.Id = @pShippingOrderSubOrderId
				and a.ShippingOrderStatusCodeId in (1, 2, 3, 4, 5)
			end
			if(exists(
				select * from ShippingOrder a
					inner join ShippingOrderSubOrder b (nolock) on a.Id = b.ShippingOrderId
					inner join ShippingOrderSubOrderRoutingTrack c (nolock) on b.Id = c.ShippingOrderSubOrderId
				where b.Id = @pShippingOrderSubOrderId
				and (c.OpCode = '612' or c.OpCode = '606')
				and a.ShippingOrderStatusCodeId = 6 
			))
			begin
				declare @p612OpTime datetime = null
				select @p612OpTime = max(c.AcceptTime)
				from ShippingOrder a
					inner join ShippingOrderSubOrder b (nolock) on a.Id = b.ShippingOrderId
					inner join ShippingOrderSubOrderRoutingTrack c (nolock) on b.Id = c.ShippingOrderSubOrderId
				where b.Id = @pShippingOrderSubOrderId
				and (c.OpCode = '612' or c.OpCode = '606')
				and a.ShippingOrderStatusCodeId = 6
				if(@pAcceptTime > @p612OpTime)
				begin
					update a
					set a.ShippingOrderStatusCodeId = 7,
						a.LastUpdate = @pTime
					from ShippingOrder a
						inner join ShippingOrderSubOrder b (nolock) on a.Id = b.ShippingOrderId
					where b.Id = @pShippingOrderSubOrderId
					and a.ShippingOrderStatusCodeId in (1, 2, 3, 4, 5, 6) 
				end
			end

			if(@pOpCode = '8000' or @pOpCode = '80')
			begin
				update a
				set a.ShippingOrderStatusCodeId = 8,
					a.LastUpdate = @pTime
				from ShippingOrder a
					inner join ShippingOrderSubOrder b (nolock) on a.Id = b.ShippingOrderId
				where b.Id = @pShippingOrderSubOrderId
				and a.ShippingOrderStatusCodeId in (1, 2, 3, 4, 5, 6, 7)
			end

		end
	end
	else
	begin
		if(@pAvailable = 1)
		begin
			update a
			set a.AcceptedAddress = @pAcceptedAddress,
				a.AcceptTime = @pAcceptTime,
				a.OpCode = @pOpCode,
				a.RemarkDetail = @pRemarkDetail,
				a.SourceId = isnull(@pSourceId, 0),
				a.SourceTable = isnull(@pSourceTable, ''),
				a.UserId = @pUserId,
				a.LastUpdateBy = @pUserId,
				a.Available = isnull(@pAvailable, 1),
				a.LastUpdateByType = 1
			from ShippingOrderSubOrderRoutingTrack a
			where a.Id = @pShippingOrderSubOrderRoutingTrackId
		end
		else
		begin
			update a
			set a.UserId = @pUserId,
				a.LastUpdateBy = @pUserId,
				a.Available = isnull(@pAvailable, 1),
				a.LastUpdateByType = 1
			from ShippingOrderSubOrderRoutingTrack a
			where a.Id = @pShippingOrderSubOrderRoutingTrackId
		end 
		if(@pOpCode = '612' or @pOpCode = '606')
		begin
			update a
			set a.ShippingOrderStatusCodeId = 6,
				a.LastUpdate = @pTime
			from ShippingOrder a
				inner join ShippingOrderSubOrder b (nolock) on a.Id = b.ShippingOrderId
			where b.Id = @pShippingOrderSubOrderId
			and a.ShippingOrderStatusCodeId in (1, 2, 3, 4, 5)
		end
		if(exists(
				select * from ShippingOrder a
					inner join ShippingOrderSubOrder b (nolock) on a.Id = b.ShippingOrderId
					inner join ShippingOrderSubOrderRoutingTrack c (nolock) on b.Id = c.ShippingOrderSubOrderId
				where b.Id = @pShippingOrderSubOrderId
				and (c.OpCode = '612' or c.OpCode = '606')
				and a.ShippingOrderStatusCodeId = 6 
			))
			begin
				select @p612OpTime = max(c.AcceptTime)
				from ShippingOrder a
					inner join ShippingOrderSubOrder b (nolock) on a.Id = b.ShippingOrderId
					inner join ShippingOrderSubOrderRoutingTrack c (nolock) on b.Id = c.ShippingOrderSubOrderId
				where b.Id = @pShippingOrderSubOrderId
				and (c.OpCode = '612' or c.OpCode = '606')
				and a.ShippingOrderStatusCodeId = 6
				if(@pAcceptTime > @p612OpTime)
				begin
					update a
					set a.ShippingOrderStatusCodeId = 7,
						a.LastUpdate = @pTime
					from ShippingOrder a
						inner join ShippingOrderSubOrder b (nolock) on a.Id = b.ShippingOrderId
					where b.Id = @pShippingOrderSubOrderId
					and a.ShippingOrderStatusCodeId in (1, 2, 3, 4, 5, 6) 
				end
			end
		if(@pOpCode = '8000' or @pOpCode = '80')
		begin
			update a
			set a.ShippingOrderStatusCodeId = 8,
				a.LastUpdate = @pTime
			from ShippingOrder a
				inner join ShippingOrderSubOrder b (nolock) on a.Id = b.ShippingOrderId
			where b.Id = @pShippingOrderSubOrderId
			and a.ShippingOrderStatusCodeId in (1, 2, 3, 4, 5, 6, 7)
		end
	end 
	
	


return

/*

*/



GO


