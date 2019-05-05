IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderProfileGenerate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderProfileGenerate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderProfileGenerate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderProfileGenerate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
Alter procedure [dbo].[sp_ShippingOrderProfileGenerate] 
	@pShippingOrderId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	if(not exists(
		select *
		from ShippingOrder a (nolock)
			inner join ShippingOrderIdentityProfile b (nolock) on a.Id = b.ShippingOrderId
		where a.Id = @pShippingOrderId
	))
	begin
		declare @pShippingOrderIdentityProfileId int = 0
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
		select	a.Id,
				'000000000000000000',
				replace(b.ContactPersonLastName, ' ', '') + '' + replace(b.ContactPersonFirstName, ' ', ''),
				b.ContactPersonPhoneNumber,
				1,
				@pTime,
				@pTime,
				1,
				1
		from ShippingOrder a (nolock)
			inner join ShippingAddress b (nolock) on a.ShippingToAddressId = b.Id
		where a.Id = @pShippingOrderId

		select @pShippingOrderIdentityProfileId = SCOPE_IDENTITY()

		if(@pShippingOrderIdentityProfileId > 0)
		begin
			insert into [dbo].[ShippingOrderIdentityProfileSFValidate]
			( 
				[ShippingOrderIdentityProfileId],
				[SFValidate],
				[CreateDate],
				[LastUpdate],
				[LastUpdateBy],
				[LastUpdateByType]
			)
			select @pShippingOrderIdentityProfileId, 0, @pTime, @pTime, 1, 1
			
		end

		

		
	end
	else
	begin
		if(exists(
			select *
			from ShippingOrderIdentityProfile a (nolock)
				inner join ShippingOrder b(nolock) on a.ShippingOrderId = b.Id
				inner join ShippingAddress c (nolock) on b.ShippingToAddressId = c.Id
			where replace(a.Name, ' ', '') <> replace(c.ContactPersonLastName, ' ', '') + '' + replace(c.ContactPersonFirstName, ' ', '')
			or replace(a.PhoneNumber, ' ', '') <> replace(c.ContactPersonPhoneNumber, ' ','')
		))
		begin
			update a
			set a.Name = replace(c.ContactPersonLastName, ' ', '') + '' + replace(c.ContactPersonFirstName, ' ', ''),
				a.PhoneNumber = c.ContactPersonPhoneNumber,
				a.IdentityNumber = '000000000000000000',
				a.LastUpdate = @pTime,
				a.LastUpdateBy = 1,
				a.LastUpdateByType = 1
			from [dbo].[ShippingOrderIdentityProfile] a
				inner join ShippingOrder b (nolock) on a.ShippingOrderId = b.Id
				inner join ShippingAddress c (nolock) on b.ShippingToAddressId = c.Id
			where a.ShippingOrderId = @pShippingOrderId

			update a
			set a.[SFValidate] = 0,
				a.LastUpdate = @pTime,
				a.LastUpdateBy = 1,
				a.LastUpdateByType = 1
			from [ShippingOrderIdentityProfileSFValidate] a 
				inner join [ShippingOrderIdentityProfile] b (nolock) on a.ShippingOrderIdentityProfileId = b.Id
			where b.ShippingOrderId = @pShippingOrderId
		end
		
	end
return

/*

*/



GO


