IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CompanyTransactionVoid]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CompanyTransactionVoid] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CompanyTransactionVoid] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CompanyTransactionVoid] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CompanyTransactionVoid] 
	@pOriginalCompanyTransactionId int,
	@pReason nvarchar(256),
	@pUserId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	declare @pCompanyId int = 0
	declare @pTransactionTypeCodeId int = 0
	declare @pAmount decimal(10,2) = 0.0
	declare @pSourceId int = 0
	declare @pSourceTable nvarchar(256) = ''
	declare @pCurrencyId int = 0
	declare @pDescription nvarchar(256) = @pReason

	select	@pCompanyId = a.CompanyId,
			@pTransactionTypeCodeId = a.TransactionTypeCodeId,
			@pAmount = a.Amount,
			@pCurrencyId = a.CurrencyId,
			@pSourceId = a.SourceId,
			@pSourceTable = a.SourceTable
	from CompanyTransaction a (nolock)
	where a.Id = @pOriginalCompanyTransactionId

	select @pTransactionTypeCodeId = case when @pTransactionTypeCodeId = 1 then 4
										  when @pTransactionTypeCodeId = 2 then 5
										  when @pTransactionTypeCodeId = 3 then 6
										  when @pTransactionTypeCodeId = 7 then 8 end	

	declare @pCompanyTransactionId int = 0
	insert into [dbo].[CompanyTransaction]
	(
		[CompanyId],
		[TransactionTypeCodeId], --select * from CodeList where Category = 'TransactionType'
		[Amount],
		[CurrentBalance],
		[SourceId],
		[SourceTable],
		[CurrencyId],
		[Description],
		[Available],
		[UserId],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	@pCompanyId, @pTransactionTypeCodeId, @pAmount,
			0, @pSourceId, @pSourceTable, @pCurrencyId,
			@pDescription, 1, @pUserId, @pTime, @pTime,
			@pUserId, 1

	select @pCompanyTransactionId = SCOPE_IDENTITY()

	--count balance
	declare @pPreviousBalance decimal(10,2) = 0.0

	declare @pMaxCompanyTransactionId int = 0

	select @pMaxCompanyTransactionId = max(a.Id) 
	from CompanyTransaction a (nolock)
	where a.CompanyId = @pCompanyId
	and a.CurrencyId = @pCurrencyId		
	and a.Id <> @pCompanyTransactionId	

	select @pPreviousBalance = a.CurrentBalance
	from CompanyTransaction a (nolock)
	where a.Id = @pMaxCompanyTransactionId

	update a
	set a.CurrentBalance = case when @pTransactionTypeCodeId = 1 then @pPreviousBalance - @pAmount
								when @pTransactionTypeCodeId = 2 then @pPreviousBalance + @pAmount
								when @pTransactionTypeCodeId = 3 then @pPreviousBalance + @pAmount
								when @pTransactionTypeCodeId = 4 then @pPreviousBalance + @pAmount
								when @pTransactionTypeCodeId = 5 then @pPreviousBalance - @pAmount
								when @pTransactionTypeCodeId = 6 then @pPreviousBalance - @pAmount
								when @pTransactionTypeCodeId = 7 then @pPreviousBalance - @pAmount
								when @pTransactionTypeCodeId = 8 then @pPreviousBalance + @pAmount end--select * from CodeList where Category = 'TransactionType'
	from CompanyTransaction a
	where a.Id = @pCompanyTransactionId


	


return

/*

*/



GO


