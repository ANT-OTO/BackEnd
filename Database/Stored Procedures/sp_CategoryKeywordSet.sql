IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CategoryKeywordSet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CategoryKeywordSet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CategoryKeywordSet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CategoryKeywordSet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CategoryKeywordSet] 
	@pCategoryId int,
	@pKeyword nvarchar(128),
	@pAvailable bit,
	@pCategoryKeywordId int output
AS

SET NOCOUNT ON

declare @Time datetime = getutcdate()

if(exists(
	select * from CategoryKeyword a (nolock)
	where a.CategoryId = @pCategoryId
	and a.Keyword = @pKeyword
))
begin
	update a
	set a.Available = @pAvailable
	from CategoryKeyword a 
	where a.CategoryId = @pCategoryId
	and a.Keyword = @pKeyword

	select @pCategoryKeywordId = a.Id
	from CategoryKeyword a (nolock)
	where a.CategoryId = @pCategoryId
	and a.Keyword = @pKeyword
end
else
begin
	insert into [dbo].[CategoryKeyword]
	(
		[CategoryId],
		[Keyword],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select @pCategoryId, @pKeyword, @pAvailable, @Time, @Time, 1, 1

	select @pCategoryKeywordId = SCOPE_IDENTITY()
end





return

/*

*/



GO


