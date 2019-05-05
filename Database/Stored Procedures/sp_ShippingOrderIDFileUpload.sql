IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderIDFileUpload]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderIDFileUpload] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderIDFileUpload] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderIDFileUpload] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
Alter procedure [dbo].[sp_ShippingOrderIDFileUpload] 
	@pFileId int,
	@pShippingOrderIdentityProfileId int,
	@pShippingOrderIdentityProfileFileId int output 
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	insert into [dbo].[ShippingOrderIdentityProfileFiles]
	(
		[ShippingOrderIdentityProfileId],
		[FileId],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select @pShippingOrderIdentityProfileId, @pFileId, 1, @pTime, @pTime, 1, 1

	select @pShippingOrderIdentityProfileFileId = SCOPE_IDENTITY()

return

/*

*/



GO


