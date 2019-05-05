IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Brand_Update]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Brand_Update] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Brand_Update] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Brand_Update] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Brand_Update] 
	@pName nvarchar(256),
	@pDescription nvarchar(512),
	@pCategoryDescription nvarchar(512),
	@pCompanyId int,
	@pAvailable bit,
	@pBrandId int output,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON

	declare @pTime datetime = getutcdate()
	
    
	if(@pBrandId > 0)
	begin
		update a
		set a.BrandName = @pName,
			a.BrandDescription = @pDescription,
			a.BrandCategoryDescription = @pCategoryDescription,
			a.Available = @pAvailable,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = @pLastUpdateBy,
			a.LastUpdateByType = @pLastUpdateByType
		from Brand a
			inner join CompanyBrand b (nolock) on a.Id = b.BrandId
		where b.CompanyId = @pCompanyId
		and a.Id = @pBrandId
		and b.Available = 1

		if(@@ROWCOUNT > 0)
		begin
			select @pBrandId = @pBrandId
		end
	end
	else
	begin
		insert into [dbo].[Brand]
		(
			[ParentBrandId],
			[BrandName],
			[BrandDescription],
			[BrandCategoryDescription],
			[SystemBrand],
			[Available],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	0 as [ParentBrandId],
				@pName as [BrandName],
				@pDescription as [BrandDescription],
				@pCategoryDescription as [BrandCategoryDescription],
				0 as [SystemBrand],
				@pAvailable as [Available],
				@pTime as [CreateDate],
				@pTime as [LastUpdate],
				@pLastUpdateBy as [LastUpdateBy],
				@pLastUpdateByType as [LastUpdateByType]

		if(@@ROWCOUNT > 0)
		begin
			select @pBrandId = SCOPE_IDENTITY()
			insert into [dbo].[CompanyBrand]
			(
				[BrandId],
				[CompanyId],
				[Available],
				[CreateDate],
				[LastUpdate],
				[LastUpdateBy],
				[LastUpdateByType]
			)
			select	@pBrandId as [BrandId],
					@pCompanyId as [CompanyId],
					@pAvailable as [Available], 
					@pTime as [CreateDate],
					@pTime as [LastUpdate],
					@pLastUpdateBy as [LastUpdateBy],
					@pLastUpdateByType as [LastUpdateByType]
			if(@@ROWCOUNT > 0)
			begin
				select @pBrandId = @pBrandId
			end
			else 
			begin
				select @pBrandId = 0
			end
		end
	end

	

return

/*

*/



GO


