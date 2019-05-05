/****** Object:  UserDefinedFunction [dbo].[sfnItemIsInCategory]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sfnItemIsInCategory]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	print 'Create function [dbo].[sfnItemIsInCategory] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[sfnItemIsInCategory] 
		(
		)
		returns  bit

		AS  
		BEGIN 
			declare @Ret_value bit
			return @Ret_value
		END
	'


	exec (@create)
END


print 'Update function [dbo].[sfnItemIsInCategory] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[sfnItemIsInCategory]
(
	@pCategory nvarchar(256),
	@pItemId int
)
RETURNS  bit
as
Begin 

	--select convert(varchar(16), '1/1/2000 15:00', 14)

declare @RtnValue bit = 0
declare @pItemCategoryId int = 0
select @pItemCategoryId = a.CategoryId
from ItemCategory a (nolock)
where a.ItemId = @pItemId
and a.Available = 1
declare @pCategoryTable Table
(
	CategoryId int
)

if(isnull(@pItemCategoryId, 0) > 0)
BEGIN
	;with PagedQuery as
	(
	  SELECT a.Id
	  FROM Category a (nolock)
	  WHERE a.Name like '%' + @pCategory + '%'

	  UNION ALL

	  SELECT b.Id
	  FROM Category b (nolock)
	  INNER JOIN PagedQuery c
	  ON b.ParentCategoryId = c.Id
	)
	insert into @pCategoryTable
	(CategoryId)
	select a.Id
	from PagedQuery a

	if(exists(
		select *
		from @pCategoryTable a
		where a.CategoryId = @pItemCategoryId
	))
	begin
		select @RtnValue = 1
	end
END



return @RtnValue

End

/*


select top 10 * from Provider

select [dbo].[sfnItemIsInCategory](1, 'AroundToday')
select [dbo].[sfnItemIsInCategory](2, 'AroundToday')

select [dbo].[sfnItemIsInCategory](3, 'AroundToday')

*/

GO


