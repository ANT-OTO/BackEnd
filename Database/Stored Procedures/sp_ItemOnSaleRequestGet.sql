IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemOnSaleRequestGet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemOnSaleRequestGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemOnSaleRequestGet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemOnSaleRequestGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemOnSaleRequestGet] 
	@pItemOnSaleRequestStatusCodeId int,
	@pCompanyId int,
	@pUserId int,
	@pSystemLanguageId int,
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
	declare @TempTable Table
	(
		[ItemOnSaleRequestId] int NOT NULL,
		[ItemId] int NOT NULL,
		[ItemOnSaleRequestTempBufferId] int NULL,
		[Description] nvarchar(max) NOT NULL,
		[UpdatedPrice] nvarchar(256) NOT NULL,
		[UpdatedCurrencyId] int NOT NULL,
		[UpdatedCurrency] nvarchar(256) NOT NULL,
		[ItemOnSaleRequestStatusCodeId] int NOT NULL, --select * from CodeList where Category = 'ItemOnSaleRequestStatus'
		CreateDate datetime NOT NULL
	)

	insert into @TempTable
	(
		[ItemOnSaleRequestId],
		[ItemId],
		[ItemOnSaleRequestTempBufferId],
		[Description],
		[UpdatedPrice],
		[UpdatedCurrencyId],
		[UpdatedCurrency],
		[ItemOnSaleRequestStatusCodeId], --select * from CodeList where Category = 'ItemOnSaleRequestStatus'
		CreateDate
	)
	select	a.Id, a.ItemId, a.ItemOnSaleRequestTempBufferId, a.[Description], a.[UpdatedPrice], a.[UpdatedCurrencyId], isnull(y.Code, ''),
			a.ItemOnSaleRequestStatusCodeId, a.CreateDate
	from [ItemOnSaleRequest] a (nolock)
		inner join CodeList b (nolock) on a.ItemOnSaleRequestStatusCodeId = b.CodeId AND b.Category = 'ItemOnSaleRequestStatus'
		left join CodeListY z (nolock) on b.Id = z.CodeListId and z.SystemLanguageId = @pSystemLanguageId
		inner join Item c (nolock) on c.Id = a.ItemId
		inner join CompanyItem d (nolock) on c.Id = d.ItemId
		left join Currency y (nolock) on a.UpdatedCurrencyId = y.Id
	where d.CompanyId = @pCompanyId
	and (isnull(@pItemOnSaleRequestStatusCodeId, 0) = 0 or a.ItemOnSaleRequestStatusCodeId = @pItemOnSaleRequestStatusCodeId)

	

	select @Total = count(*) 
	--select *
	from @TempTable a

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
		select	[ItemOnSaleRequestId],
				[ItemId],
				[ItemOnSaleRequestTempBufferId],
				[Description],
				[UpdatedPrice],
				[UpdatedCurrencyId],
				[UpdatedCurrency],
				[ItemOnSaleRequestStatusCodeId], --select * from CodeList where Category = 'ItemOnSaleRequestStatus'
				CreateDate,
				ROW_NUMBER() OVER (order by a.CreateDate desc) AS RowNumber
		from @TempTable a
	)

	SELECT *
	from PagedQuery
	where RowNumber  between @RecStart and @RecEnd
	order by RowNumber ASC;



return

/*

*/



GO


