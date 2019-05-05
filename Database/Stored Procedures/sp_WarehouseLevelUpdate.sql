IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_WarehouseLevelUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_WarehouseLevelUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_WarehouseLevelUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_WarehouseLevelUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_WarehouseLevelUpdate] 
	@pWareHouseId int,
	@pLevelName nvarchar(256),
	@pLevelCode nvarchar(256),
	@pAvailable bit,
	@pUserId int,
	@pCompanyId int,
	@pWareHouseLevelId int output
AS

SET NOCOUNT ON
	
	declare @pTime datetime = getutcdate()
	if(isnull(@pWareHouseLevelId, 0) > 0)
	begin

		if(@pAvailable = 1)
		begin
			update a
			set a.LevelName = @pLevelName,
				a.LevelCode = @pLevelCode,
				a.Available = @pAvailable,
				a.LastUpdate = @pTime
			from WareHouseLevel a
			where a.Id = @pWareHouseLevelId
		end
		else
		begin
			update a
			set a.Available = @pAvailable,
				a.LastUpdate = @pTime
			from WareHouseLevel a
			where a.Id = @pWareHouseLevelId
		end
	end
	else
	begin
		insert into [dbo].WarehouseLevel
		(
			[WareHouseId],
			[LevelCode],
			[LevelName],
			[Available],
			[CreateDate],
			[LastUpdate]
		)
		select @pWareHouseId, @pLevelCode, @pLevelName, 1, @pTime, @pTime

		select @pWarehouseLevelId = SCOPE_IDENTITY()
	end



return

/*

*/



GO


