IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ANTOTOShippingOrderRoutingHistoryInsert]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ANTOTOShippingOrderRoutingHistoryInsert] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ANTOTOShippingOrderRoutingHistoryInsert] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ANTOTOShippingOrderRoutingHistoryInsert] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ANTOTOShippingOrderRoutingHistoryInsert] 
	@pShippingOrderId int,
	@pAcceptedAddress nvarchar(256),
	@pOpCode nvarchar(256),
	@pRemarkDetail nvarchar(256),
	@pAcceptedTime datetime,
	@pSourceId int,
	@pSourceTable nvarchar(256),
	@pUserId int,
	@pLastUpdateBy int,
	@pLastUpdateByType int,
	@pShippingOrderRouteHistoryId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	insert into [dbo].[ShippingOrderRouteHistory]
	(
		[ShippingOrderId],
		[AcceptedAddress],
		[OpCode],
		[RemarkDetail],
		[AcceptTime], 
		[SourceId],
		[SourceTable],
		[UserId],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	@pShippingOrderId, @pAcceptedAddress, @pOpCode, @pRemarkDetail,
			@pAcceptedTime, @pSourceId, @pSourceTable, @pUserId,
			@pTime, @pTime, @pLastUpdateBy, @pLastUpdateByType

	select @pShippingOrderRouteHistoryId = SCOPE_IDENTITY()
	


	

	


return

/*

*/



GO


