IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderIdentityProfileMatch]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderIdentityProfileMatch] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderIdentityProfileMatch] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderIdentityProfileMatch] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderIdentityProfileMatch] 
	@pShippingOrderId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	declare @pName nvarchar(256) = ''
	declare @pPhoneNumber nvarchar(256) = ''

	select	@pName = b.ContactPersonLastName + '' +b.ContactPersonFirstName,
			@pPhoneNumber = b.ContactPersonPhoneNumber
	from ShippingOrder a (nolock)
		inner join ShippingAddress b (nolock) on a.ShippingToAddressId = b.Id
	where a.Id = @pShippingOrderId

	declare @pChinaIdentityProfileId int = 0
	--select * from ShippingOrderIdentityProfile
	declare @pShippingOrderIdentityProfileId int = 0
	declare @pIdentityNumber nvarchar(256) = ''
	declare @pFrontFileId int = 0
	declare @pBackFileId int = 0

	select	@pIdentityNumber = a.IdentityNumber,
			@pFrontFileId = a.FrontFileId,
			@pBackFileId = a.BackFileId
	from [dbo].[tfnChinaIdentityProfileGet] 
	( 
		@pName,
		@pPhoneNumber
	) a

	if(len(isnull(@pIdentityNumber, '')) = 0)
	begin
		return
	end

	if(not exists(
		select *
		from ShippingOrderIdentityProfile a (nolock)
		where a.ShippingOrderId = @pShippingOrderId
	))
	begin
		insert into ShippingOrderIdentityProfile
		(
			ShippingOrderId,
			IdentityNumber,
			Name,
			PhoneNumber,
			Available,
			CreateDate,
			LastUpdate,
			LastUpdateBy,
			LastUpdateByType
		)
		select	@pShippingOrderId,
				@pIdentityNumber,
				@pName,
				@pPhoneNumber,
				1,
				@pTime,
				@pTime,
				1,
				1
		
		select @pShippingOrderIdentityProfileId = SCOPE_IDENTITY()

		--select * from ShippingOrderIdentityProfileFiles
		insert into ShippingOrderIdentityProfileFiles
		(
			ShippingOrderIdentityProfileId,
			FileId,
			Available,
			CreateDate,
			LastUpdate,
			LastUpdateBy,
			LastUpdateByType
		)
		select	@pShippingOrderIdentityProfileId,
				@pFrontFileId,
				1,
				@pTime,
				@pTime,
				1,
				1
		insert into ShippingOrderIdentityProfileFiles
		(
			ShippingOrderIdentityProfileId,
			FileId,
			Available,
			CreateDate,
			LastUpdate,
			LastUpdateBy,
			LastUpdateByType
		)
		select	@pShippingOrderIdentityProfileId,
				@pBackFileId,
				1,
				@pTime,
				@pTime,
				1,
				1


	end
	else
	begin
		update a
		set a.IdentityNumber = @pIdentityNumber,
			a.Available = 1,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = 1,
			a.LastUpdateByType = 1
		from ShippingOrderIdentityProfile a
		where a.Id = @pShippingOrderId
		select @pShippingOrderIdentityProfileId = a.Id
		from ShippingOrderIdentityProfile a
		where a.Id = @pShippingOrderId
		delete
		from ShippingOrderIdentityProfileFiles
		where ShippingOrderIdentityProfileId = @pShippingOrderIdentityProfileId

		insert into ShippingOrderIdentityProfileFiles
		(
			ShippingOrderIdentityProfileId,
			FileId,
			Available,
			CreateDate,
			LastUpdate,
			LastUpdateBy,
			LastUpdateByType
		)
		select	@pShippingOrderIdentityProfileId,
				@pFrontFileId,
				1,
				@pTime,
				@pTime,
				1,
				1
		insert into ShippingOrderIdentityProfileFiles
		(
			ShippingOrderIdentityProfileId,
			FileId,
			Available,
			CreateDate,
			LastUpdate,
			LastUpdateBy,
			LastUpdateByType
		)
		select	@pShippingOrderIdentityProfileId,
				@pBackFileId,
				1,
				@pTime,
				@pTime,
				1,
				1
	end




return

/*

*/



GO


