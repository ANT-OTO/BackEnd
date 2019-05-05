IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderIDUpload]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderIDUpload] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderIDUpload] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderIDUpload] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
Alter procedure [dbo].[sp_ShippingOrderIDUpload] 
	@pShippingOrderId int,
	@pShippingOrderCode nvarchar(256),
	@pIDNumber nvarchar(256),
	@pName nvarchar(256),
	@pPhoneNumber nvarchar(256),
	@pShippingOrderIdentityProfileId int output 
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	if(isnull(@pShippingOrderCode, '') <> '')
	begin
		select @pShippingOrderId = a.Id
		from ShippingOrder a (nolock)
		where a.ShippingOrderCode = @pShippingOrderCode
	end

	insert into [dbo].[ShippingOrderIdentityProfile]
	(
		[ShippingOrderId],
		[IdentityNumber],
		[Name],
		[PhoneNumber],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	a.ShippingOrderId, a.IDNumber, a.Name,
			a.PhoneNumber, a.Available, a.CreateDate, a.LastUpdate,
			a.LastUpdateBy, a.LastUpdateByType
	from
	(
		SELECT	@pShippingOrderId as [ShippingOrderId],
				@pIDNumber as [IDNumber], @pName as [Name], @pPhoneNumber as [PhoneNumber],
				1 as [Available], @pTime as CreateDate, @pTime as LastUpdate, 1 as LastUpdateBy,
				1 as LastUpdateByType
	) a
	left join ShippingOrderIdentityProfile z (nolock) on a.ShippingOrderId = z.ShippingOrderId
	where z.Id is null

	if(@@ROWCOUNT > 0)
	begin
		select @pShippingOrderIdentityProfileId = SCOPE_IDENTITY()
	end
	else
	begin
		select @pShippingOrderIdentityProfileId = a.Id 
		from ShippingOrderIdentityProfile a
			inner join ShippingOrder b (nolock) on a.ShippingOrderId = b.Id
		where a.ShippingOrderId = @pShippingOrderId
		or b.ShippingOrderCode = @pShippingOrderCode
		update a
		set a.IdentityNumber = isnull(@pIDNumber, a.IdentityNumber),
			a.Name = isnull(@pName, a.Name),
			a.PhoneNumber = isnull(@pPhoneNumber, a.PhoneNumber),
			a.Available = 1
		from ShippingOrderIdentityProfile a
			inner join ShippingOrder b (nolock) on a.ShippingOrderId = b.Id
		where a.ShippingOrderId = @pShippingOrderId
		or b.ShippingOrderCode = @pShippingOrderCode
	end


return

/*

*/



GO


