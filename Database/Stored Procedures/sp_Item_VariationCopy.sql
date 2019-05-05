IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Item_VariationCopy]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Item_VariationCopy] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Item_VariationCopy] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Item_VariationCopy] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Item_VariationCopy] 
	@pWizardSessionId int,
	@pItemId int,
	@pVariationReasonCodeId int, --Size, Color, Size&Color
	@pVariationTitle nvarchar(256),
	@pCopiedItemId int output,
	@pCopiedWizardSessionId int output,
	@pUserId int
AS

SET NOCOUNT ON
	declare @Time datetime = getutcdate()
	declare @pCategoryId int = 0
	declare @pBrandId int = 0
	if(@pWizardSessionId is not null)
	begin
		select @pItemId = b.Id
		from WizardSession a (nolock)
			inner join Item b (nolock) on a.SourceTable = 'Item' and a.SourceId = b.Id
		where a.Id = @pWizardSessionId
	end

	select	@pCategoryId = b.Id,
			@pBrandId = c.Id
	from ANTOTO.dbo.Item a (nolock)
		inner join ItemCategory b (nolock) on a.Id = b.ItemId and b.Available = 1
		inner join ItemBrand c (nolock) on a.Id = c.ItemId and c.Available = 1
	where a.Id = @pItemId

	insert into [dbo].[Item]
	(
		[Name],
		[Description],
		[SKU],
		[ProductCode], --UPC, EAN
		[ItemStatusCodeId], --select * from CodeList where Category = 'ItemStatus'
		[CreateDate],
		[LastUpdate]
	)
	select	a.Name as [Name],
			a.Description as [Description],
			a.SKU as [SKU],
			'' as [ProductCode], --UPC, EAN
			1 as [ItemStatusCodeId], --select * from CodeList where Category = 'ItemStatus'
			@Time as [CreateDate],
			@Time as [LastUpdate]
	from Item a (nolock)
	where a.Id = @pItemId
	select @pCopiedItemId = SCOPE_IDENTITY()
	declare @pSKU nvarchar(256) = ''
	select @pSKU = a.SKU
	from Item a (nolock)
	where a.Id = @pItemId

	insert into [dbo].[ItemCategory]
	(
		[CategoryId],
		[ItemId],
		[Available],
		[CreateDate],
		[LastUpdate]
	)
	select @pCategoryId, @pCopiedItemId, 1, @Time, @Time
			
	insert into [dbo].[ItemBrand]
	(
		[BrandId],
		[ItemId],
		[Available],
		[CreateDate],
		[LastUpdate]
	)
	select @pBrandId, @pCopiedItemId, 1, @Time, @Time

	insert into CompanyItem
	(
		CompanyId,
		ItemId,
		Available,
		CreateDate,
		LastUpdate,
		LastUpdateBy,
		LastUpdateByType
	)
	select a.CompanyId, @pCopiedItemId, 1, @Time, @Time, @pUserId, 1
	from CompanyItem a (nolock)
	where a.ItemId = @pItemId
	and a.Available = 1

	insert into [dbo].[WizardSession]
	(
		[SourceId],
		[SourceTable], --item
		[WizardMasterId],
		[CurrentStepCode],
		[Finished],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	@pCopiedItemId as [SourceId],
			a.SourceTable as [SourceTable], --item
			a.WizardMasterId as [WizardMasterId],
			a.CurrentStepCode as [CurrentStepCode],
			0 as [Finished],
			@Time as [CreateDate],
			@Time as [LastUpdate],
			@pUserId as [LastUpdateBy],
			1 as [LastUpdateByType]
	from WizardSession a (nolock)
	where a.Id = @pWizardSessionId
	select @pCopiedWizardSessionId = SCOPE_IDENTITY()


	declare @WizardMasterStepElementInputTable Table
	(
		WizardMasterStepElementInputId int
	)

	insert into @WizardMasterStepElementInputTable
	( WizardMasterStepElementInputId )
	select e.Id
	from WizardSession a (nolock)
		inner join WizardMaster b (nolock) on a.WizardMasterId = b.Id
		inner join WizardMasterStep c (nolock) on b.Id = c.WizardMasterId and c.Available = 1
		inner join WizardMasterStepElement d (nolock) on c.Id = d.WizardMasterStepId and d.Available = 1 and d.WizardMasterStepElementTypeCodeId = 2
		inner join WizardMasterStepElementInput e (nolock) on d.Id = e.WizardMasterStepElementId and e.Available = 1
	where a.Id = @pWizardSessionId
	and e.InputName not in ('ProductCode')

	insert into WizardSessionInputs
	(
		[WizardSessionId],
		[StepCode],
		[WizardMasterStepElementInputId],
		[InputOrder], -- 0 --> 99
		[StepValue], --string input
		[StepIntValue], --list input
		[StepSourceId], --File or other
		[StepSourceTable], --File or other
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	@pCopiedWizardSessionId, b.StepCode, b.WizardMasterStepElementInputId, b.InputOrder,
			b.StepValue, b.StepIntValue, b.StepSourceId, b.StepSourceTable,
			@Time, @Time, @pUserId, 1
	from WizardSession a (nolock)
		inner join WizardSessionInputs b (nolock) on a.Id = b.WizardSessionId
	where a.Id = @pWizardSessionId
	and b.WizardMasterStepElementInputId in (select WizardMasterStepElementInputId from @WizardMasterStepElementInputTable)

	insert into ItemProperty
	(
		ItemId, PropertyName, PropertyValue, CreateDate, LastUpdate
	)
	select @pCopiedItemId, a.PropertyName, a.PropertyValue, @Time, @Time
	from ItemProperty a (nolock)
	where a.ItemId = @pItemId
	and a.PropertyName <> 'VariationTitle'

	insert into ItemResource
	(
		ItemId, Available, Description_1, Description_2, FileId,
		MainResource, ResourceTypeCodeId, CreateDate, LastUpdate
	)
	select	@pCopiedItemId, a.Available, a.Description_1, a.Description_2, a.FileId,
			a.MainResource, a.ResourceTypeCodeId, @Time, @Time
	from ItemResource a (nolock)
	where a.ItemId = @pItemId

	insert into ItemProperty
	(
		ItemId, PropertyName, PropertyValue, CreateDate, LastUpdate
	)
	select @pCopiedItemId, 'VariationTitle', @pVariationTitle, @Time, @Time
return

/*

*/



GO


