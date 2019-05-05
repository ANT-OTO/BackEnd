IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PurchasePoolTaskFinish]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_PurchasePoolTaskFinish] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_PurchasePoolTaskFinish] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_PurchasePoolTaskFinish] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_PurchasePoolTaskFinish] 
	@pUserId int,
	@pFinalUnitPrice decimal(10, 2),
	@pFinalTotalPrice decimal(10, 2),
	@pReason nvarchar(256),
	@pItemPurchaseTaskId int output
AS

SET NOCOUNT ON
	
	declare @pTime datetime = getutcdate()
	if(exists(
		select *
		from ItemPurchaseTask a (nolock)
		where a.Id = @pItemPurchaseTaskId
		and a.ItemPurchaseStatusCodeId in (1)
	))
	begin
		update a
		set a.ItemPurchaseStatusCodeId = 2, --select * from CodeList where Category = 'ItemPurchaseStatus'
			a.LastUpdate = @pTime,
			a.LastUpdateBy = 1,
			a.LastUpdateByType = 1,
			a.FinalUnitPrice = @pFinalUnitPrice,
			a.FinalTotalPrice = @pFinalTotalPrice,
			a.Reason = @pReason
		from ItemPurchaseTask a
		where a.Id = @pItemPurchaseTaskId

		select @pItemPurchaseTaskId = SCOPE_IDENTITY()
	end



return

/*

*/



GO


