IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderIDFileClear]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderIDFileClear] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderIDFileClear] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderIDFileClear] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
Alter procedure [dbo].[sp_ShippingOrderIDFileClear] 
	@pShippingOrderIdentityProfileId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	update a
	set a.Available = 0
	from ShippingOrderIdentityProfileFiles a
	where a.ShippingOrderIdentityProfileId = @pShippingOrderIdentityProfileId
	and a.Available = 1

return

/*

*/



GO


