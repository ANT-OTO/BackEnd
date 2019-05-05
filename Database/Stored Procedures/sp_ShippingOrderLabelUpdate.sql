IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderLabelUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderLabelUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderLabelUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderLabelUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderLabelUpdate] 
	@pShippingOrderId int,
	@pLabelNumber nvarchar(256),
	@pLabelName nvarchar(256),
	@pFileId int,
	@pOrder int,
	@pUserId int,
	@pShippingOrderLabelId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	if(exists(
		select * 
		from ShippingOrderLabel a (nolock)
		where a.LabelName = @pLabelName
		and a.ShippingOrderId = @pShippingOrderId
	))
	begin
		select @pShippingOrderLabelId = a.Id
		from ShippingOrderLabel a (nolock)
		where a.LabelName = @pLabelName
		and a.ShippingOrderId = @pShippingOrderId

		update a
		set a.LabelName = @pLabelName,
			a.LabelNumber = @pLabelNumber,
			a.FileId = @pFileId,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = @pUserId,
			a.LastUpdateByType = 1
		from ShippingOrderLabel a
		where a.LabelName = @pLabelName
		and a.ShippingOrderId = @pShippingOrderId



	end
	else
	begin
		insert into [dbo].[ShippingOrderLabel]
		(
			[ShippingOrderId],
			[LabelName],
			[LabelNumber],
			[FileId],
			[Order],
			[Available],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	@pShippingOrderId,
				@pLabelName,
				@pLabelNumber,
				@pFileId,
				@pOrder,
				1,
				@pTime,
				@pTime,
				@pUserId,
				1
		select @pShippingOrderLabelId = SCOPE_IDENTITY()
	end
return

/*

*/



GO


