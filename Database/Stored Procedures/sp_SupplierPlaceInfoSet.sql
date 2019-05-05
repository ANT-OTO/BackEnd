IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_SupplierPlaceInfoSet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_SupplierPlaceInfoSet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_SupplierPlaceInfoSet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_SupplierPlaceInfoSet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_SupplierPlaceInfoSet] 
	@pSupplierName nvarchar(256),
	@pSupplierLocation nvarchar(256),
	@pPriceInfo nvarchar(256),
	@pCurrencyId int,
	@pDescription nvarchar(max),
	@pUserId int,
	@pSupplierPlaceInfoId int output
AS

SET NOCOUNT ON

declare @Time datetime = getutcdate()
if(@pSupplierName is null or len(@pSupplierName) = 0)
begin
	select @pSupplierPlaceInfoId = 0
	return
end
declare @pTime datetime = getutcdate()
if(isnull(@pSupplierPlaceInfoId, 0) = 0)
begin
	insert into [dbo].[SupplierPlaceInfo]
	(
		[SupplierName],
		[SupplierLocation],
		[PriceInfo],
		[CurrencyId],
		[Description],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	@pSupplierName, isnull(@pSupplierLocation, ''),
			isnull(@pPriceInfo, ''), isnull(@pCurrencyId, 0),
			isnull(@pDescription, ''), @pTime,
			@pTime, @pUserId, 1

	select @pSupplierPlaceInfoId = SCOPE_IDENTITY()
end
else
begin
	update a
	set a.CurrencyId = @pCurrencyId,
		a.Description = @pDescription,
		a.SupplierLocation = @pSupplierLocation,
		a.LastUpdate = @pTime,
		a.LastUpdateBy = @pUserId,
		a.LastUpdateByType = 1,
		a.PriceInfo = @pPriceInfo,
		a.SupplierName = @pSupplierName
	from SupplierPlaceInfo a
	where a.Id = @pSupplierPlaceInfoId
	if(@@ROWCOUNT > 0)
	begin
		select @pSupplierPlaceInfoId = @pSupplierPlaceInfoId
	end
	else
	begin
		select @pSupplierPlaceInfoId = 0
	end
end
return




return

/*

*/



GO


