/****** Object:  UserDefinedFunction [dbo].[sfnCompanyTransactionOtherCompanyName]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sfnCompanyTransactionOtherCompanyName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	print 'Create function [dbo].[sfnCompanyTransactionOtherCompanyName] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[sfnCompanyTransactionOtherCompanyName] 
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


print 'Update function [dbo].[sfnCompanyTransactionOtherCompanyName] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[sfnCompanyTransactionOtherCompanyName]
(
	@pCompanyTransactionId int
)
RETURNS  nvarchar(256)
as
Begin 
	declare @Rtn_Value nvarchar(256) = ''
	declare @pTime datetime = getutcdate()
	
	declare @pSourceTable nvarchar(256) = ''
	declare @pSourceId int = 0
	declare @pCompanyId int = 0

	select	@pSourceTable = a.SourceTable,
			@pSourceId = a.SourceId,
			@pCompanyId = a.CompanyId
	from CompanyTransaction a (nolock)
	where a.Id = @pCompanyTransactionId

	if(exists(
		select *
		from CompanyLogisticCompany a (nolock)
		where a.CompanyId = @pCompanyId
	))
	begin
		-- men dian
		if(@pSourceTable = 'ShippingOrderBatchReceipt')
		begin
			--install
			select @Rtn_Value = e.ContactLastName + ' ' + e.ContactFirstName
			from ShippingOrderBatchReceipt a (nolock)
				inner join ShippingOrderBatchReceiptShippingOrder b (nolock) on a.Id = b.ShippingOrderBatchReceiptId
				inner join ShippingOrder c (nolock) on b.ShippingOrderId = c.Id
				inner join ShippingOrderCompany d (nolock) on c.Id = d.ShippingOrderId
				inner join Company e (nolock) on d.SourceCompanyId = e.Id
			where a.Id = @pSourceId
		end

		if(@pSourceTable = 'ShippingOrder')
		begin
			select @Rtn_Value = e.ContactLastName + ' ' + e.ContactFirstName
			from ShippingOrder c
				inner join ShippingOrderCompany d (nolock) on c.Id = d.ShippingOrderId
				inner join Company e (nolock) on d.SourceCompanyId = e.Id
			where c.Id = @pSourceId
		end

		if(@pSourceTable = 'Company')
		begin
			select @Rtn_Value = e.ContactLastName + ' ' + e.ContactFirstName
			from Company e (nolock)
			where e.Id = @pSourceId
		end

		if(@pSourceTable = 'CompanyTransactionRequest')
		begin
			select @Rtn_Value = e.ContactLastName + ' ' + e.ContactFirstName
			from CompanyTransactionRequest a (nolock)
				inner join Company e (nolock) on a.SourceCompanyId = e.Id 
			where a.Id = @pSourceId
		end
	end
	else
	begin
		if(@pSourceTable = 'ShippingOrderBatchReceipt')
		begin
			--install
			select @Rtn_Value = e.ContactLastName + ' ' + e.ContactFirstName
			from ShippingOrderBatchReceipt a (nolock)
				inner join ShippingOrderBatchReceiptShippingOrder b (nolock) on a.Id = b.ShippingOrderBatchReceiptId
				inner join ShippingOrder c (nolock) on b.ShippingOrderId = c.Id
				inner join ShippingOrderCompany d (nolock) on c.Id = d.ShippingOrderId
				inner join Company e (nolock) on d.HandlerCompanyId = e.Id
			where a.Id = @pSourceId
		end

		if(@pSourceTable = 'ShippingOrder')
		begin
			select @Rtn_Value = e.ContactLastName + ' ' + e.ContactFirstName
			from ShippingOrder c
				inner join ShippingOrderCompany d (nolock) on c.Id = d.ShippingOrderId
				inner join Company e (nolock) on d.HandlerCompanyId = e.Id
			where c.Id = @pSourceId
		end

		if(@pSourceTable = 'Company')
		begin
			select @Rtn_Value = e.ContactLastName + ' ' + e.ContactFirstName
			from Company e (nolock)
			where e.Id = @pSourceId
		end

		if(@pSourceTable = 'CompanyTransactionRequest')
		begin
			select @Rtn_Value = e.ContactLastName + ' ' + e.ContactFirstName
			from CompanyTransactionRequest a (nolock)
				inner join Company e (nolock) on a.TargetCompanyId = e.Id 
			where a.Id = @pSourceId
		end
	end



	

	return isnull(@Rtn_Value,'')
End
/*

--select top 10 * from WEYI.dbo.Person
select [dbo].[sfnCompanyTransactionOtherCompanyName](3824)
*/

GO


