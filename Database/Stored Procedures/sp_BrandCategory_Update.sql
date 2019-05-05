IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_BrandCategory_Update]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_BrandCategory_Update] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_BrandCategory_Update] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_BrandCategory_Update] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_BrandCategory_Update] 
	@pBrandId int,
	@pCategoryId int,
	@pAvailable bit,
	@pLastUpdateBy int,
	@pLastUpdateByType int,
	@pCategoryBrandId int output
AS

SET NOCOUNT ON

	declare @pTime datetime = getutcdate()
	
    
	insert into [CategoryBrand]
	(
		[CategoryId],
		[BrandId],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	a.CategoryId,
			a.BrandId,
			a.Available,
			a.CreateDate,
			a.LastUpdate,
			a.LastUpdateBy,
			a.LastUpdateByType
	from 
	(

		select	@pCategoryId as [CategoryId],
				@pBrandId as [BrandId],
				@pAvailable as [Available],
				@pTime as [CreateDate],
				@pTime as [LastUpdate],
				@pLastUpdateBy as [LastUpdateBy],
				@pLastUpdateByType as [LastUpdateByType]
	) a
	left join CategoryBrand z (nolock) on a.CategoryId = z.CategoryId and a.BrandId = z.BrandId
	where z.Id is null

	if(@@ROWCOUNT > 0)
	begin
		select @pCategoryBrandId = SCOPE_IDENTITY()
	end
	else
	begin
		select @pCategoryBrandId = a.Id
		from CategoryBrand a (nolock)
		where a.CategoryId = @pCategoryId
		and a.BrandId = @pBrandId

		update a
		set a.Available = @pAvailable,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = @pLastUpdateBy,
			a.LastUpdateByType = @pLastUpdateByType
		from CategoryBrand a
		where a.Id = @pCategoryBrandId
	end

	

return

/*

*/



GO


