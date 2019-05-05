IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_WarehouseRackUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_WarehouseRackUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_WarehouseRackUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_WarehouseRackUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_WarehouseRackUpdate] 
	@pWareHouseZoneId int,
	@pRackCode nvarchar(256),
	@pRackName nvarchar(256),
	@pAvailable bit,
	@pUserId int,
	@pCompanyId int,
	@pWareHouseRackId int output
AS

SET NOCOUNT ON
	
	declare @pTime datetime = getutcdate()
	if(isnull(@pWareHouseRackId, 0) > 0)
	begin
		if(@pAvailable = 1)
		begin
			update a
			set a.RackName = @pRackName,
				a.RackCode = @pRackCode,
				a.Available = @pAvailable,
				a.LastUpdate = @pTime
			from WareHouseRack a
			where a.Id = @pWareHouseRackId
		end
		else
		begin
			update a
			set a.Available = @pAvailable,
				a.LastUpdate = @pTime
			from WareHouseRack a
			where a.Id = @pWareHouseRackId
		end
	end
	else
	begin
		insert into [dbo].WareHouseRack
		(
			[WareHouseZoneId],
			[RackCode],
			[RackName],
			[Available],
			[CreateDate],
			[LastUpdate]
		)
		select @pWareHouseZoneId, @pRackCode, @pRackName, 1, @pTime, @pTime

		select @pWareHouseRackId = SCOPE_IDENTITY()
	end



return

/*

*/



GO


