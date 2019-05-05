IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemPackageApprove]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemPackageApprove] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemPackageApprove] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemPackageApprove] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemPackageApprove] 
	@pItemSubmitPackageId int,
	@pCategoryId int,
	@pBrandId int,
	@pCompanyId int,
	@pUserId int,
	@pItemUpdatePackageId int,
	@pItemId int output,
	@pWizardSessionId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	declare @pUPC nvarchar(256),
		@pPrice nvarchar(256),
		@pCurrencyId int,
		@pProductName nvarchar(max),
		@pWeight nvarchar(256),
		@pSaleTitle nvarchar(max),
		@pSalePlace nvarchar(256),
		@pDiscountDescription nvarchar(max),
		@pSizeRange nvarchar(max),
		@pColorRange nvarchar(max),
		@pItemPackageStatusCodeId int

	if(isnull(@pItemSubmitPackageId, 0) > 0)
	begin
		--create product
		select	@pUPC = a.UPC,
				@pPrice = a.Price,
				@pCurrencyId = a.CurrencyId,
				@pProductName = a.ProductName,
				@pWeight = a.Weight,
				@pSaleTitle = a.SaleTitle,
				@pSalePlace = a.SalePlace,
				@pDiscountDescription = a.DiscountDescription,
				@pSizeRange = a.SizeRange,
				@pColorRange = a.ColorRange,
				@pItemPackageStatusCodeId = a.ItemPackageStatusCodeId
		from ItemSubmitPackage a (nolock)
		where a.Id = @pItemSubmitPackageId

		if(not exists(
			select * from Item a (nolock)
				inner join CompanyItem b (nolock) on a.Id = b.ItemId
			where a.ProductCode = @pUPC
			and b.CompanyId = @pCompanyId
			and b.Available = 1
		) and len(@pUPC) > 0)
		begin
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
			select	@pProductName as [Name],
					@pProductName as [Description],
					'' as [SKU],
					@pUPC as [ProductCode], --UPC, EAN
					1 as [ItemStatusCodeId], --select * from CodeList where Category = 'ItemStatus'
					@pTime as [CreateDate],
					@pTime as [LastUpdate]

			select @pItemId = SCOPE_IDENTITY()

			insert into [dbo].[ItemCategory]
			(
				[CategoryId],
				[ItemId],
				[Available],
				[CreateDate],
				[LastUpdate]
			)
			select @pCategoryId, @pItemId, 1, @pTime, @pTime
			
			insert into [dbo].[ItemBrand]
			(
				[BrandId],
				[ItemId],
				[Available],
				[CreateDate],
				[LastUpdate]
			)
			select @pBrandId, @pItemId, 1, @pTime, @pTime

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
			select @pCompanyId, @pItemId, 1, @pTime, @pTime, @pUserId, 1

			update a
			set a.ItemId = @pItemId,
				a.ItemPackageStatusCodeId = 96--select * from CodeList where Category = 'ItemPackageStatus'
			from ItemSubmitPackage a
			where a.Id = @pItemSubmitPackageId
			--WizardSession Related
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
					'1' as [CurrentStepCode],
					0 as [Finished],
					@pTime as [CreateDate],
					@pTime as [LastUpdate],
					@pUserId as [LastUpdateBy],
					1 as [LastUpdateByType]
			select @pWizardSessionId = SCOPE_IDENTITY()
			declare @pWizardSessionStepCode nvarchar(64) = ''
			declare @pWizardMasterStepElementInputId int = 0
			--Product Name

			select @pWizardMasterStepElementInputId = e.Id,
					@pWizardSessionStepCode = c.StepCode
			from WizardSession a (nolock)
				inner join WizardMaster b (nolock) on a.WizardMasterId = b.Id
				inner join WizardMasterStep c (nolock) on b.Id = c.WizardMasterId and c.Available = 1
				inner join WizardMasterStepElement d (nolock) on c.Id = d.WizardMasterStepId and d.Available = 1 and d.WizardMasterStepElementTypeCodeId = 2
				inner join WizardMasterStepElementInput e (nolock) on d.Id = e.WizardMasterStepElementId and e.Available = 1
			where a.Id = @pWizardSessionId
			and e.InputName in ('ProductName')

			exec [sp_WizardSessionInput_Set] 
				@pWizardSessionId,
				@pWizardSessionStepCode,
				@pWizardMasterStepElementInputId,
				1,
				@pProductName,
				null, --list input
				null, --File or other
				null --File or other

			--Product Description

			select @pWizardMasterStepElementInputId = e.Id,
					@pWizardSessionStepCode = c.StepCode
			from WizardSession a (nolock)
				inner join WizardMaster b (nolock) on a.WizardMasterId = b.Id
				inner join WizardMasterStep c (nolock) on b.Id = c.WizardMasterId and c.Available = 1
				inner join WizardMasterStepElement d (nolock) on c.Id = d.WizardMasterStepId and d.Available = 1 and d.WizardMasterStepElementTypeCodeId = 2
				inner join WizardMasterStepElementInput e (nolock) on d.Id = e.WizardMasterStepElementId and e.Available = 1
			where a.Id = @pWizardSessionId
			and e.InputName in ('ProductDesc')

			exec [sp_WizardSessionInput_Set] 
				@pWizardSessionId,
				@pWizardSessionStepCode,
				@pWizardMasterStepElementInputId,
				1,
				@pSaleTitle,
				null, --list input
				null, --File or other
				null --File or other

			--Product Code

			select @pWizardMasterStepElementInputId = e.Id,
					@pWizardSessionStepCode = c.StepCode
			from WizardSession a (nolock)
				inner join WizardMaster b (nolock) on a.WizardMasterId = b.Id
				inner join WizardMasterStep c (nolock) on b.Id = c.WizardMasterId and c.Available = 1
				inner join WizardMasterStepElement d (nolock) on c.Id = d.WizardMasterStepId and d.Available = 1 and d.WizardMasterStepElementTypeCodeId = 2
				inner join WizardMasterStepElementInput e (nolock) on d.Id = e.WizardMasterStepElementId and e.Available = 1
			where a.Id = @pWizardSessionId
			and e.InputName in ('ProductCode')

			exec [sp_WizardSessionInput_Set] 
				@pWizardSessionId,
				@pWizardSessionStepCode,
				@pWizardMasterStepElementInputId,
				1,
				@pUPC,
				null, --list input
				null, --File or other
				null --File or other

			exec [sp_WizardSessionInput_Set] 
				@pWizardSessionId,
				@pWizardSessionStepCode,
				@pWizardMasterStepElementInputId,
				2,
				1,
				null, --list input
				null, --File or other
				null --File or other
			update a
			set a.ItemId = @pItemId,
				a.ItemPackageStatusCodeId = 96--select * from CodeList where Category = 'ItemPackageStatus'
			from ItemSubmitPackage a
			where a.Id = @pItemSubmitPackageId
			--Images

			select @pWizardMasterStepElementInputId = e.Id,
					@pWizardSessionStepCode = c.StepCode
			from WizardSession a (nolock)
				inner join WizardMaster b (nolock) on a.WizardMasterId = b.Id
				inner join WizardMasterStep c (nolock) on b.Id = c.WizardMasterId and c.Available = 1
				inner join WizardMasterStepElement d (nolock) on c.Id = d.WizardMasterStepId and d.Available = 1 and d.WizardMasterStepElementTypeCodeId = 2
				inner join WizardMasterStepElementInput e (nolock) on d.Id = e.WizardMasterStepElementId and e.Available = 1
			where a.Id = @pWizardSessionId
			and e.InputName in ('OtherImage')
			declare @pOrder int = 1
			declare @pFileId int = 0
			DECLARE db_cursor CURSOR FOR 
			SELECT a.FileId
			from ItemPackageResouce a (nolock)
			where a.SourceId = @pItemSubmitPackageId
			and a.SourceTable = 'ItemSubmitPackage'
			and a.Available = 1

			OPEN db_cursor  
			FETCH NEXT FROM db_cursor INTO @pFileId  

			WHILE @@FETCH_STATUS = 0  
			BEGIN  
				  exec [dbo].[sp_WizardSessionInput_Set] 
						@pWizardSessionId,
						@pWizardSessionStepCode,
						@pWizardMasterStepElementInputId,
						@pOrder,
						null,
						null, --list input
						@pFileId, --File or other
						'File' --File or other
					select @pOrder = @pOrder + 1

				  FETCH NEXT FROM db_cursor INTO @pFileId 
			END 

			CLOSE db_cursor  
			DEALLOCATE db_cursor 

			--Supplier Info
			declare @pSupplierPlaceInfoId int = 0
			exec [dbo].[sp_SupplierPlaceInfoSet] 
				@pSalePlace,
				@pSalePlace,
				@pPrice,
				@pCurrencyId,
				@pDiscountDescription,
				@pUserId,
				@pSupplierPlaceInfoId output

			if(@pSupplierPlaceInfoId > 0)
			begin
				select @pWizardMasterStepElementInputId = e.Id,
					@pWizardSessionStepCode = c.StepCode
				from WizardSession a (nolock)
					inner join WizardMaster b (nolock) on a.WizardMasterId = b.Id
					inner join WizardMasterStep c (nolock) on b.Id = c.WizardMasterId and c.Available = 1
					inner join WizardMasterStepElement d (nolock) on c.Id = d.WizardMasterStepId and d.Available = 1 and d.WizardMasterStepElementTypeCodeId = 2
					inner join WizardMasterStepElementInput e (nolock) on d.Id = e.WizardMasterStepElementId and e.Available = 1
				where a.Id = @pWizardSessionId
				and e.InputName in ('SupplierInfo')

				exec [dbo].[sp_WizardSessionInput_Set] 
						@pWizardSessionId,
						@pWizardSessionStepCode,
						@pWizardMasterStepElementInputId,
						@pOrder,
						null,
						null, --list input
						@pSupplierPlaceInfoId, --File or other
						'SupplierPlaceInfo' --File or other
			end
			
		end
		else
		begin
			if(len(@pUPC) = 0)
			begin
				return
			end
			--update
			select	@pItemId = b.Id,
					@pWizardSessionId = a.Id
			from WizardSession a (nolock)
				inner join Item b (nolock) on b.Id = a.SourceId and a.SourceTable = 'Item'
				inner join CompanyItem c (nolock) on b.Id = c.ItemId
			where c.CompanyId = @pCompanyId
			and b.ProductCode = @pUPC

			
			update a
			set a.ItemId = @pItemId,
				a.ItemPackageStatusCodeId = 96--select * from CodeList where Category = 'ItemPackageStatus'
			from ItemSubmitPackage a
			where a.Id = @pItemSubmitPackageId

			--Images

			select @pWizardMasterStepElementInputId = e.Id,
					@pWizardSessionStepCode = c.StepCode
			from WizardSession a (nolock)
				inner join WizardMaster b (nolock) on a.WizardMasterId = b.Id
				inner join WizardMasterStep c (nolock) on b.Id = c.WizardMasterId and c.Available = 1
				inner join WizardMasterStepElement d (nolock) on c.Id = d.WizardMasterStepId and d.Available = 1 and d.WizardMasterStepElementTypeCodeId = 2
				inner join WizardMasterStepElementInput e (nolock) on d.Id = e.WizardMasterStepElementId and e.Available = 1
			where a.Id = @pWizardSessionId
			and e.InputName in ('OtherImage')
			select @pOrder = 1
			select @pFileId = 0
			DECLARE db_cursor CURSOR FOR 
			SELECT a.FileId
			from ItemPackageResouce a (nolock)
			where a.SourceId = @pItemUpdatePackageId
			and a.SourceTable = 'ItemUpdatePackage'
			and a.Available = 1

			OPEN db_cursor  
			FETCH NEXT FROM db_cursor INTO @pFileId  

			WHILE @@FETCH_STATUS = 0  
			BEGIN  
				  exec [dbo].[sp_WizardSessionInput_Set] 
						@pWizardSessionId,
						@pWizardSessionStepCode,
						@pWizardMasterStepElementInputId,
						@pOrder,
						null,
						null, --list input
						@pFileId, --File or other
						'File' --File or other
					select @pOrder = @pOrder + 1

				  FETCH NEXT FROM db_cursor INTO @pFileId 
			END 

			CLOSE db_cursor  
			DEALLOCATE db_cursor 

			--Supplier Info
			select @pSupplierPlaceInfoId = 0
			exec [dbo].[sp_SupplierPlaceInfoSet] 
				@pSalePlace,
				@pSalePlace,
				@pPrice,
				@pCurrencyId,
				@pDiscountDescription,
				@pUserId,
				@pSupplierPlaceInfoId output

			if(@pSupplierPlaceInfoId > 0)
			begin
				select @pWizardMasterStepElementInputId = e.Id,
					@pWizardSessionStepCode = c.StepCode
				from WizardSession a (nolock)
					inner join WizardMaster b (nolock) on a.WizardMasterId = b.Id
					inner join WizardMasterStep c (nolock) on b.Id = c.WizardMasterId and c.Available = 1
					inner join WizardMasterStepElement d (nolock) on c.Id = d.WizardMasterStepId and d.Available = 1 and d.WizardMasterStepElementTypeCodeId = 2
					inner join WizardMasterStepElementInput e (nolock) on d.Id = e.WizardMasterStepElementId and e.Available = 1
				where a.Id = @pWizardSessionId
				and e.InputName in ('SupplierInfo')

				exec [dbo].[sp_WizardSessionInput_Set] 
						@pWizardSessionId,
						@pWizardSessionStepCode,
						@pWizardMasterStepElementInputId,
						@pOrder,
						null,
						null, --list input
						@pSupplierPlaceInfoId, --File or other
						'SupplierPlaceInfo' --File or other
			end
		end
	end
	else if (isnull(@pItemUpdatePackageId, 0) > 0)
	begin
		select	@pItemId = a.ItemId,
				@pWizardSessionId = d.Id
		from ItemUpdatePackage a (nolock)
			inner join Item b (nolock) on a.ItemId = b.Id
			inner join CompanyItem c (nolock) on b.Id = c.ItemId
			inner join WizardSession d (nolock) on d.SourceId = b.Id and d.SourceTable = 'Item'
		where c.CompanyId = @pCompanyId
		and a.Id = @pItemUpdatePackageId
		update a
		set a.ItemPackageStatusCodeId = 96--select * from CodeList where Category = 'ItemPackageStatus'
		from ItemUpdatePackage a
		where a.Id = @pItemUpdatePackageId
		--Images

		select @pWizardMasterStepElementInputId = e.Id,
				@pWizardSessionStepCode = c.StepCode
		from WizardSession a (nolock)
			inner join WizardMaster b (nolock) on a.WizardMasterId = b.Id
			inner join WizardMasterStep c (nolock) on b.Id = c.WizardMasterId and c.Available = 1
			inner join WizardMasterStepElement d (nolock) on c.Id = d.WizardMasterStepId and d.Available = 1 and d.WizardMasterStepElementTypeCodeId = 2
			inner join WizardMasterStepElementInput e (nolock) on d.Id = e.WizardMasterStepElementId and e.Available = 1
		where a.Id = @pWizardSessionId
		and e.InputName in ('OtherImage')
		select @pOrder = 1
		select @pFileId = 0
		DECLARE db_cursor CURSOR FOR 
		SELECT a.FileId
		from ItemPackageResouce a (nolock)
		where a.SourceId = @pItemUpdatePackageId
		and a.SourceTable = 'ItemUpdatePackage'
		and a.Available = 1

		OPEN db_cursor  
		FETCH NEXT FROM db_cursor INTO @pFileId  

		WHILE @@FETCH_STATUS = 0  
		BEGIN  
				exec [dbo].[sp_WizardSessionInput_Set] 
					@pWizardSessionId,
					@pWizardSessionStepCode,
					@pWizardMasterStepElementInputId,
					@pOrder,
					null,
					null, --list input
					@pFileId, --File or other
					'File' --File or other
				select @pOrder = @pOrder + 1

				FETCH NEXT FROM db_cursor INTO @pFileId 
		END 

		CLOSE db_cursor  
		DEALLOCATE db_cursor 

		--Supplier Info
		select @pSupplierPlaceInfoId = 0
		exec [dbo].[sp_SupplierPlaceInfoSet] 
			@pSalePlace,
			@pSalePlace,
			@pPrice,
			@pCurrencyId,
			@pDiscountDescription,
			@pUserId,
			@pSupplierPlaceInfoId output

		if(@pSupplierPlaceInfoId > 0)
		begin
			select @pWizardMasterStepElementInputId = e.Id,
				@pWizardSessionStepCode = c.StepCode
			from WizardSession a (nolock)
				inner join WizardMaster b (nolock) on a.WizardMasterId = b.Id
				inner join WizardMasterStep c (nolock) on b.Id = c.WizardMasterId and c.Available = 1
				inner join WizardMasterStepElement d (nolock) on c.Id = d.WizardMasterStepId and d.Available = 1 and d.WizardMasterStepElementTypeCodeId = 2
				inner join WizardMasterStepElementInput e (nolock) on d.Id = e.WizardMasterStepElementId and e.Available = 1
			where a.Id = @pWizardSessionId
			and e.InputName in ('SupplierInfo')

			exec [dbo].[sp_WizardSessionInput_Set] 
					@pWizardSessionId,
					@pWizardSessionStepCode,
					@pWizardMasterStepElementInputId,
					@pOrder,
					null,
					null, --list input
					@pSupplierPlaceInfoId, --File or other
					'SupplierPlaceInfo' --File or other
		end
	end



return

/*

*/



GO


