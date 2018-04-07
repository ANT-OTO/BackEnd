IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_BillProviderStatement]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_BillProviderStatement] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_BillProviderStatement] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_BillProviderStatement] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER  procedure [dbo].[sp_BillProviderStatement] 
	@pProviderId int,
	@pStatementId int,
	@pSystemLanguageId int,
	@pStatementDate datetime output,
	@pStatementNumber datetime output,
	@pStartDate datetime output,
	@pEndDate datetime output,
	@pPayableAmount decimal (9, 2) output,
	@pPaidAmount decimal (9,2) output,
	@pIsCurrent bit output,
	@pApproved bit output
AS
set nocount on
begin
	select @pStatementDate = a.StatementDate,
		@pStatementNumber = a.StatementNumber,
		@pStartDate = a.StartDate,
		@pEndDate = a.EndDate,
		@pPayableAmount = a.PayableAmount,
		@pPaidAmount = a.PaidAmount,
		@pIsCurrent = a.IsCurrent,
		@pApproved = a.Approved
	from dbo.BillProviderStatement a (nolock)
	where a.Id = @pStatementId
	and a.ProviderId = @pProviderId

	if @@ROWCOUNT = 1
	begin
		select b.ProviderBillingTypeCodeId,
			c.CodeLong as ProviderBillingType,
			b.CreateDate,
			replace(replace(replace(ISNULL(w.DescTxt, isnull(x.DescTxt, 'N/A')), '#ServiceType#', ''), '#StartTime#', cast(v.AcceptedTime as nvarchar(50))), '#EndTime#', cast(dateadd(second, v.ServiceSeconds, v.AcceptedTime) as nvarchar(50))) as Description,
			replace(ISNULL(w.UnitTxt, isnull(x.UnitTxt, cast(b.UnitValue as nvarchar(500)))), '#Rate#', z.Rate) as UnitCost,
			replace(ISNULL(w.QuantityTxt, isnull(x.QuantityTxt, cast(b.Quantity as nvarchar(500)))), '#Min#', cast(b.Quantity as int)) as Quantity,
			b.TotalValue
		from dbo.BillProviderStatementTransaction a (nolock)
		join dbo.BillProviderTransaction b (nolock) on b.Id = a.BillProviderTransactionId
		join dbo.CodeList c (nolock) on c.Category = 'ProviderBillingType' and c.CodeId = b.ProviderBillingTypeCodeId
		left join BillProviderPayTermRate z (nolock) on z.Id = b.BillProviderPayTermRateId
		left join BillPayTerm y (nolock) on y.Id = z.BillPayTermId
		left join BillPayTermDetail x (nolock) on x.BillPayTermId = y.Id
		left join BillPayTermDetailY w (nolock) on w.BillPayTermDetailId = x.Id and w.SystemLanguageId = @pSystemLanguageId
		left join BillProviderTransactionRequest v (nolock) on b.SourceTable = 'BillProviderTransactionRequest' and v.Id = b.SourceTableId
		where a.BillProviderStatementId = @pStatementId
		order by b.CreateDate
	end
end
/*
declare @pStatementDate datetime,
	@pStatementNumber datetime,
	@pStartDate datetime ,
	@pEndDate datetime ,
	@pPayableAmount decimal (9, 2) ,
	@pPaidAmount decimal (9,2) ,
	@pIsCurrent bit,
	@pApproved bit

exec [dbo].[sp_BillProviderStatement] 
	@pProviderId = 509,
	@pStatementId  = 97,
	@pSystemLanguageId  = 1,
	@pStatementDate= @pStatementDate output,
	@pStatementNumber= @pStatementNumber output,
	@pStartDate= @pStartDate output,
	@pEndDate = @pEndDate output,
	@pPayableAmount=@pPayableAmount output,
	@pPaidAmount=@pPaidAmount output,
	@pIsCurrent=@pIsCurrent output,
	@pApproved =@pApproved  output

select @pStatementDate,
	@pStatementNumber,
	@pStartDate,
	@pEndDate,
	@pPayableAmount,
	@pPaidAmount,
	@pIsCurrent,
	@pApproved
*/
Go

