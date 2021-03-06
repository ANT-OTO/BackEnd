﻿IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PurchasePoolTaskSearch]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_PurchasePoolTaskSearch] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_PurchasePoolTaskSearch] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_PurchasePoolTaskSearch] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_PurchasePoolTaskSearch] 
	@pItemPurchaseStatusCodeId int,
    @pPurchasePlaceSearch nvarchar(256),
    @pCreateDateFrom datetime,
    @pCreateDateTo datetime,
	@pUserId int,
	@pCompanyId int,
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
	select @pPurchasePlaceSearch = isnull(@pPurchasePlaceSearch, '')
    select @pPurchasePlaceSearch = rtrim(ltrim(@pPurchasePlaceSearch))

	

	declare @pByItemPurchaseStatusCodeId bit = 0
	if(@pItemPurchaseStatusCodeId is not null and @pItemPurchaseStatusCodeId > 0)
	begin
		select @pByItemPurchaseStatusCodeId = 1
	end
	else
	begin
		select @pByItemPurchaseStatusCodeId = 0
	end
	declare @pByCreateDateFrom bit = 0
	if(@pCreateDateFrom is null)
	begin
		select @pByCreateDateFrom = 0
	end
	else
	begin
		select @pByCreateDateFrom = 1
	end
	declare @pByCreateDateTo bit = 0
	if(@pCreateDateTo is null)
	begin
		select @pByCreateDateTo = 0
	end
	else
	begin
		select @pByCreateDateTo = 1
	end

	declare @pByUserId bit = 0
	if(@pUserId is null)
	begin
		select @pByUserId = 0
	end
	else
	begin
		select @pByUserId = 1
	end
	
	declare @pPurchasePoolTaskTable Table
	(
		ItemPurchaseTaskId int NOT NULL,
		PurchasePoolItemId int NOT NULL,
        QuantityMarked int NOT NULL,
		[UpdateQuantity] int NOT NULL,
		[Reason] nvarchar(max) NOT NULL,
		UserId int NOT NULL,
		UserName nvarchar(256) NOT NULL,
        ItemPurchaseStatusCodeId int NOT NULL,
        ItemPurchaseStatus nvarchar(256) NOT NULL,
        DiscountDetail nvarchar(256) NOT NULL,
        CurrencyId int NOT NULL,
        PurchasePlace nvarchar(256) NOT NULL,
        ItemId int NOT NULL
	)
	insert into @pPurchasePoolTaskTable
	(
		ItemPurchaseTaskId,
		PurchasePoolItemId,
        QuantityMarked,
		[UpdateQuantity],
		[Reason],
        UserId,
		UserName,
        ItemPurchaseStatusCodeId,
        ItemPurchaseStatus,
        DiscountDetail,
        CurrencyId,
        PurchasePlace,
        ItemId
	)
	select	a.Id, b.Id, a.Quantity, a.UpdateQuantity, a.Reason, a.UserId, d.FirstName + '' + d.LastName,
			a.ItemPurchaseStatusCodeId,
			a1.CodeShort, b.PurchaseDetail, b.CurrencyId, isnull(b.PurchasePlace, N'未知'),
			b.ItemId
	from [ItemPurchaseTask] a (nolock)
		inner join CodeList a1 (nolock) on a.ItemPurchaseStatusCodeId = a1.CodeId and a1.Category = 'ItemPurchaseStatus'
		inner join ItemPurchasePool b (nolock) on a.ItemPurchasePoolId = b.Id
		inner join ItemPurchasePoolCompany c (nolock) on b.ItemPurchasePoolCompanyId = c.Id
		inner join [User] d (nolock) on a.UserId = d.Id
	where c.CompanyId = @pCompanyId
	and (@pByUserId = 0 or (@pByUserId = 1 and a.UserId = @pUserId))
	and (@pByCreateDateFrom = 0 or (@pByCreateDateFrom = 1 and a.CreateDate >= @pCreateDateFrom))
	and (@pByCreateDateTo = 0 or (@pByCreateDateTo = 1 and a.CreateDate <= @pCreateDateTo))
	and (@pByItemPurchaseStatusCodeId = 0 or (@pByItemPurchaseStatusCodeId = 1 and a.ItemPurchaseStatusCodeId = @pItemPurchaseStatusCodeId))
	and (@pPurchasePlaceSearch = '' or b.PurchasePlace like '%' + @pPurchasePlaceSearch + '%')

	select @Total = count(distinct(a.ItemPurchaseTaskId)) 
	--select * 
	from @pPurchasePoolTaskTable a
	
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
		select	a.ItemPurchaseTaskId,
				a.PurchasePoolItemId,
				a.ItemId,
				a.CurrencyId,
				a.DiscountDetail,
				a.ItemPurchaseStatus,
				a.ItemPurchaseStatusCodeId,
				a.PurchasePlace,
				a.QuantityMarked,
				a.UpdateQuantity,
				a.Reason,
				a.UserId,
				a.UserName,
			ROW_NUMBER() OVER (order by a.ItemPurchaseTaskId) AS RowNumber
			from @pPurchasePoolTaskTable a
	)

	SELECT *
	from PagedQuery
	where RowNumber  between @RecStart and @RecEnd
	order by RowNumber ASC;



return

/*

*/



GO


