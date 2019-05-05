/****** Object:  UserDefinedFunction [dbo].[sfnBatchHandlerRecordDetailPropertyGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sfnBatchHandlerRecordDetailPropertyGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	print 'Create function [dbo].[sfnBatchHandlerRecordDetailPropertyGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[sfnBatchHandlerRecordDetailPropertyGet] 
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


print 'Update function [dbo].[sfnBatchHandlerRecordDetailPropertyGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[sfnBatchHandlerRecordDetailPropertyGet]
(
	@pBatchHandlerRecordId int,
	@pPropertyName nvarchar(256)
)
RETURNS  nvarchar(64)
as
Begin 

	declare @RtnValue nvarchar(64) = ''
	
	select @RtnValue = a.PropertyValue
	from BatchHandlerRecordProperty a (nolock)
	where a.BatchHandlerRecordId = @pBatchHandlerRecordId
	and a.PropertyName = @pPropertyName

	return isnull(@RtnValue, '')

End

/*


select top 10 * from WizardMasterStep
select * from WizardSession order by Id desc

select [dbo].[sfnBatchHandlerRecordDetailPropertyGet]('0', 11)
select [dbo].[sfnBatchHandlerRecordDetailPropertyGet](2, 'AroundToday')

select [dbo].[sfnBatchHandlerRecordDetailPropertyGet](3, 'AroundToday')

*/

GO


