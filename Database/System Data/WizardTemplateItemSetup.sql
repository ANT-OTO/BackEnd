begin tran

---Category Brand Based Wizard Template
declare @Time datetime = getutcdate()
declare @WizardTemplateItemId int = 0
declare @CategoryId int = 0
declare @BrandId int = 0
insert into [dbo].[WizardTemplateItem]
(
	[CategoryId],
	[BrandId],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @CategoryId, @BrandId, 1, @Time, @Time, 1, 1

select @WizardTemplateItemId = SCOPE_IDENTITY()
declare @WizardTemplateId int = 0
insert into [dbo].[WizardTemplate]
(
	[SourceId],
	[SourceTable],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardTemplateItemId, 'WizardTemplateItem', 1, @Time, @Time, 1, 1

select @WizardTemplateId = SCOPE_IDENTITY()

declare @WizardMasterId int = 0

insert into  [dbo].[WizardMaster]
(
	[WizardTemplateId],
	[Name],
	[Description],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardTemplateId, 'ItemBaseForm', 'ItemBaseForm', 1, @Time, @Time, 1, 1

select @WizardMasterId = SCOPE_IDENTITY()

declare @WizardMasterStepId int = 0
--------------------Step 1------------------------------------------
begin
insert into [dbo].[WizardMasterStep]
(
	[WizardMasterId],
	[StepCode],
	[StepDisplayName],
	[Order],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterId, '1', 'General Info', '001', 1, @Time, @Time, 1, 1

select @WizardMasterStepId = SCOPE_IDENTITY()
declare @WizardMasterStepElementId int = 0
--Input Element 1 
insert into [dbo].[WizardMasterStepElement]
(
	[WizardMasterStepId],
	[WizardMasterStepElementTypeCodeId], --select * from CodeList where Category = 'WizardMasterStepElementType'
	[Level],
	[Order],
	[Weight],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepId, 2, 1, '001', 1, 1, @Time, @Time, 1, 1

select @WizardMasterStepElementId = SCOPE_IDENTITY()

insert into [dbo].[WizardMasterStepElementInput]
(
	[WizardMasterStepElementId],
	[InputName],
	[InputDisplayName],
	[InputTypeCodeId], --select* from CodeList where Category = 'InputType'
	[AllowList],
	[Required],
	[InputDiscription],
	[ValidationCode],
	[ValidationFailMessage],
	[WizardInputListId], --only exists when it is List.
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepElementId, 'ProductName', 'Product Name', 1, 0, 1, 'Product Name', '', '', null, 1, @Time, @Time, 1, 1


--Input Element 2
insert into [dbo].[WizardMasterStepElement]
(
	[WizardMasterStepId],
	[WizardMasterStepElementTypeCodeId], --select * from CodeList where Category = 'WizardMasterStepElementType'
	[Level],
	[Order],
	[Weight],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepId, 2, 2, '001', 1, 1, @Time, @Time, 1, 1

select @WizardMasterStepElementId = SCOPE_IDENTITY()

insert into [dbo].[WizardMasterStepElementInput]
(
	[WizardMasterStepElementId],
	[InputName],
	[InputDisplayName],
	[InputTypeCodeId], --select* from CodeList where Category = 'InputType'
	[AllowList],
	[Required],
	[InputDiscription],
	[ValidationCode],
	[ValidationFailMessage],
	[WizardInputListId], --only exists when it is List.
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepElementId, 'ProductDesc', 'Product Description', 1, 0, 1, 'Product Description', '', '', null, 1, @Time, @Time, 1, 1


--Input Element 3
insert into [dbo].[WizardMasterStepElement]
(
	[WizardMasterStepId],
	[WizardMasterStepElementTypeCodeId], --select * from CodeList where Category = 'WizardMasterStepElementType'
	[Level],
	[Order],
	[Weight],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepId, 2, 3, '001', 1, 1, @Time, @Time, 1, 1

select @WizardMasterStepElementId = SCOPE_IDENTITY()

insert into [dbo].[WizardMasterStepElementInput]
(
	[WizardMasterStepElementId],
	[InputName],
	[InputDisplayName],
	[InputTypeCodeId], --select* from CodeList where Category = 'InputType'
	[AllowList],
	[Required],
	[InputDiscription],
	[ValidationCode],
	[ValidationFailMessage],
	[WizardInputListId], --only exists when it is List.
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepElementId, 'SKU', 'SKU', 1, 0, 1, 'SKU', '', '', null, 1, @Time, @Time, 1, 1


--Input Element 3
insert into [dbo].[WizardMasterStepElement]
(
	[WizardMasterStepId],
	[WizardMasterStepElementTypeCodeId], --select * from CodeList where Category = 'WizardMasterStepElementType'
	[Level],
	[Order],
	[Weight],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepId, 2, 4, '001', 1, 1, @Time, @Time, 1, 1

select @WizardMasterStepElementId = SCOPE_IDENTITY()

insert into [dbo].[WizardMasterStepElementInput]
(
	[WizardMasterStepElementId],
	[InputName],
	[InputDisplayName],
	[InputTypeCodeId], --select* from CodeList where Category = 'InputType'
	[AllowList],
	[Required],
	[InputDiscription],
	[ValidationCode],
	[ValidationFailMessage],
	[WizardInputListId], --only exists when it is List.
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepElementId, 'ProductCode', 'ProductCode', 4, 0, 1, 'ProductCode', '', '', null, 1, @Time, @Time, 1, 1


--Input Element 4
insert into [dbo].[WizardMasterStepElement]
(
	[WizardMasterStepId],
	[WizardMasterStepElementTypeCodeId], --select * from CodeList where Category = 'WizardMasterStepElementType'
	[Level],
	[Order],
	[Weight],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepId, 2, 5, '001', 1, 1, @Time, @Time, 1, 1

select @WizardMasterStepElementId = SCOPE_IDENTITY()

insert into [dbo].[WizardMasterStepElementInput]
(
	[WizardMasterStepElementId],
	[InputName],
	[InputDisplayName],
	[InputTypeCodeId], --select* from CodeList where Category = 'InputType'
	[AllowList],
	[Required],
	[InputDiscription],
	[ValidationCode],
	[ValidationFailMessage],
	[WizardInputListId], --only exists when it is List.
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepElementId, 'ProductCodeType', 'ProductCodeType', 2, 0, 1, 'ProductCodeType', '', '', 1, 1, @Time, @Time, 1, 1
end


--------------------Step 2------------------------------------------
begin
insert into [dbo].[WizardMasterStep]
(
	[WizardMasterId],
	[StepCode],
	[StepDisplayName],
	[Order],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterId, '2', 'ProductImage', '002', 1, @Time, @Time, 1, 1

select @WizardMasterStepId = SCOPE_IDENTITY()
--Prompt Element 2
insert into [dbo].[WizardMasterStepElement]
(
	[WizardMasterStepId],
	[WizardMasterStepElementTypeCodeId], --select * from CodeList where Category = 'WizardMasterStepElementType'
	[Level],
	[Order],
	[Weight],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepId, 1, 1, '001', 1, 1, @Time, @Time, 1, 1

select @WizardMasterStepElementId = SCOPE_IDENTITY()

insert into [dbo].[WizardMasterStepElementPrompt]
(
	[WizardMasterStepElementId],
	[DisplayText],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepElementId, 'Main Image is useful for you to identify the product you entered.', 1, @Time, @Time, 1, 1


--Input Element 1 
insert into [dbo].[WizardMasterStepElement]
(
	[WizardMasterStepId],
	[WizardMasterStepElementTypeCodeId], --select * from CodeList where Category = 'WizardMasterStepElementType'
	[Level],
	[Order],
	[Weight],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepId, 2, 2, '001', 1, 1, @Time, @Time, 1, 1

select @WizardMasterStepElementId = SCOPE_IDENTITY()

insert into [dbo].[WizardMasterStepElementInput]
(
	[WizardMasterStepElementId],
	[InputName],
	[InputDisplayName],
	[InputTypeCodeId], --select* from CodeList where Category = 'InputType'
	[AllowList],
	[Required],
	[InputDiscription],
	[ValidationCode],
	[ValidationFailMessage],
	[WizardInputListId], --only exists when it is List.
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepElementId, 'MainImage', 'Main Image', 3, 0, 1, 'Main Image', '', '', null, 1, @Time, @Time, 1, 1




--Input Element 3
insert into [dbo].[WizardMasterStepElement]
(
	[WizardMasterStepId],
	[WizardMasterStepElementTypeCodeId], --select * from CodeList where Category = 'WizardMasterStepElementType'
	[Level],
	[Order],
	[Weight],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepId, 2, 3, '001', 1, 1, @Time, @Time, 1, 1

select @WizardMasterStepElementId = SCOPE_IDENTITY()

insert into [dbo].[WizardMasterStepElementInput]
(
	[WizardMasterStepElementId],
	[InputName],
	[InputDisplayName],
	[InputTypeCodeId], --select* from CodeList where Category = 'InputType'
	[AllowList],
	[Required],
	[InputDiscription],
	[ValidationCode],
	[ValidationFailMessage],
	[WizardInputListId], --only exists when it is List.
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepElementId, 'OtherImage', 'Other Images', 3, 1, 0, 'OtherImage', '', '', null, 1, @Time, @Time, 1, 1
end


--------------------Step 3------------------------------------------
begin
insert into [dbo].[WizardMasterStep]
(
	[WizardMasterId],
	[StepCode],
	[StepDisplayName],
	[Order],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterId, '3', 'Variations', '003', 1, @Time, @Time, 1, 1

select @WizardMasterStepId = SCOPE_IDENTITY()

--Input Element 1 
begin
insert into [dbo].[WizardMasterStepElement]
(
	[WizardMasterStepId],
	[WizardMasterStepElementTypeCodeId], --select * from CodeList where Category = 'WizardMasterStepElementType'
	[Level],
	[Order],
	[Weight],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepId, 2, 1, '001', 1, 1, @Time, @Time, 1, 1

select @WizardMasterStepElementId = SCOPE_IDENTITY()

insert into [dbo].[WizardMasterStepElementInput]
(
	[WizardMasterStepElementId],
	[InputName],
	[InputDisplayName],
	[InputTypeCodeId], --select* from CodeList where Category = 'InputType'
	[AllowList],
	[Required],
	[InputDiscription],
	[ValidationCode],
	[ValidationFailMessage],
	[WizardInputListId], --only exists when it is List.
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepElementId, 'SizeVariation', 'Size Variations', 1, 1, 0, 'Size Variations', '', '', null, 1, @Time, @Time, 1, 1
end

--Input Element 2
begin
insert into [dbo].[WizardMasterStepElement]
(
	[WizardMasterStepId],
	[WizardMasterStepElementTypeCodeId], --select * from CodeList where Category = 'WizardMasterStepElementType'
	[Level],
	[Order],
	[Weight],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepId, 2, 2, '001', 1, 1, @Time, @Time, 1, 1

select @WizardMasterStepElementId = SCOPE_IDENTITY()

insert into [dbo].[WizardMasterStepElementInput]
(
	[WizardMasterStepElementId],
	[InputName],
	[InputDisplayName],
	[InputTypeCodeId], --select* from CodeList where Category = 'InputType'
	[AllowList],
	[Required],
	[InputDiscription],
	[ValidationCode],
	[ValidationFailMessage],
	[WizardInputListId], --only exists when it is List.
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepElementId, 'ColorVariation', 'Color Variations', 1, 1, 0, 'Color Variations', '', '', null, 1, @Time, @Time, 1, 1
end

--Input Element 3
begin
insert into [dbo].[WizardMasterStepElement]
(
	[WizardMasterStepId],
	[WizardMasterStepElementTypeCodeId], --select * from CodeList where Category = 'WizardMasterStepElementType'
	[Level],
	[Order],
	[Weight],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepId, 2, 3, '001', 1, 1, @Time, @Time, 1, 1

select @WizardMasterStepElementId = SCOPE_IDENTITY()

insert into [dbo].[WizardMasterStepElementInput]
(
	[WizardMasterStepElementId],
	[InputName],
	[InputDisplayName],
	[InputTypeCodeId], --select* from CodeList where Category = 'InputType'
	[AllowList],
	[Required],
	[InputDiscription],
	[ValidationCode],
	[ValidationFailMessage],
	[WizardInputListId], --only exists when it is List.
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardMasterStepElementId, 'BundleVariation', 'Bundle Variations', 1, 1, 0, 'Bundle Variations', '', '', null, 1, @Time, @Time, 1, 1
end



end




select * from WizardMaster order by Id desc

select * from WizardMasterStep order by Id desc

select* from WizardMasterStepElement order by Id desc

select* from WizardMasterStepElementInput ORDER BY Id desc

select * from WizardMasterStepElementPrompt order by Id desc


--commit
--rollback