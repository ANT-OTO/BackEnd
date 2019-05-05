IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemPropertySet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemPropertySet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemPropertySet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemPropertySet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemPropertySet] 
	@pItemId int,
	@pPropertyName nvarchar(256),
	@pPropertyValue nvarchar(256),
	@pItemPropertyId int output,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
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
				@pPropertyName as [PropertyName],
				@pPropertyValue as [PropertyValue],
				@pTime as [CreateDate],
				@pTime as [LastUpdate]
	) a
	left join dbo.ItemProperty z (nolock) on a.ItemId = z.ItemId and a.PropertyName = z.PropertyName
	where z.Id is null

	if(@@ROWCOUNT > 0)
	begin
		select @pItemPropertyId = SCOPE_IDENTITY()
	end
	else
	begin
		select @pItemPropertyId = a.Id
		from ItemProperty a (nolock)
		where a.ItemId = @pItemId
		and a.PropertyName = @pPropertyName
		update a
		set a.PropertyValue = @pPropertyValue,
			a.LastUpdate = @pLastUpdateBy
		from ItemProperty a
		where a.Id = @pItemPropertyId
	end

return

/*

*/



GO


