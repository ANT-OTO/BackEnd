IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemPackageUpdateAfter]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemPackageUpdateAfter] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemPackageUpdateAfter] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemPackageUpdateAfter] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemPackageUpdateAfter] 
	@pItemSubmitPackageId int output,
	@pItemUpdatePackageId int output,
	@pPrice nvarchar(256) ,
	@pCurrencyId int,
	@pProductName nvarchar(max),
	@pWeight nvarchar(256),
	@pSaleTitle nvarchar(max)  ,
	@pSalePlace nvarchar(256)  ,
	@pDiscountDescription nvarchar(max)  ,
	@pSizeRange nvarchar(max)  ,
	@pColorRange nvarchar(max)  ,
	@pUserId int,
	@pCompanyId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	if(isnull(@pItemSubmitPackageId, 0) > 0)
	begin
		if(exists(
			select *
			from ItemSubmitPackage a (nolock)
			where a.Id = @pItemSubmitPackageId
			and a.ItemPackageStatusCodeId in (1, 2)--select * from CodeList where Category = 'ItemPackageStatus'
		))
		begin
			update a
			set a.Price = @pPrice,
				a.CurrencyId = @pCurrencyId,
				a.DiscountDescription = @pDiscountDescription,
				a.SalePlace = @pSalePlace,
				a.SaleTitle = @pSaleTitle,
				a.SizeRange = @pSizeRange,
				a.Weight = @pWeight,
				a.ColorRange = @pColorRange,
				a.LastUpdate = @pTime,
				a.LastUpdateBy = @pUserId,
				a.LastUpdateByType = 1
			from ItemSubmitPackage a
			where a.Id = @pItemSubmitPackageId

			if(@@ROWCOUNT = 0)
			begin
				select @pItemSubmitPackageId = 0
			end
		end
		else
		begin
			select @pItemSubmitPackageId = 0
		end
	end
	else
	begin
		if(exists(
			select *
			from ItemUpdatePackage a (nolock)
			where a.Id = @pItemUpdatePackageId
			and a.ItemPackageStatusCodeId in (1, 2)--select * from CodeList where Category = 'ItemPackageStatus'
		))
		begin
			update a
			set a.Price = @pPrice,
				a.CurrencyId = @pCurrencyId,
				a.DiscountDescription = @pDiscountDescription,
				a.SalePlace = @pSalePlace,
				a.SaleTitle = @pSaleTitle,
				a.SizeRange = @pSizeRange,
				a.Weight = @pWeight,
				a.ColorRange = @pColorRange,
				a.LastUpdate = @pTime,
				a.LastUpdateBy = @pUserId,
				a.LastUpdateByType = 1
			from ItemUpdatePackage a
			where a.Id = @pItemUpdatePackageId

			if(@@ROWCOUNT = 0)
			begin
				select @pItemUpdatePackageId = 0
			end
		end
		else
		begin
			select @pItemUpdatePackageId = 0
		end
	end



return

/*

*/



GO


