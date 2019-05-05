IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Brand_Insert]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Brand_Insert] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Brand_Insert] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Brand_Insert] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Brand_Insert] 
	@pName nvarchar(256),
	@pDescription nvarchar(512),
	@pCategoryId int,
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
		set a.BrandName = isnull(@pName, a.BrandName),
			a.BrandDescription = isnull(@pDescription,a.BrandDescription),
			a.BrandCategoryDescription = '',
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
		if(exists(
			select *
			from Brand a (nolock)
				inner join CategoryBrand b (nolock) on a.Id = b.BrandId
				inner join CompanyBrand c (nolock) on a.Id = c.BrandId and c.CompanyId = @pCompanyId
			where b.CategoryId = @pCategoryId
			and b.Available = 1
			and a.Available = 1
			and c.Available = 1
			and a.BrandName = @pName
		))
		begin
			select @pBrandId = 0
			return
		end
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
				isnull(@pDescription, '') as [BrandDescription],
				'' as [BrandCategoryDescription],
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
			declare @pCategoryBrandId int = 0
			exec [dbo].[sp_BrandCategory_Update] 
			@pBrandId,
			@pCategoryId,
			1,
			@pLastUpdateBy,
			@pLastUpdateByType,
			@pCategoryBrandId output
		end
	end

	

return

/*

*/



GO


