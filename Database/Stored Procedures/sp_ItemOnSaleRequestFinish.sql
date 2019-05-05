IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemOnSaleRequestFinish]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemOnSaleRequestFinish] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemOnSaleRequestFinish] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemOnSaleRequestFinish] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemOnSaleRequestFinish] 
	@pItemOnSaleRequestId int output,
	@pUserId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	update a
	set a.ItemOnSaleRequestStatusCodeId = 3,--select * from CodeList where Category = 'ItemOnSaleRequestStatus'
		a.LastUpdateBy = @pUserId,
		a.LastUpdate = @pTime
	from ItemOnSaleRequest a 
	where a.Id = @pItemOnSaleRequestId
	and a.ItemOnSaleRequestStatusCodeId not in (3, 4)

	if(@@ROWCOUNT = 0)
	begin
		select @pItemOnSaleRequestId = 0
	end



return

/*

*/



GO


