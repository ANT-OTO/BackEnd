IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_WarehouseUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_WarehouseUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_WarehouseUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_WarehouseUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_WarehouseUpdate] 
	@pContactManagerName nvarchar(256),
	@pContactNumber nvarchar(256),
	@pContactCountryId int,
	@pAddress1 nvarchar(512),
	@pAddress2 nvarchar(512),
	@pCity nvarchar(256),
	@pState nvarchar(64),
	@pZip nvarchar(64),
	@pCountryId int,
	@pWareHouse_Name nvarchar(256),
	@pAvailable bit,
	@pUserId int,
	@pCompanyId int,
	@pWareHouseId int output
AS

SET NOCOUNT ON
	
	declare @pTime datetime = getutcdate()
	declare @pAddressId int = 0
	if(isnull(@pWareHouseId, 0) > 0)
	begin
		
		select @pAddressId = a.AddressId
		from WareHouse a (nolock)
		where a.Id = @pWareHouseId

		update a
		set a.Address1 = @pAddress1,
			a.Address2 = isnull(@pAddress2, ''),
			a.City = @pCity,
			a.CountryId = @pCountryId,
			a.District = '',
			a.LastUpdate = @pTime,
			a.LastUpdateBy = @pUserId,
			a.LastUpdateByType = 1,
			a.State = @pState,
			a.Zip = @pZip
		from [Address] a
		where a.Id = @pAddressId

		if(@pAvailable = 1)
		begin
			update a
			set a.ManagerName = @pContactManagerName,
				a.ContactNumber = @pContactNumber,
				a.ContactNumberCountryId = @pContactCountryId,
				a.AddressId = @pAddressId,
				a.Available = @pAvailable,
				a.CompanyId = @pCompanyId,
				a.WareHouse_Name = @pWareHouse_Name,
				a.WareHouse_Code = 'AW' + RIGHT('000000' + CAST(a.Id AS NCHAR(6)), 6 ),
				a.LastUpdate = @pTime
			from WareHouse a
			where a.Id = @pWareHouseId
		end
		else
		begin
			update a
			set a.Available = @pAvailable,
				a.LastUpdate = @pTime
			from WareHouse a
			where a.Id = @pWareHouseId
		end
	end
	else
	begin
		insert into [dbo].[Address]
		(
			[Address1],
			[Address2],
			[City],
			[District],
			[State],
			[Zip],
			[CountryId],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	@pAddress1 as [Address1],
				isnull(@pAddress2, '') as [Address2],
				@pCity as [City],
				'' as [District],
				@pState as [State],
				@pZip as [Zip],
				@pCountryId as [CountryId],
				@pTime as [CreateDate],
				@pTime as [LastUpdate],
				@pUserId as [LastUpdateBy],
				1 as [LastUpdateByType]
		select @pAddressId = SCOPE_IDENTITY()

		if(isnull(@pAddressId, 0) > 0)
		begin
			 insert into [dbo].[WareHouse]
			 (
				[CompanyId],
				[AddressId],
				[ManagerName],
				[ContactNumber],
				[ContactNumberCountryId],
				[WareHouse_Code],
				[WareHouse_Name],
				[Available],
				[CreateDate],
				[LastUpdate]
			)
			select	@pCompanyId, @pAddressId, @pContactManagerName,
					@pContactNumber, @pContactCountryId, '',
					@pWareHouse_Name, 1, @pTime, @pTime

			select @pWareHouseId = SCOPE_IDENTITY()

			update a
			set a.WareHouse_Code = 'AW' + RIGHT('000000' + CAST(a.Id AS NCHAR(6)), 6)
			from WareHouse a
			where a.Id = @pWareHouseId
		end

	end



return

/*

*/



GO


