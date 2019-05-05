IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Customer_OrderSearchByCustomer]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Customer_OrderSearchByCustomer] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Customer_OrderSearchByCustomer] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Customer_OrderSearchByCustomer] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_Customer_OrderSearchByCustomer] 
	@pProductName nvarchar(256),
	@pCustomerId int,
    @pDateStart datetime,
    @pDateEnd datetime,
    @pCustomerOrderStatusCodeId int,
	@pIsPaid bit,
    @pAddressSearchWord nvarchar(256),
	@pCompanyId int,
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
	select @pProductName = isnull(@pProductName, '')
    select @pProductName = rtrim(ltrim(@pProductName))

	select @pAddressSearchWord = isnull(@pAddressSearchWord, '')
    select @pAddressSearchWord = rtrim(ltrim(@pAddressSearchWord))

	declare @pByOrderStatusCodeId bit = 0
	if(@pCustomerOrderStatusCodeId is not null and @pCustomerOrderStatusCodeId > 0)
	begin
		select @pByOrderStatusCodeId = 1
	end
	else
	begin
		select @pByOrderStatusCodeId = 0
	end
	declare @pByDateStart bit = 0
	if(@pDateStart is null)
	begin
		select @pByDateStart = 0
	end
	else
	begin
		select @pByDateStart = 1
	end
	declare @pByDateEnd bit = 0
	if(@pDateEnd is null)
	begin
		select @pByDateEnd = 0
	end
	else
	begin
		select @pByDateEnd = 1
	end
	declare @pByPaid bit = @pIsPaid
	
	declare @pCustomerOrderTable Table
	(
		Customer_OrderId int,
		OrderAmount decimal(10, 2),
		PaidInFull bit
	)
	insert into @pCustomerOrderTable
	(
		Customer_OrderId,
		OrderAmount,
		PaidInFull
	)
	select	distinct(a.Id),
			a.TotalPriceAmount,
			case when a.Date_Paid is null then 0 else 1 end
	from Customer_Orders a (nolock)
		inner join Customers b (nolock) on a.CustomerId = b.Id
		inner join Customer_Order_ShippingAddress c (nolock) on a.Id = c.Customer_OrderId
		inner join [Address] d (nolock) on c.AddressId = d.Id
		left join CustomerThirdParty z (nolock) on b.Id = z.CustomerId
	where (@pByDateStart = 0 or (@pByDateStart = 1 and a.CreateDate >= @pDateStart))
	and (@pByDateEnd = 0 or (@pByDateEnd = 1 and a.CreateDate <= @pDateEnd))
	and (@pByOrderStatusCodeId = 0 or (@pByOrderStatusCodeId = 1 and a.CustomerOrderStatusCodeId = @pCustomerOrderStatusCodeId))
	and (@pAddressSearchWord = '' or (d.Address1 like '%' + @pAddressSearchWord + '%') 
	or (d.Address2 like '%' + @pAddressSearchWord + '%')
	or (d.City like '%' + @pAddressSearchWord + '%')
	or (d.State like '%' + @pAddressSearchWord + '%')
	or (d.District like '%' + @pAddressSearchWord + '%')
	or (d.Zip like '%' + @pAddressSearchWord + '%')
	)
	and b.Id = @pCustomerId

	select @Total = count(distinct(a.Customer_OrderId)) 
	--select * 
	from @pCustomerOrderTable a
	
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
		select	a.Id as Customer_OrderId,
			a.OrderCode as OrderCode,
			a.CustomerId as CustomerId,
			a.CustomerOrderStatusCodeId as CustomerOrderStatusCodeId,
			b.CodeShort as CustomerOrderStatusCode,
			c.Customer_AddressId as Customer_AddressId,
			a.Date_Placed as Date_Placed,
			a.Date_Paid as Date_Paid,
			a.OrderDiscountId as OrderDiscountId,
			a.TotalPriceAmount as TotalPriceAmount,
			a.CurrencyId as CurrencyId,
			a.SourceId as SourceId,
			a.SourceTable as SourceTable,
			ROW_NUMBER() OVER (order by a.Id) AS RowNumber
			from Customer_Orders a (nolock)
				inner join CodeList b (nolock) on a.CustomerOrderStatusCodeId = b.CodeId and b.Category = 'CustomerOrderStatus'
				inner join Customer_Order_ShippingAddress c (nolock) on a.Id = c.Customer_OrderId
				inner join @pCustomerOrderTable d on a.Id = d.Customer_OrderId
	)

	SELECT *
	from PagedQuery
	where RowNumber  between @RecStart and @RecEnd
	order by RowNumber ASC;



return

/*

*/



GO


