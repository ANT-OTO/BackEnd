IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CompanyTransactionRequestSearch]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CompanyTransactionRequestSearch] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CompanyTransactionRequestSearch] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CompanyTransactionRequestSearch] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CompanyTransactionRequestSearch] 
	@pCompanyId int,
	@pBeginDate datetime,
	@pEndDate datetime,
	@pCompanyTransactionRequestStatusCodeId int,
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
	
	declare @pByStatusCodeId bit = 0
	if(isnull(@pCompanyTransactionRequestStatusCodeId, 0) > 0)
	begin
		select @pByStatusCodeId = 1
	end




	--select * from ShippingOrder
	declare @pCompanyTransactionRequestTable Table
	(
		CompanyTransactionRequestId int,
		Amount decimal(10, 2),
		CurrencyId int,
		Currency nvarchar(256),
		SourceCompanyId int,
		SourceCompanyName nvarchar(256),
		HandlerCompanyId int,
		HandlerCompanyName nvarchar(256),
		CompanyTransactionRequestStatusCodeId int,
		CompanyTransactionRequestStatus nvarchar(256),
		UserId int,
		UserName nvarchar(256)
	)
	insert into @pCompanyTransactionRequestTable
	(
		CompanyTransactionRequestId,
		Amount,
		CurrencyId,
		Currency,
		SourceCompanyId,
		SourceCompanyName,
		HandlerCompanyId,
		HandlerCompanyName,
		CompanyTransactionRequestStatusCodeId,
		CompanyTransactionRequestStatus,
		UserId,
		UserName
	)
	select	a.Id, a.Amount, a.CurrencyId, b.EnglishName, c.Id, c.CompanyName,
			isnull(z.Id, 0), isnull(z.CompanyName, N'总公司'),
			a.CompanyTransactionRequestStatusCodeId, d.CodeShort,
			isnull(y.Id, 0), isnull(y.FirstName, '') + ' ' + isnull(y.LastName, '')
	from CompanyTransactionRequest a (nolock)
		inner join Currency b (nolock) on a.CurrencyId = b.Id
		inner join Company c (nolock) on a.SourceCompanyId = c.Id
		left join Company z (nolock) on a.TargetCompanyId = z.Id
		inner join CodeList d (nolock) on a.CompanyTransactionRequestStatusCodeId = d.CodeId and d.Category = 'CompanyTransactionRequestStatus'
		left join [User] y (nolock) on a.UserId = y.Id
	where a.SourceCompanyId = @pCompanyId
	and (@pByStatusCodeId = 0 or a.CompanyTransactionRequestStatusCodeId = @pCompanyTransactionRequestStatusCodeId)
	and (@pByCreateDateBegin = 0 or a.CreateDate > @pBeginDate)
	and (@pByCreateDateEnd = 0 or a.CreateDate < @pEndDate)

	


	select @Total = count(distinct(a.CompanyTransactionRequestId)) 
	--select * 
	from @pCompanyTransactionRequestTable a
	
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
		select	CompanyTransactionRequestId,
				Amount,
				CurrencyId,
				Currency,
				SourceCompanyId,
				SourceCompanyName,
				HandlerCompanyId,
				HandlerCompanyName,
				CompanyTransactionRequestStatusCodeId,
				CompanyTransactionRequestStatus,
				UserId,
				UserName,
			ROW_NUMBER() OVER (order by a.CompanyTransactionRequestId desc) AS RowNumber
			from @pCompanyTransactionRequestTable a
	)

	SELECT *
	from PagedQuery
	where RowNumber  between @RecStart and @RecEnd
	order by RowNumber ASC;



return

/*

*/



GO


