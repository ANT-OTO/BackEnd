IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderIdentityProfileMatchBack]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderIdentityProfileMatchBack] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderIdentityProfileMatchBack] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderIdentityProfileMatchBack] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderIdentityProfileMatchBack] 
	@pChinaIdentityProfileId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	declare @pName nvarchar(256) = ''
	declare @pPhoneNumber nvarchar(256) = ''
	declare @pIdentityNumber nvarchar(256) = ''
	declare @pFrontFileId int = 0
	declare @pBackFileId int = 0
	select	@pName = a.Name,
			@pPhoneNumber = a.PhoneNumber,
			@pIdentityNumber = a.IdentityNumber,
			@pFrontFileId = a.FrontFileId,
			@pBackFileId = a.BackFileId
	from ChinaIdentityProfile a (nolock)
	where a.Id = @pChinaIdentityProfileId
	IF(@pFrontFileId = 0 or @pBackFileId = 0)
	begin
		return
	end
	declare @pShippingOrderIdentityProfileId int = 0

	declare @pShippingOrderId int = 0
	DECLARE db_cursor_2 CURSOR FOR 
		SELECT a.Id
		from ShippingOrder a (nolock)
			inner join ShippingAddress b (nolock) on a.ShippingToAddressId = b.Id
		where b.ContactPersonLastName + '' + b.ContactPersonFirstName = @pName
		and b.ContactPersonPhoneNumber = @pPhoneNumber

		OPEN db_cursor_2  
		FETCH NEXT FROM db_cursor_2 INTO @pShippingOrderId

		WHILE @@FETCH_STATUS = 0  
		BEGIN  
			select @pShippingOrderIdentityProfileId = 0
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

			FETCH NEXT FROM db_cursor_2 INTO @pShippingOrderId
		END 

		CLOSE db_cursor_2  
		DEALLOCATE db_cursor_2 





return

/*

*/



GO


