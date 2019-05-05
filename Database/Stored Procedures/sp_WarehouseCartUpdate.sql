IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_WarehouseCartUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_WarehouseCartUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_WarehouseCartUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_WarehouseCartUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_WarehouseCartUpdate] 
	@pWareHouseId int,
	@pCartName nvarchar(256),
	@pCartCode nvarchar(256),
	@pAvailable bit,
	@pUserId int,
	@pCompanyId int,
	@pWareHouseCartId int output
AS

SET NOCOUNT ON
	
	declare @pTime datetime = getutcdate()
	if(isnull(@pWareHouseCartId, 0) > 0)
	begin

		if(isnull(@pAvailable, 0) = 1)
		begin
			update a
			set a.CartCode = @pCartCode,
				a.CartName = @pCartName,
				a.Available = @pAvailable,
				a.LastUpdate = @pTime
			from WarehouseCart a
			where a.Id = @pWareHouseCartId
		end
		else
		begin
			update a
			set a.Available = @pAvailable,
				a.LastUpdate = @pTime
			from WarehouseCart a
			where a.Id = @pWareHouseCartId
		end
	end
	else
	begin
		insert into [dbo].WarehouseCart
		(
			[WareHouseId],
			[CartCode],
			[CartName],
			[Available],
			[CreateDate],
			[LastUpdate]
		)
		select @pWareHouseId, @pCartCode, @pCartName, 1, @pTime, @pTime

		select @pWarehouseCartId = SCOPE_IDENTITY()
	end



return

/*

*/



GO


