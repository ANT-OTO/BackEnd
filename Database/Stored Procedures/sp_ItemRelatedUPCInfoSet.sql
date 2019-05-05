IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemRelatedUPCInfoSet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemRelatedUPCInfoSet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemRelatedUPCInfoSet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemRelatedUPCInfoSet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemRelatedUPCInfoSet] 
	@pUPC nvarchar(256),
	@pDescription nvarchar(256),
	@pSaleTag nvarchar(256),
	@pItemRelatedUPCInfoId int output
AS

SET NOCOUNT ON

if(@pUPC is null or len(@pUPC) = 0)
begin
	select @pItemRelatedUPCInfoId = 0
	return
end
declare @pTime datetime = getutcdate()
if(isnull(@pItemRelatedUPCInfoId, 0) = 0)
begin
	insert into  [dbo].[ItemRelatedUPCInfo]
	(
		[UPC],
		[Description],
		[SaleTag],
		[Available],
		[CreateDate],
		[LastUpdate]
	)
	select	@pUPC,@pDescription,@pSaleTag,1, @pTime, @pTime

	select @pItemRelatedUPCInfoId = SCOPE_IDENTITY()
end
else
begin
	update a
	set a.UPC = @pUPC,
		a.[Description] = @pDescription,
		a.SaleTag = @pSaleTag,
		a.Available = 1,
		a.LastUpdate = @pTime
	from ItemRelatedUPCInfo a
	where a.Id = @pItemRelatedUPCInfoId
	if(@@ROWCOUNT > 0)
	begin
		select @pItemRelatedUPCInfoId = @pItemRelatedUPCInfoId
	end
	else
	begin
		select @pItemRelatedUPCInfoId = 0
	end
end
return




return

/*

*/



GO


