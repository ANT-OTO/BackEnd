/****** Object:  UserDefinedFunction [dbo].[sfnBatchHandlerColumnIdGetByColumnName]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sfnBatchHandlerColumnIdGetByColumnName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	print 'Create function [dbo].[sfnBatchHandlerColumnIdGetByColumnName] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[sfnBatchHandlerColumnIdGetByColumnName] 
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


print 'Update function [dbo].[sfnBatchHandlerColumnIdGetByColumnName] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[sfnBatchHandlerColumnIdGetByColumnName]
(
	@pColumnName nvarchar(256),
	@pBatchHandlerId int
)
RETURNS  int
as
Begin 

	declare @RtnValue int = 0
	
	select @RtnValue = b.Id
	from BatchHandler a (nolock)
		inner join BatchHandlerColumn b (nolock) on a.Id = b.BatchHandlerId
	where b.ColumnName = @pColumnName
	and a.Id = @pBatchHandlerId

	return isnull(@RtnValue, 0)

End

/*


select top 10 * from WizardMasterStep
select * from WizardSession order by Id desc

select [dbo].[sfnBatchHandlerColumnIdGetByColumnName]('0', 11)
select [dbo].[sfnBatchHandlerColumnIdGetByColumnName](2, 'AroundToday')

select [dbo].[sfnBatchHandlerColumnIdGetByColumnName](3, 'AroundToday')

*/

GO


