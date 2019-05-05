IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_WarehouseRackLevelUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_WarehouseRackLevelUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_WarehouseRackLevelUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_WarehouseRackLevelUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_WarehouseRackLevelUpdate] 
	@pWareHouseRackId int,
	@pRackLevelCode nvarchar(256),
	@pRackLevelName nvarchar(256),
	@pAvailable bit,
	@pUserId int,
	@pCompanyId int,
	@pWareHouseRackLevelId int output
AS

SET NOCOUNT ON
	
	declare @pTime datetime = getutcdate()
	if(isnull(@pWareHouseRackLevelId, 0) > 0)
	begin
		if(@pAvailable = 1)
		begin
			update a
			set a.RackLevelName = @pRackLevelName,
				a.RackLevelCode = @pRackLevelCode,
				a.Available = @pAvailable,
				a.LastUpdate = @pTime
			from WareHouseRackLevel a
			where a.Id = @pWareHouseRackLevelId
		end
		else
		begin
			update a
			set a.Available = @pAvailable,
				a.LastUpdate = @pTime
			from WareHouseRackLevel a
			where a.Id = @pWareHouseRackLevelId
		end
	end
	else
	begin
		insert into [dbo].WareHouseRackLevel
		(
			[WareHouseRackId],
			[RackLevelCode],
			[RackLevelName],
			[Available],
			[CreateDate],
			[LastUpdate]
		)
		select @pWareHouseRackId, @pRackLevelCode, @pRackLevelName, 1, @pTime, @pTime

		select @pWareHouseRackLevelId = SCOPE_IDENTITY()
	end



return

/*

*/



GO


