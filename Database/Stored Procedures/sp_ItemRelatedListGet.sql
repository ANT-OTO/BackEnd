IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemRelatedListGet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemRelatedListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemRelatedListGet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemRelatedListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemRelatedListGet] 
	@pWizardSessionId int,
	@pItemId int,
	@pSystemLanguageId int
AS

SET NOCOUNT ON
	if(isnull(@pItemId, 0) = 0)
	begin
		select @pItemId = b.Id
		from WizardSession a (nolock)
			inner join Item b (nolock) on a.SourceId = b.Id and a.SourceTable = 'Item'
		where a.Id = @pWizardSessionId
	end
	declare @pSKU nvarchar(256) = ''
	select @pSKU = a.SKU
	from Item a (nolock)
	where a.Id = @pItemId
	if(len(@pSKU) = 0)
	begin
		return
	end
	declare @pCompanyId int = 0
	select @pCompanyId = a.CompanyId
	from CompanyItem a (nolock)
	where a.ItemId = @pItemId 
	and a.Available = 1

	select distinct a.Id as ItemId, b.Id as WizardSessionId,
		isnull(a.Name, '') as ItemName, isnull(c1.Id, 0) as CategoryId,
		isnull(v.PropertyValue, '') as VariationTitle,
		convert(int, isnull(v1.PropertyValue, '0')) as VariationReasonCodeId,
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
		case when a.Id = @pItemId then 'Y' else 'N' end as Selected
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
			left join ItemProperty v (nolock) on v.ItemId = a.Id and v.PropertyName = 'VariationTitle'
			left join ItemProperty v1 (nolock) on v1.ItemId = a.Id and v1.PropertyName = 'VariationReasonCodeId'
		where a.SKU = @pSKU
		and b.Id in (
			select a.Id
			from WizardSession a (nolock)
				inner join WizardSessionInputs b (nolock) on a.Id = b.WizardSessionId
		)
		--and a.Id <> @pItemId
		and a.ItemStatusCodeId not in (2)  --select * from CodeList where Category = 'ItemStatus'
		order by isnull(v.PropertyValue, '')



return

/*

*/



GO


