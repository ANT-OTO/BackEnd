IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderProfileSFValidateUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderProfileSFValidateUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderProfileSFValidateUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderProfileSFValidateUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
Alter procedure [dbo].[sp_ShippingOrderProfileSFValidateUpdate] 
	@pShippingOrderId int,
	@pValidated bit
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	if(not exists(
		select *
		from ShippingOrder a (nolock)
			inner join ShippingOrderIdentityProfile b (nolock) on a.Id = b.ShippingOrderId
			inner join [ShippingOrderIdentityProfileSFValidate] c (nolock) on b.Id = c.ShippingOrderIdentityProfileId
		where a.Id = @pShippingOrderId
	))
	begin
		insert into [ShippingOrderIdentityProfileSFValidate]
		(
			[ShippingOrderIdentityProfileId],
			[SFValidate],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select b.Id, isnull(@pValidated, 0), @pTime, @pTime, 1, 1
		from ShippingOrder a (nolock)
			inner join ShippingOrderIdentityProfile b (nolock) on a.Id = b.ShippingOrderId
		where a.Id = @pShippingOrderId
	end
	else
	begin
		update a
		set a.SFValidate = isnull(@pValidated, 0),
			a.LastUpdate = @pTime,
			a.LastUpdateBy = 1,
			a.LastUpdateByType = 1
		from [ShippingOrderIdentityProfileSFValidate] a
			inner join ShippingOrderIdentityProfile b (nolock) on a.ShippingOrderIdentityProfileId = b.Id
			inner join ShippingOrder c (nolock) on b.ShippingOrderId = c.Id
		where c.Id = @pShippingOrderId
	end
		
	
return

/*

*/



GO


