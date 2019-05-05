/****** Object:  UserDefinedFunction [dbo].[sfnCodeList]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sfnCodeList]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	print 'Create function [dbo].[sfnCodeList] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[sfnCodeList] 
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


print 'Update function [dbo].[sfnCodeList] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[sfnCodeList]
(
	@pSystemLanguageId int,
	@pCategory [nvarchar](128),
	@pCodeId int
)
RETURNS  nvarchar(1024)
as
Begin 

	--select convert(varchar(16), '1/1/2000 15:00', 14)

declare @RtnValue nvarchar(1024) = ''

select @RtnValue = a.CodeLong from tfnCodeList(@pSystemLanguageId, @pCategory) a where a.CodeId = @pCodeId


return @RtnValue

End

/*


select top 10 * from Provider

select [dbo].[sfnCodeList](1, 'AroundToday')
select [dbo].[sfnCodeList](2, 'AroundToday')

select [dbo].[sfnCodeList](3, 'AroundToday')

*/

GO


