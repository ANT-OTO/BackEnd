IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CompanyTransactionInsert]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CompanyTransactionInsert] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CompanyTransactionInsert] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CompanyTransactionInsert] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CompanyTransactionInsert] 
	@pCompanyId int,
	@pTransactionTypeCodeId int,
	@pAmount decimal(10, 2),
	@pCurrencyId int,
	@pSourceId int,
	@pSourceTable nvarchar(256),
	@pDescription nvarchar(256),
	@pUserId int,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON

	declare @pTime datetime = getutcdate()

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
	and a.CurrencyId = @pCurrencyId

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
	and a.CurrencyId = @pCurrencyId

	


return

/*

*/



GO


