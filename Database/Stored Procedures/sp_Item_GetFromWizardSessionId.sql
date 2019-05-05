IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Item_GetFromWizardSessionId]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Item_GetFromWizardSessionId] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Item_GetFromWizardSessionId] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Item_GetFromWizardSessionId] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Item_GetFromWizardSessionId] 
	@pWizardSessionId int,
	@pCompanyId int,
	@pSystemLanguageId int
AS

SET NOCOUNT ON
	
	declare @pTime datetime = getutcdate()
	
		select distinct a.Id as ItemId, b.Id as WizardSessionId,
				isnull(a.Name, '') as ItemName, isnull(c1.Id, 0) as CategoryId,
				isnull(c1.Name, '') as Category, isnull(d1.Id, 0) as BrandId,
				isnull(d1.BrandName, '') as Brand,
				a.ItemStatusCodeId,
				isnull(y.CodeShort, z.CodeShort) as ItemStatusCode,
				isnull(x.FileId, null) as MainImageFileId,
				isnull(a.SKU, '') as [SKU],
				isnull(a.ProductCode, '') as ProductCode,
				isnull(a.Description, '') as ProductDescription,
				isnull(z1.PropertyValue, '') as SupplierSKU,
				isnull(y1.PropertyValue, '') as ModelNumber,
			DENSE_RANK() OVER (order by a.Id desc) AS RowNumber
		--select * 
		from Item a (nolock)
			inner join WizardSession b (nolock) on a.Id = b.SourceId and b.SourceTable = 'Item'
			inner join CompanyItem a1 (nolock) on a1.ItemId = a.Id and a1.CompanyId = @pCompanyId and a1.Available = 1
			left join ItemCategory c (nolock) on a.Id = c.ItemId
			left join Category c1 (nolock) on c.CategoryId = c1.Id
			left join ItemBrand d (nolock) on a.Id = d.ItemId
			left join Brand d1 (nolock) on d.BrandId = d1.Id
			left join CodeList z (nolock) on z.Category = 'ItemStatus' and z.CodeId = a.ItemStatusCodeId
			left join CodeListY y (nolock) on z.Id = y.CodeListId and y.SystemLanguageId = @pSystemLanguageId
			left join ItemResource x (nolock) on a.Id = x.ItemId and x.MainResource = 1 and x.Available = 1
			left join ItemProperty z1 (nolock) on a.Id = z1.ItemId and z1.PropertyName = 'SupplierSKU'
			left join ItemProperty y1 (nolock) on a.Id = y1.ItemId and y1.PropertyName = 'ModelNumber'
			left join WizardSessionInputs w (nolock) on b.Id = w.WizardSessionId and w.StepSourceTable = 'ItemRelatedUPCInfo'
			left join ItemRelatedUPCInfo w1 (nolock) on w.StepSourceId = w1.Id and w1.Available = 1
	
		where b.Id = @pWizardSessionId



return

/*

*/



GO


