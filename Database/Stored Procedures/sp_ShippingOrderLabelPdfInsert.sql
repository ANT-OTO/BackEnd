IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderLabelPdfInsert]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderLabelPdfInsert] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderLabelPdfInsert] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderLabelPdfInsert] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderLabelPdfInsert] 
	@pShippingOrderLabelId int,
	@pFileId int,
	@pShippingOrderLabelPdfFileId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	insert into [dbo].[ShippingOrderLabelPdfFile]
	(
		[ShippingOrderLabelId],
		[FileId],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select a.Id, @pFileId, 1, @pTime, @pTime, 1, 1
	from ShippingOrderLabel a (nolock)
	left join ShippingOrderLabelPdfFile z (nolock) on a.Id = z.ShippingOrderLabelId
	where a.Id = @pShippingOrderLabelId
	and z.Id is null

	if(@@ROWCOUNT > 0)
	begin
		select @pShippingOrderLabelPdfFileId = SCOPE_IDENTITY()
	end
	else
	begin
		update a
		set a.FileId = @pFileId,
			a.Available = 1,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = 1,
			a.LastUpdateByType = 1
		from ShippingOrderLabelPdfFile a
		where a.ShippingOrderLabelId = @pShippingOrderLabelId

		select @pShippingOrderLabelPdfFileId = a.Id
		from ShippingOrderLabelPdfFile a
		where a.ShippingOrderLabelId = @pShippingOrderLabelId
	end





return

/*

*/



GO


