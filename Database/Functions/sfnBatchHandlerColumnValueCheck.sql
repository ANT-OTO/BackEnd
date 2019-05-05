/****** Object:  UserDefinedFunction [dbo].[sfnBatchHandlerColumnValueCheck]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sfnBatchHandlerColumnValueCheck]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	print 'Create function [dbo].[sfnBatchHandlerColumnValueCheck] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[sfnBatchHandlerColumnValueCheck] 
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


print 'Update function [dbo].[sfnBatchHandlerColumnValueCheck] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[sfnBatchHandlerColumnValueCheck]
(
	@pBatchHandlerColumnId int,
	@pValue nvarchar(256)
)
RETURNS  nvarchar(64)
as
Begin 

	declare @RtnValue nvarchar(64) = ''
	declare @pColumnTypeCodeId int = 0
	declare @pRequired bit = 0
	declare @pColumnName nvarchar(256) = ''
	select @pValue = isnull(@pValue, '')

	select	@pColumnTypeCodeId = a.ColumnTypeCodeId,
			@pRequired = a.[Required],
			@pColumnName = a.ColumnName
	from BatchHandlerColumn a (nolock)
	where a.Id = @pBatchHandlerColumnId
	
	select @pValue = REPLACE(@pValue, ' ', '')

	if(@pRequired = 1 and len(@pValue) = 0)
	begin
		select @RtnValue = '''' + @pColumnName + '''' + N'列必填项缺失'
		return @RtnValue
	end
	--select * from CodeList where Category = 'ColumnType'
	if(@pRequired = 1 and @pColumnTypeCodeId = 1)
	begin
		if(ISNUMERIC(@pValue) = 0)
		begin
			select @RtnValue = '''' + @pColumnName + '''' + N'列要求整数值'
			return @RtnValue
		end
	end

	if(@pRequired = 1 and @pColumnTypeCodeId = 2)
	begin
		if((@pValue <> '0' and @pValue <> '1'))
		begin
			select @RtnValue = '''' + @pColumnName + '''' + N'列要求0或1'
			return @RtnValue
		end
	end

	if(@pRequired = 1 and @pColumnTypeCodeId = 3)
	begin
		if(len(@pValue) = 0)
		begin
			select @RtnValue = '''' + @pColumnName + '''' + N'列要求值'
			return @RtnValue
		end
	end

	if(@pRequired = 1 and @pColumnTypeCodeId = 5)
	begin
		if(ISNUMERIC(@pValue) = 0)
		begin
			select @RtnValue = '''' + @pColumnName + '''' + N'列要求小数值'
			return @RtnValue
		end
	end

	if(@pColumnName = N'运单关联编号')
	begin
		if(exists(
			select *
			from ShippingOrder a (nolock)
			where a.ReferenceOrderCode = @pValue
			and a.ShippingOrderStatusCodeId not in (9, 10, 11) --select * from CodeList where Category = 'ShippingOrderStatus'
		))
		begin
			select @RtnValue = '''' + @pColumnName + '''' + N'列运单关联编号已存在'
			return @RtnValue
		end
	end

	if(@pColumnName = N'渠道代码')
	begin
		if(not exists(
			select *
			from ShippingChannel a (nolock)
			where a.ChannelCode = @pValue --select * from CodeList where Category = 'ShippingOrderStatus'
		))
		begin
			select @RtnValue = '''' + @pColumnName + '''' + N'列渠道代码不存在'
			return @RtnValue
		end
	end

	return isnull(@RtnValue, '')

End

/*


select top 10 * from WizardMasterStep
select * from WizardSession order by Id desc

select [dbo].[sfnBatchHandlerColumnValueCheck]('0', 11)
select [dbo].[sfnBatchHandlerColumnValueCheck](2, 'AroundToday')

select [dbo].[sfnBatchHandlerColumnValueCheck](3, 'AroundToday')

*/

GO


