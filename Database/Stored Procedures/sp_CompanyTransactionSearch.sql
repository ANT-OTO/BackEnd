IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CompanyTransactionSearch]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CompanyTransactionSearch] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CompanyTransactionSearch] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CompanyTransactionSearch] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CompanyTransactionSearch] 
	@pCompanyId int,
	@pBeginDate datetime,
	@pEndDate datetime,
	@pDescriptionSearch nvarchar(256),
	@PageSize INT, 
	@Page INT output,
	@Total INT OUTPUT,
	@TotalPages INT OUTPUT
AS

SET NOCOUNT ON
	if(isnull(@PageSize, 0) <= 0)
	begin
		return
	end
	declare @pTime datetime = getutcdate()

	declare @pByCreateDateBegin bit = 0
	declare @pByCreateDateEnd bit = 0

	if(@pBeginDate is not null)
	begin
		select @pByCreateDateBegin = 1
	end

	if(@pEndDate is not null)
	begin
		select @pByCreateDateEnd = 1
	end
	--@pShippingOrderCode nvarchar(256),
	declare @pByDescriptionSearch bit = 0
	if(len(isnull(@pDescriptionSearch, '')) > 0)
	begin
		select @pDescriptionSearch = 1
	end




	--select * from ShippingOrder
	declare @pCompanyTransactionTable Table
	(
		CompanyTransactionId int,
		CompanyId int,
		CompanyName nvarchar(256),
		CurrentBalance decimal(10, 2),
		Amount decimal(10, 2),
		TransactionTypeCodeId int,
		TransactionType nvarchar(256),
		[Description] nvarchar(256),
        CurrencyId int,
		Currency nvarchar(256),
		UserId int,
		UserName nvarchar(256)
	)
	insert into @pCompanyTransactionTable
	(
		CompanyTransactionId,
		CompanyId,
		CompanyName,
		CurrentBalance,
		Amount,
		TransactionTypeCodeId,
		TransactionType,
		[Description],
        CurrencyId,
		Currency,
		UserId,
		UserName
	)
	select	a.Id, a.CompanyId, b.CompanyName, a.CurrentBalance, a.Amount,
			a.TransactionTypeCodeId, c.CodeShort, a.[Description], d.Id, d.EnglishName,
			isnull(z.Id, 0), dbo.sfnCompanyTransactionOtherCompanyName(a.Id)
	from CompanyTransaction a (nolock)
		inner join Company b (nolock) on a.CompanyId = b.Id
		inner join CodeList c (nolock) on a.TransactionTypeCodeId = c.CodeId and c.Category = 'TransactionType'
		inner join Currency d (nolock) on a.CurrencyId = d.Id
		left join [User] z (nolock) on a.UserId = z.Id
	where a.CompanyId = @pCompanyId
	and (@pByCreateDateBegin = 0 or a.CreateDate > @pBeginDate)
	and (@pByCreateDateEnd = 0 or a.CreateDate < @pEndDate)
	and (@pByDescriptionSearch = 0 or a.[Description] like '%' + @pDescriptionSearch + '%')

	


	select @Total = count(distinct(a.CompanyTransactionId)) 
	--select * 
	from @pCompanyTransactionTable a
	
	select @TotalPages = CEILING(convert(decimal(10,2), @Total)/convert(decimal(10,2) ,@PageSize))
	declare @MaxPage INT

	select @MaxPage = (@Total - 1 )/@PageSize + 1

	if ( @Page < 1 )
	BEGIN
	 	select @Page = 1
	END

	if ( @Page > @MaxPage )
	BEGIN
		select @Page = @MaxPage
	END

	declare @RecStart INT,
			@RecEnd INT

	select @RecStart = (@Page - 1) * @PageSize + 1,
			@RecEnd = @Page * @PageSize

	if( @RecEnd > @Total )
	begin
		select @RecEnd = @Total
	end
	;

	with PagedQuery AS
	(
		select	CompanyTransactionId,
				CompanyId,
				CompanyName,
				CurrentBalance,
				Amount,
				TransactionTypeCodeId,
				TransactionType,
				[Description],
				CurrencyId,
				Currency,
				UserId,
				UserName,
			ROW_NUMBER() OVER (order by a.CompanyTransactionId desc) AS RowNumber
			from @pCompanyTransactionTable a
	)

	SELECT *
	from PagedQuery
	where RowNumber  between @RecStart and @RecEnd
	order by RowNumber ASC;



return

/*

*/



GO


