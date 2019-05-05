IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Item_Delete]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Item_Delete] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Item_Delete] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Item_Delete] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Item_Delete] 
	@pCompanyId int,
	@pItemId int,
	@pError nvarchar(256) output,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	if(not exists(
		select * from CompanyItem a (nolock)
			inner join Item b (nolock) on b.Id = a.ItemId
		where b.Id = @pItemId
		and a.CompanyId = @pCompanyId
		and a.Available = 1
		and b.ItemStatusCodeId in (1,3)
	))
	begin
		select @pError = 'Access Denied.'
		return
	end

	update a
	set a.ItemStatusCodeId = 2,
		a.LastUpdate = @pTime
	from Item a (nolock)
	where a.Id = @pItemId


return

/*

*/



GO


