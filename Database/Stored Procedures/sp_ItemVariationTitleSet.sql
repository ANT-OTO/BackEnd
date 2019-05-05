IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemVariationTitleSet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemVariationTitleSet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemVariationTitleSet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemVariationTitleSet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemVariationTitleSet] 
	@pItemId int,
	@pWizardSessionId int,
	@pVariationTitle nvarchar(256),
	@pVariationReasonCodeId int,
	@pLastUpdateBy int,
	@pLastUpdateByType int,
	@pItemPropertyId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	if(isnull(@pItemId, 0) = 0)
	begin
		select @pItemId = b.Id
		from WizardSession a (nolock)
			inner join Item b (nolock) on a.SourceId = b.Id and a.SourceTable = 'Item'
		where a.Id = @pWizardSessionId
	end
	insert into [dbo].[ItemProperty]
	(
		[ItemId],
		[PropertyName],
		[PropertyValue],
		[CreateDate],
		[LastUpdate]
	)
	select a.ItemId, a.PropertyName, a.PropertyValue, a.CreateDate, a.LastUpdate
	from (
		select	@pItemId as [ItemId],
				'VariationTitle' as [PropertyName],
				@pVariationTitle as [PropertyValue],
				@pTime as [CreateDate],
				@pTime as [LastUpdate]
		Union
		select	@pItemId as [ItemId],
				'VariationReasonCodeId' as [PropertyName],
				convert(nvarchar(64), @pVariationReasonCodeId) as [PropertyValue],
				@pTime as [CreateDate],
				@pTime as [LastUpdate]
	) a
	left join dbo.ItemProperty z (nolock) on a.ItemId = z.ItemId and a.PropertyName = z.PropertyName
	where z.Id is null

	select @pItemPropertyId = a.Id
	from ItemProperty a (nolock)
	where a.ItemId = @pItemId
	and a.PropertyName = 'VariationTitle'
	update a
	set a.PropertyValue = @pVariationTitle,
		a.LastUpdate = @pLastUpdateBy
	from ItemProperty a
	where a.Id = @pItemPropertyId

	select @pItemPropertyId = a.Id
	from ItemProperty a (nolock)
	where a.ItemId = @pItemId
	and a.PropertyName = 'VariationReasonCodeId'
	update a
	set a.PropertyValue = convert(nvarchar(64), @pVariationReasonCodeId),
		a.LastUpdate = @pLastUpdateBy
	from ItemProperty a
	where a.Id = @pItemPropertyId

	update a
	set a.PropertyValue = convert(nvarchar(64), @pVariationReasonCodeId),
		a.LastUpdate = @pLastUpdateBy
	from ItemProperty a
		inner join Item b (nolock) on a.ItemId = b.Id
		inner join Item c (nolock) on b.SKU = c.SKU and b.Id <> c.Id
		inner join ItemProperty d (nolock) on c.Id = d.ItemId 
	where d.Id = @pItemPropertyId
	and c.SKU <> ''
	and a.PropertyName = 'VariationReasonCodeId'


return

/*

*/



GO


