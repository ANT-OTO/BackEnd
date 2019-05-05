IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Category_Update]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Category_Update] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Category_Update] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Category_Update] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Category_Update] 
	@pParentCategoryId int,
	@pName nvarchar(256),
	@pAvailable bit,
	@pCompanyId int,
	@pCategoryId int output,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON

	declare @pTime datetime = getutcdate()
	
    
	if(@pCategoryId > 0)
	begin
		declare @pLevel int = 0
		select @pLevel = a.[Level] + 1
		from Category a (nolock)
			left join CompanyCategory b (nolock) on a.Id = b.CategoryId
		where a.ParentCategoryId = @pParentCategoryId
		and (a.SystemCategory = 1 or (b.CompanyId = @pCompanyId and b.Available = 1))
		and a.Available = 1

		if(@pLevel > 0)
		begin
			update a
			set a.[Level] = @pLevel,
				a.ParentCategoryId = @pParentCategoryId,
				a.Name = @pName,
				a.Available = @pAvailable,
				a.LastUpdate = @pTime,
				a.LastUpdateBy = @pLastUpdateBy,
				a.LastUpdateByType = @pLastUpdateByType
			from Category a 
				inner join CompanyCategory b (nolock) on a.Id = b.CategoryId
			where a.Id = @pCategoryId
			and b.CompanyId = @pCompanyId
			
			if(@@ROWCOUNT = 0)
			begin
				select @pCategoryId = 0
			end
		end
		else
		begin
			select @pCategoryId = 0
		end
	end
	else
	begin
		select @pLevel = 1
		select @pLevel = a.[Level] + 1
		from Category a (nolock)
			left join CompanyCategory b (nolock) on a.Id = b.CategoryId
		where a.ParentCategoryId = @pParentCategoryId
		and (a.SystemCategory = 1 or (b.CompanyId = @pCompanyId and b.Available = 1))
		and a.Available = 1
		insert into [dbo].[Category]
		(
			[ParentCategoryId],
			[Level],
			[Name],
			[OrderCode],
			[Available],
			[SystemCategory],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	@pParentCategoryId as [ParentCategoryId],
				@pLevel as [Level],
				@pName as [Name],
				'' as [OrderCode],
				@pAvailable as [Available],
				0 as [SystemCategory],
				@pTime as [CreateDate],
				@pTime as [LastUpdate],
				@pLastUpdateBy as [LastUpdateBy],
				@pLastUpdateByType as [LastUpdateByType]

		if(@@ROWCOUNT > 0)
		begin
			select @pCategoryId = SCOPE_IDENTITY()
			insert into [dbo].[CompanyCategory]
			(
				[CategoryId],
				[CompanyId],
				[Available],
				[CreateDate],
				[LastUpdate],
				[LastUpdateBy],
				[LastUpdateByType]
			)
			select	@pCategoryId as [CategoryId],
					@pCompanyId as [CompanyId],
					@pAvailable as [Available],
					@pTime as [CreateDate],
					@pTime as [LastUpdate],
					@pLastUpdateBy as [LastUpdateBy],
					@pLastUpdateByType as [LastUpdateByType]
		end
	end
	

return

/*

*/



GO


