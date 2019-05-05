/****** Object:  UserDefinedFunction [dbo].[sfnItemIsInBrand]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sfnItemIsInBrand]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	print 'Create function [dbo].[sfnItemIsInBrand] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[sfnItemIsInBrand] 
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


print 'Update function [dbo].[sfnItemIsInBrand] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[sfnItemIsInBrand]
(
	@pBrand nvarchar(256),
	@pItemId int
)
RETURNS  bit
as
Begin 

	--select convert(varchar(16), '1/1/2000 15:00', 14)

declare @RtnValue bit = 0
declare @pItemBrandId int = 0
select @pItemBrandId = a.BrandId
from ItemBrand a (nolock)
where a.ItemId = @pItemId
and a.Available = 1
declare @pBrandTable Table
(
	BrandId int
)

if(isnull(@pItemBrandId, 0) > 0)
BEGIN
	;with PagedQuery as
	(
	  SELECT a.Id
	  FROM Brand a (nolock)
	  WHERE a.BrandName like '%' + @pBrand + '%'

	  UNION ALL

	  SELECT b.Id
	  FROM Brand b (nolock)
	  INNER JOIN PagedQuery c
	  ON b.ParentBrandId = c.Id
	)
	insert into @pBrandTable
	(BrandId)
	select a.Id
	from PagedQuery a

	if(exists(
		select *
		from @pBrandTable a
		where a.BrandId = @pItemBrandId
	))
	begin
		select @RtnValue = 1
	end
END



return @RtnValue

End

/*


select top 10 * from Provider

select [dbo].[sfnItemIsInBrand](1, 'AroundToday')
select [dbo].[sfnItemIsInBrand](2, 'AroundToday')

select [dbo].[sfnItemIsInBrand](3, 'AroundToday')

*/

GO


