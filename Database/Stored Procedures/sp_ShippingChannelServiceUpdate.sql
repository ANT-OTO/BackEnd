IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingChannelServiceUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingChannelServiceUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingChannelServiceUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingChannelServiceUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
Alter procedure [dbo].[sp_ShippingChannelServiceUpdate] 
	@pShippingChannelId int,
	@pServiceName nvarchar(256),
	@pServicePrice decimal(10,2),
	@pCurrencyId int,
	@pOptional bit,
	@pAvailable bit,
	@pLastUpdateBy int,
	@pLastUpdateByType int,
	@pShippingChannelIncrementServiceId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	insert into [dbo].[ShippingChannelIncrementService]
	(
		[ShippingChannelId],
		[ServiceName],
		[ServicePrice],
		[CurrencyId],
		[Optional],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	a.ShippingChannelId, a.ServiceName, a.ServicePrice,
			a.CurrencyId, a.Optional, isnull(a.Available, 1),
			a.CreateDate, a.LastUpdate, a.LastUpdateBy, a.LastUpdateByType
	from 
	(
		select	@pShippingChannelId as ShippingChannelId,
				@pServiceName as ServiceName,
				@pServicePrice as ServicePrice,
				@pCurrencyId as CurrencyId,
				@pOptional as Optional,
				@pAvailable as Available,
				@pTime as CreateDate,
				@pTime as LastUpdate,
				@pLastUpdateBy as LastUpdateBy,
				@pLastUpdateByType as LastUpdateByType
	) a
	left join [dbo].[ShippingChannelIncrementService] z (nolock) on a.ShippingChannelId = z.ShippingChannelId
	where z.Id is null
	
	if(@@ROWCOUNT > 0)
	begin
		select @pShippingChannelIncrementServiceId = SCOPE_IDENTITY()
	end
	else
	begin
		update a
		set a.ServiceName = @pServiceName,
			a.ServicePrice = @pServicePrice,
			a.CurrencyId = @pCurrencyId,
			a.Optional = @pOptional,
			a.Available = isnull(@pAvailable, 1),
			a.LastUpdate = @pTime,
			a.LastUpdateBy = @pLastUpdateBy,
			a.LastUpdateByType = @pLastUpdateByType
		from [ShippingChannelIncrementService] a
		where a.Id = @pShippingChannelIncrementServiceId
	end

return

/*

*/



GO


