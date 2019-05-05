IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ANTOTOShippingOrderWeightUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ANTOTOShippingOrderWeightUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ANTOTOShippingOrderWeightUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ANTOTOShippingOrderWeightUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ANTOTOShippingOrderWeightUpdate] 
	@pTotalWeight decimal(10,2),
	@pWeightUnitId int,
	@pUserId int,
	@pShippingOrderId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	

	update a
	set a.TotalWeight = @pTotalWeight,
		a.WeightUnitId = @pWeightUnitId,
		a.UserId = @pUserId,
		a.LastUpdate = @pTime
	from ShippingOrder a
	where a.Id = @pShippingOrderId


	

	


return

/*

*/



GO


