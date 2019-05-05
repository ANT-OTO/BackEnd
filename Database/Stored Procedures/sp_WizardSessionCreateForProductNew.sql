IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_WizardSessionCreateForProductNew]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_WizardSessionCreateForProductNew] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_WizardSessionCreateForProductNew] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_WizardSessionCreateForProductNew] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_WizardSessionCreateForProductNew] 
	@pWizardSessionId int output,
	@pCategoryId int,
	@pBrandId int,
	@pUserId int,
	@pCompanyId int
AS

SET NOCOUNT ON

declare @Time datetime = getutcdate()

declare @pItemId int = 0
declare @pWizardMasterId int = 0
declare @pWizardTemplateId int = 0

select @pWizardTemplateId = a.Id
from WizardTemplate a (nolock)
	inner join WizardTemplateItem b (nolock) on a.SourceId = b.Id and a.SourceTable = 'WizardTemplateItem'
where b.CategoryId = @pCategoryId
and b.BrandId = @pBrandId

if(@pWizardTemplateId = 0)
begin
	select @pWizardTemplateId = a.Id
	from WizardTemplate a (nolock)
		inner join WizardTemplateItem b (nolock) on a.SourceId = b.Id and a.SourceTable = 'WizardTemplateItem'
	where b.CategoryId = 0
	and b.BrandId = 0 
end

select @pWizardMasterId = a.Id
from WizardMaster a (nolock)
where a.WizardTemplateId = @pWizardTemplateId
and a.Available = 1



declare @pDraftName nvarchar(256) = replace(newId(),'-','')
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
select	@pDraftName as [Name],
		'' as [Description],
		'' as [SKU],
		'' as [ProductCode], --UPC, EAN
		1 as [ItemStatusCodeId], --select * from CodeList where Category = 'ItemStatus'
		@Time as [CreateDate],
		@Time as [LastUpdate]
select @pItemId = SCOPE_IDENTITY()

insert into ItemProperty
(
	ItemId, PropertyName, PropertyValue, CreateDate, LastUpdate
)
select @pItemId, 'ItemOrderId', convert(nvarchar(256), @pItemId), @Time, @Time

insert into [dbo].[ItemCategory]
(
	[CategoryId],
	[ItemId],
	[Available],
	[CreateDate],
	[LastUpdate]
)
select @pCategoryId, @pItemId, 1, @Time, @Time

insert into [dbo].[ItemBrand]
(
	[BrandId],
	[ItemId],
	[Available],
	[CreateDate],
	[LastUpdate]
)
select @pBrandId, @pItemId, 1, @Time, @Time


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
select @pCompanyId, @pItemId, 1, @Time, @Time, @pUserId, 1


declare @pCurrentStepCode nvarchar(64) = ''
select top 1 @pCurrentStepCode = b.StepCode
from WizardMaster a (nolock)
	inner join WizardMasterStep b (nolock) on a.Id = b.WizardMasterId and b.Available = 1
where a.Id = @pWizardMasterId
order by b.[Order]

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
select	@pItemId as [SourceId],
		'Item' as [SourceTable], --item
		@pWizardMasterId as [WizardMasterId],
		@pCurrentStepCode as [CurrentStepCode],
		0 as [Finished],
		@Time as [CreateDate],
		@Time as [LastUpdate],
		@pUserId as [LastUpdateBy],
		1 as [LastUpdateByType]
select @pWizardSessionId = SCOPE_IDENTITY()





return

/*

*/



GO


