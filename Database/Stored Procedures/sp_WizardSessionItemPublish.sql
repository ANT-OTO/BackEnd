IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_WizardSessionItemPublish]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_WizardSessionItemPublish] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_WizardSessionItemPublish] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_WizardSessionItemPublish] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_WizardSessionItemPublish] 
	@pWizardSessionId int,
	@pItemId int output,
	@pError nvarchar(256) output
AS

SET NOCOUNT ON

declare @Time datetime = getutcdate()

if(not exists(
	select * 
	from Item a (nolock) 
		inner join WizardSession b (nolock) on b.SourceId = a.Id and b.SourceTable = 'Item'
	where b.Id = @pWizardSessionId
))
begin
	select @pError = 'No Item associated'
	return
end

select @pItemId = a.Id
from Item a (nolock) 
		inner join WizardSession b (nolock) on b.SourceId = a.Id and b.SourceTable = 'Item'
where b.Id = @pWizardSessionId

declare @pItemName nvarchar(256) = ''
declare @pItemDescription nvarchar(max) = ''
declare @pProductCode nvarchar(256) = ''
declare @pProductCodeType nvarchar(256) = ''
declare @pSKU nvarchar(256) = ''

select @pItemName = a.InputTextValue
from [dbo].[tfnWizardSessionInputGet]
(
    @pWizardSessionId,
	'ProductName'
) a

select @pItemDescription = a.InputTextValue
from [dbo].[tfnWizardSessionInputGet]
(
    @pWizardSessionId,
	'ProductDesc'
) a

declare @pCategoryId int = 0
declare @pBrandId int = 0

select @pCategoryId = a.CategoryId
from ItemCategory a (nolock)
where a.ItemId = @pItemId
and a.Available = 1
--select * from Category order by Id desc

--select @pBrandId = a.BrandId
--from ItemBrand a (nolock)
--where a.ItemId = @pItemId
--and a.Available = 1


select @pSKU = 'A' + 
right('0000' + cast(@pCategoryId as varchar(4)), 4) + 
right('00000000' + cast(@pItemId as varchar(8)), 8)



select @pProductCode = a.InputTextValue
from [dbo].[tfnWizardSessionInputGet]
(
    @pWizardSessionId,
	'ProductCode'
) a

select @pProductCodeType = a.InputTextValue
from [dbo].[tfnWizardSessionInputGet]
(
    @pWizardSessionId,
	'ProductCodeType'
) a


update a
set a.Name = @pItemName,
	a.Description = @pItemDescription,
	a.SKU = case when a.SKU is null or len(a.SKU) = 0 then @pSKU else a.SKU end,
	a.ProductCode = @pProductCode,
	a.ItemStatusCodeId = 3 --select * from CodeList where Category = 'ItemStatus'
from Item a
where a.Id = @pItemId
and a.ItemStatusCodeId = 1




return

/*

*/



GO


