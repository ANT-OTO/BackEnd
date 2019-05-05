IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_WizardSessionInput_Set]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_WizardSessionInput_Set] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_WizardSessionInput_Set] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_WizardSessionInput_Set] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_WizardSessionInput_Set] 
	@pWizardSessionId int,
	@pWizardSessionStepCode nvarchar(64),
	@pWizardMasterStepElementInputId int,
	@pOrder int,
	@pStepValue nvarchar(512),
	@pStepIntValue int, --list input
	@pStepSourceId int, --File or other
	@pStepSourceTable nvarchar(64) --File or other
AS

SET NOCOUNT ON

declare @Time datetime = getutcdate()

if( not exists(
	select * from WizardSessionInputs a (nolock)
	where a.WizardSessionId = @pWizardSessionId
	and a.WizardMasterStepElementInputId = @pWizardMasterStepElementInputId
	and a.StepCode = @pWizardSessionStepCode
	and a.InputOrder = @pOrder
))
begin
	insert into [dbo].[WizardSessionInputs]
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
	select	@pWizardSessionId,
			@pWizardSessionStepCode,
			@pWizardMasterStepElementInputId,
			@pOrder,
			@pStepValue,
			@pStepIntValue,
			@pStepSourceId,
			@pStepSourceTable,
			@Time,
			@Time,
			1,
			1
	

end
else
begin
	update a
	set a.StepValue = @pStepValue,
		a.StepIntValue = @pStepIntValue,
		a.StepSourceId = @pStepSourceId,
		a.StepSourceTable = @pStepSourceTable,
		a.LastUpdate = @Time,
		a.LastUpdateBy = 1,
		a.LastUpdateByType = 1
	from [WizardSessionInputs] a
	where a.WizardSessionId = @pWizardSessionId
	and a.WizardMasterStepElementInputId = @pWizardMasterStepElementInputId
	and a.StepCode = @pWizardSessionStepCode
	and a.InputOrder = @pOrder
end

if(exists(
	select * from WizardSession a (nolock) 
	where a.SourceTable = 'Item'
	and a.Id = @pWizardSessionId
))
begin
	declare @pItemId int = 0
	select @pItemId =  a.SourceId
	from WizardSession a (nolock)
	where a.Id = @pWizardSessionId

	if(exists(
		select * from WizardMasterStepElementInput a (nolock)
		where a.Id = @pWizardMasterStepElementInputId
		and a.InputName in ('SKU')
	))
	begin
		update a
		set a.SKU = @pStepValue
		from Item a 
		where a.Id = @pItemId 
	end
	if(exists(
		select * from WizardMasterStepElementInput a (nolock)
		where a.Id = @pWizardMasterStepElementInputId
		and a.InputName in ('ProductCode')
	) and @pOrder = 1
	)
	begin
		update a
		set a.ProductCode = @pStepValue
		from Item a 
		where a.Id = @pItemId 
	end
	if(exists(
		select * from WizardMasterStepElementInput a (nolock)
		where a.Id = @pWizardMasterStepElementInputId
		and a.InputName in ('ProductName')
	))
	begin
		update a
		set a.Name = @pStepValue
		from Item a 
		where a.Id = @pItemId 
	end
	if(exists(
		select * from WizardMasterStepElementInput a (nolock)
		where a.Id = @pWizardMasterStepElementInputId
		and a.InputName in ('ProductDesc')
	))
	begin
		update a
		set a.Description = @pStepValue
		from Item a 
		where a.Id = @pItemId 
	end
	declare @pItemPropertyId int = 0
	if(exists(
		select * from WizardMasterStepElementInput a (nolock)
		where a.Id = @pWizardMasterStepElementInputId
		and a.InputName in ('ModelNumber')
	))
	begin
		exec [dbo].[sp_ItemPropertySet] 
			@pItemId,
			'ModelNumber',
			@pStepValue,
			@pItemPropertyId output,
			1,
			1
	end

	if(exists(
		select * from WizardMasterStepElementInput a (nolock)
		where a.Id = @pWizardMasterStepElementInputId
		and a.InputName in ('SupplierSKU')
	))
	begin
		exec [dbo].[sp_ItemPropertySet] 
			@pItemId,
			'SupplierSKU',
			@pStepValue,
			@pItemPropertyId output,
			1,
			1
	end


	if(exists(
		select * from WizardMasterStepElementInput a (nolock)
		where a.Id = @pWizardMasterStepElementInputId
		and a.InputName in ('MainImage')
	))
	begin
		insert into ItemResource
		(
			[ItemId],
			[ResourceTypeCodeId], --image, video
			[MainResource],
			[FileId],
			[Description_1],
			[Description_2],
			[Available],
			[CreateDate],
			[LastUpdate]
		)
		select a.*
		from (
		select	@pItemId as [ItemId],
				1 as [ResourceTypeCodeId], --image, video
				1 as [MainResource],
				@pStepSourceId as [FileId],
				'' as [Description_1],
				'' as [Description_2],
				1 as [Available],
				@Time as [CreateDate],
				@Time as [LastUpdate]
		) a
		left join ItemResource z (nolock) on a.ItemId = z.ItemId and a.MainResource = z.MainResource
		where z.Id is null

		if(@@ROWCOUNT > 0)
		begin
			update a
			set a.FileId = @pStepSourceId,
				a.LastUpdate = @Time
			from ItemResource a 
			where a.ItemId = @pItemId
			and a.MainResource = 1
		end
	end

end



return

/*

*/



GO


