IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_WarehouseZoneUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_WarehouseZoneUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_WarehouseZoneUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_WarehouseZoneUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_WarehouseZoneUpdate] 
	@pWareHouseLevelId int,
	@pZoneCode nvarchar(256),
	@pZoneName nvarchar(256),
	@pAvailable bit,
	@pUserId int,
	@pCompanyId int,
	@pWareHouseZoneId int output
AS

SET NOCOUNT ON
	
	declare @pTime datetime = getutcdate()
	if(isnull(@pWareHouseZoneId, 0) > 0)
	begin
		if(@pAvailable = 1)
		begin
			update a
			set a.ZoneName = @pZoneName,
				a.ZoneCode = @pZoneCode,
				a.Available = @pAvailable,
				a.LastUpdate = @pTime
			from WareHouseZone a
			where a.Id = @pWareHouseZoneId
		end
		else
		begin
			update a
			set a.Available = @pAvailable,
				a.LastUpdate = @pTime
			from WareHouseZone a
			where a.Id = @pWareHouseZoneId
		end
	end
	else
	begin
		insert into [dbo].WarehouseZone
		(
			[WareHouseLevelId],
			[ZoneCode],
			[ZoneName],
			[Available],
			[CreateDate],
			[LastUpdate]
		)
		select @pWareHouseLevelId, @pZoneCode, @pZoneName, 1, @pTime, @pTime

		select @pWarehouseZoneId = SCOPE_IDENTITY()
	end



return

/*

*/



GO


