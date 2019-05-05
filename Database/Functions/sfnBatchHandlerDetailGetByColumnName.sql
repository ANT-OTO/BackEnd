/****** Object:  UserDefinedFunction [dbo].[sfnBatchHandlerDetailGetByColumnName]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sfnBatchHandlerDetailGetByColumnName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	print 'Create function [dbo].[sfnBatchHandlerDetailGetByColumnName] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[sfnBatchHandlerDetailGetByColumnName] 
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


print 'Update function [dbo].[sfnBatchHandlerDetailGetByColumnName] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[sfnBatchHandlerDetailGetByColumnName]
(
	@pBatchHandlerRecordId int,
	@pColumnName nvarchar(256)
)
RETURNS  nvarchar(256)
as
Begin 

	declare @RtnValue nvarchar(256) = ''
	
	select @RtnValue = c.Value
	from BatchHandler a (nolock)
		inner join BatchHandlerRecord b (nolock) on a.Id = b.BatchHandlerId
		inner join BatchHandlerRecordDetail c (nolock) on b.Id = c.BatchHandlerRecordId
		inner join BatchHandlerColumn d (nolock) on c.BatchHandlerColumnId = d.Id
	where b.Id = @pBatchHandlerRecordId
	and d.ColumnName = @pColumnName

	return isnull(@RtnValue, '')

End

/*


select top 10 * from WizardMasterStep
select * from WizardSession order by Id desc

select [dbo].[sfnBatchHandlerDetailGetByColumnName]('0', 11)
select [dbo].[sfnBatchHandlerDetailGetByColumnName](2, 'AroundToday')

select [dbo].[sfnBatchHandlerDetailGetByColumnName](3, 'AroundToday')

*/

GO


