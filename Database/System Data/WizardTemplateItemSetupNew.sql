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
select @WizardTemplateId, 'ItemAdForm', 'ItemAdForm', 1, @Time, @Time, 1, 1

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
select @WizardMasterId, '1', N'基本信息', '001', 1, @Time, @Time, 1, 1

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
select @WizardMasterStepElementId, 'ProductName', N'名称', 1, 0, 1, N'商品名称', '', '', null, 1, @Time, @Time, 1, 1


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
select @WizardMasterStepElementId, 'ProductDesc', N'描述', 1, 0, 1, N'为上新和仓库识别用，例如外形和特点及卖点等', '', '', null, 1, @Time, @Time, 1, 1


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
select @WizardMasterStepElementId, 'SKU', 'SKU', 1, 0, 1, N'蚂蚁SKU', '', '', null, 1, @Time, @Time, 1, 1


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
select @WizardMasterStepElementId, 'ModelNumber', N'产品型号', 1, 0, 0, N'产品的型号或其他编码', '', '', null, 1, @Time, @Time, 1, 1


--Input Element 5
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
select @WizardMasterStepElementId, 'SupplierSKU', N'供应商货号', 1, 0, 0, N'供应商SKU或者其他类型货号', '', '', null, 1, @Time, @Time, 1, 1
end

--Input Element 6
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
select @WizardMasterStepId, 2, 6, '001', 1, 1, @Time, @Time, 1, 1

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
select @WizardMasterStepElementId, 'ProductCode', N'商品条码', 4, 0, 1, N'商品条码（支持UPC/EAN）', '', '', null, 1, @Time, @Time, 1, 1
end
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
select @WizardMasterId, '2', N'商品细节', '002', 1, @Time, @Time, 1, 1

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
select @WizardMasterStepElementId, 'Material', N'材质', 1, 0, 0, N'商品材质（例如牛皮）', '', '', null, 1, @Time, @Time, 1, 1
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
select @WizardMasterStepElementId, 'Size', N'尺寸', 1, 0, 0, N'商品尺寸（例如2cm*5cm*10cm）', '', '', null, 1, @Time, @Time, 1, 1
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
select @WizardMasterStepElementId, 'Bundle', N'包装', 1, 0, 0, N'针对保健品等灌装或盒装等产品（100粒装）', '', '', null, 1, @Time, @Time, 1, 1
end

--Input Element 4
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
select @WizardMasterStepElementId, 'Weight', N'净重', 1, 0, 0, N'商品净重', '', '', null, 1, @Time, @Time, 1, 1
end

--Input Element 5
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
select @WizardMasterStepElementId, 'NetQuantity', N'净含量', 1, 0, 0, N'针对保健品或视频等灌装或盒装等产品，去包装后含量', '', '', null, 1, @Time, @Time, 1, 1
end
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
select @WizardMasterId, '3', N'商品图片', '003', 1, @Time, @Time, 1, 1

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
select @WizardMasterStepElementId, N'主图要求白底，像素要求至少800*800，用于商品上新，入库，发送，市场管理等', 1, @Time, @Time, 1, 1


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
select @WizardMasterStepElementId, 'MainImage', N'主图', 3, 0, 1, N'产品主图', '', '', null, 1, @Time, @Time, 1, 1




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
select @WizardMasterStepElementId, 'OtherImage', N'产品附图', 3, 1, 0, N'产品附图（可配描述）', '', '', null, 1, @Time, @Time, 1, 1
end


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
select @WizardMasterId, '4', N'供应信息', '004', 1, @Time, @Time, 1, 1

select @WizardMasterStepId = SCOPE_IDENTITY()
select @WizardMasterStepElementId = 0
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
select @WizardMasterStepElementId, 'SupplierInfo', N'供应商/采买信息', 5, 1, 0, N'供应商/采买信息', '', '', null, 1, @Time, @Time, 1, 1



end

--------------------Step 5------------------------------------------
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
select @WizardMasterId, '5', N'商品差异', '005', 1, @Time, @Time, 1, 1

select @WizardMasterStepId = SCOPE_IDENTITY()
select @WizardMasterStepElementId = 0

--Prompt Element 1
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
select @WizardMasterStepElementId, N'此栏仅用于同一件商品 因为尺码，颜色，包装等等不同而产生不同商品条码。销售标签会显示在用户选取商品处，请谨慎填写。', 1, @Time, @Time, 1, 1

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
select @WizardMasterStepElementId, 'RelatedUPCInfo', N'商品差异表', 6, 1, 0, N'商品差异表', '', '', null, 1, @Time, @Time, 1, 1



end

select * from WizardMaster order by Id desc

select * from WizardMasterStep order by Id desc

select* from WizardMasterStepElement order by Id desc

select* from WizardMasterStepElementInput ORDER BY Id desc

select * from WizardMasterStepElementPrompt order by Id desc


--commit
--rollback