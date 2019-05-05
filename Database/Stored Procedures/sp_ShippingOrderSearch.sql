IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderSearch]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderSearch] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderSearch] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderSearch] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderSearch] 
	@pShippingOrderCode nvarchar(256),
	@pReferenceOrderCode nvarchar(256),
	@pSearchCustomerName nvarchar(256),
	@pCountryName nvarchar(256),
	@pPhoneNumber nvarchar(256),
    @pShippingOrderStatusCodeId int,
    @pAddress nvarchar(256),
    @pSourceCompanyId int,
	@pHandlerCompanyId int,
    @pIDReady bit,
    @pIDNumber nvarchar(256),
    @pBatchRecordNumber nvarchar(256),
    @pLabelReady bit,
    @pProductName nvarchar(256),
	@pSearchBeginDate datetime,
	@pSearchEndDate datetime,
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

	if(@pSearchBeginDate is not null)
	begin
		select @pByCreateDateBegin = 1
	end

	if(@pSearchEndDate is not null)
	begin
		select @pByCreateDateEnd = 1
	end
	--@pShippingOrderCode nvarchar(256),
	declare @pByShippingOrderCode bit = 0
	if(len(isnull(@pShippingOrderCode, '')) > 0)
	begin
		select @pByShippingOrderCode = 1
	end

	--@pSearchCustomerName nvarchar(256),
	declare @pByCustomerName bit = 0
	if(len(isnull(@pSearchCustomerName, '')) > 0)
	begin
		select @pByCustomerName = 1
	end

	--@pSearchCustomerName nvarchar(256),
	declare @pByCountryName bit = 0
	if(len(isnull(@pCountryName, '')) > 0)
	begin
		select @pByCountryName = 1
	end

	--@pSearchCustomerName nvarchar(256),
	declare @pByPhoneNumber bit = 0
	if(len(isnull(@pPhoneNumber, '')) > 0)
	begin
		select @pByPhoneNumber = 1
	end

 --   @pShippingOrderStatusCodeId int,
	declare @pByShippingOrderStatusCodeId bit = 0
	if(isnull(@pShippingOrderStatusCodeId, 0) > 0)
	begin
		select @pByShippingOrderStatusCodeId = 1
	end
 --   @pAddress nvarchar(256),
	declare @pByToAddress bit = 0
	if(len(isnull(@pAddress, '')) > 0)
	begin
		select @pByToAddress = 1
	end
 --   @pSourceCompanyId int,
	declare @pBySourceCompanyId bit = 0
	if(isnull(@pSourceCompanyId, 0) > 0)
	begin
		select @pBySourceCompanyId = 1
	end
 --   @pIDReady bit,
	
 --   @pIDNumber nvarchar(256),
	declare @pByIDNumber bit = 0
	if(len(isnull(@pIDNumber, '')) > 0)
	begin
		select @pByIDNumber = 1
	end
 --   @pBatchRecordNumber nvarchar(256),
	declare @pByBatchRecordNumber bit = 0
	if(len(isnull(@pBatchRecordNumber, '')) > 0)
	begin
		select @pByBatchRecordNumber = 1
	end
 --   @pLabelReady bit,
	
 --   @pProductName nvarchar(256),
	declare @pByProductName bit = 0
	if(len(isnull(@pProductName, '')) > 0)
	begin
		select @pByProductName = 1
	end

	declare @pByReferenceCode bit = 0
	if(len(isnull(@pReferenceOrderCode, '')) > 0)
	begin
		select @pByReferenceCode = 1
	end

	if(@pByShippingOrderCode = 1)
	begin
		declare @pRealShippingOrderCode nvarchar(256) = ''

		select @pRealShippingOrderCode = a.ShippingOrderCode
		from ShippingOrder a (nolock)
			inner join ShippingOrderSubOrder b (nolock) on a.Id = b.ShippingOrderId
		where b.SubOrderCode like '%' + @pShippingOrderCode + '%'
		and b.SubOrderTypeCodeId = 4 --select * from CodeList where Category = 'SubOrderType'

		if(len(@pRealShippingOrderCode) > 0)
		begin
			select @pShippingOrderCode = @pRealShippingOrderCode
		end
	end
	--select * from ShippingOrder
	declare @pShippingOrderTable Table
	(
		ShippingOrderId int,
		CustomerId int NULL,
		CustomerOrderId int NULL,
		SourceCompanyId int NOT NULL,
		HandlerCompanyId int NOT NULL,
		ReferenceOrderCode nvarchar(256) NULL,
		BatchHandlerNumber nvarchar(256) NOT NULL,
		ShippingFromAddressId int NOT NULL,
		ShippingToAddressId int NOT NULL,
		ShippingChannelId int NULL,
		Price decimal(10,2) NULL,
		CurrencyId int NULL,
		TotalWeight decimal(10,2) NULL,
		WeightUnitId int NULL,
		ShippingOrderStatusCodeId int NOT NULL, --select * from CodeList where Category = 'ShippingOrderStatus'
		ShippingOrderStatus nvarchar(256) NOT NULL,
		ShippingOrderCode nvarchar(256) NOT NULL,
		UserId int NOT NULL,
		CreateDate datetime NOT NULL,
		LastUpdate datetime NOT NULL,
		ShippingOrderIdentityProfileId int NULL,
		LabelReady bit NOT NULL
	)
	insert into @pShippingOrderTable
	(
		ShippingOrderId,
		CustomerId,
		CustomerOrderId,
		SourceCompanyId,
		HandlerCompanyId,
		ReferenceOrderCode,
		BatchHandlerNumber,
		ShippingFromAddressId,
		ShippingToAddressId,
		ShippingChannelId,
		Price,
		CurrencyId,
		TotalWeight,
		WeightUnitId,
		ShippingOrderStatusCodeId,
		ShippingOrderStatus,
		ShippingOrderCode,
		UserId,
		CreateDate,
		LastUpdate,
		ShippingOrderIdentityProfileId,
		LabelReady
	)
	select	a.Id, a.CustomerId, a.CustomerOrderId, b.SourceCompanyId, b.HandlerCompanyId, a.ReferenceOrderCode, isnull(y2.BatchNumber,''),
			a.ShippingFromAddressId, a.ShippingToAddressId, a.ShippingChannelId,
			a.Price, a.CurrencyId, a.TotalWeight, a.WeightUnitId, a.ShippingOrderStatusCodeId,
			a1.CodeShort, a.ShippingOrderCode, a.UserId, a.CreateDate, a.LastUpdate, z.Id, 0
	from ShippingOrder a (nolock)
		inner join CodeList a1 (nolock) on a.ShippingOrderStatusCodeId = a1.CodeId and a1.Category = 'ShippingOrderStatus'
		inner join ShippingOrderCompany b (nolock) on a.Id = b.ShippingOrderId
		inner join Company b1 (nolock) on b.SourceCompanyId = b1.Id
		inner join PhoneNumber b11 (nolock) on b1.PhoneNumberId = b11.Id
		left join ShippingOrderIdentityProfile z (nolock) on a.Id = z.ShippingOrderId
		left join ShippingOrderIdentityProfileFiles z1 (nolock) on z.Id = z1.ShippingOrderIdentityProfileId
		left join ShippingOrderIdentityProfileSFValidate z2 (nolock) on z.Id = z2.ShippingOrderIdentityProfileId
		left join ShippingOrderBatchHandlerRecord y (nolock) on a.Id = y.ShippingOrderId
		left join BatchHandlerRecord y1 (nolock) on y.BatchHandlerRecordId = y1.Id and y.Available = 1
		left join BatchHandler y2 (nolock) on y1.BatchHandlerId = y2.Id
		inner join ShippingAddress c (nolock) on a.ShippingFromAddressId = c.Id
		inner join ShippingAddress d (nolock) on a.ShippingToAddressId = d.Id
		inner join [Address] d1 (nolock) on d.AddressId = d1.Id
		inner join Country d11 (nolock) on d1.CountryId = d11.Id
	where (@pHandlerCompanyId is null or b.HandlerCompanyId = @pHandlerCompanyId)
	and (@pByBatchRecordNumber = 0 or (y2.BatchNumber like '%' + @pBatchRecordNumber + '%'))
	and (@pByCreateDateBegin = 0 or a.CreateDate > @pSearchBeginDate)
	and (@pByCreateDateEnd = 0 or a.CreateDate < @pSearchEndDate)
	and (@pByCustomerName = 0 or d.ContactPersonFirstName + d.ContactPersonLastName like '%' + @pSearchCustomerName + '%')
	and (@pByIDNumber = 0 or isnull(z.IdentityNumber, '') like '%' + @pIDNumber + '%')
	and (@pIDReady is null or (@pIDReady = 1 and (z.Id is not null and (z1.Id is not null or (z2.Id is not null and z2.SFValidate = 1)))) or (@pIDReady = 0 and (z.Id is null or (z1.Id is null and (z2.Id is null or z2.SFValidate = 0)))))
	and (@pByReferenceCode = 0 or a.ReferenceOrderCode like '%' + @pReferenceOrderCode + '%')
	and (@pByShippingOrderCode = 0 or a.ShippingOrderCode like '%' + @pShippingOrderCode + '%')
	and ((@pByShippingOrderStatusCodeId = 0 and a.ShippingOrderStatusCodeId <> 11) or a.ShippingOrderStatusCodeId = @pShippingOrderStatusCodeId)
	and (@pBySourceCompanyId = 0 or b.SourceCompanyId = @pSourceCompanyId)
	and (@pByToAddress = 0 or d1.Address1 like '%' + @pAddress + '%')
	and (@pByPhoneNumber = 0 or b11.PhoneNumber like '%' + @pPhoneNumber + '%' or d.ContactPersonPhoneNumber like '%' + @pPhoneNumber + '%' or c.ContactPersonPhoneNumber like '%' + @pPhoneNumber + '%')
	and (@pByCountryName = 0 or d11.CountryName like '%' + @pCountryName + '%')

	update a
	set a.LabelReady = 1
	from @pShippingOrderTable a 
	inner join ShippingOrderLabel b (nolock) on a.ShippingOrderId = b.ShippingOrderId



	if(@pLabelReady is not null)
	begin
		delete
		from @pShippingOrderTable
		where LabelReady <> @pLabelReady
	end

	


	select @Total = count(distinct(a.ShippingOrderId)) 
	--select * 
	from @pShippingOrderTable a
	
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
		select	ShippingOrderId,
				CustomerId,
				CustomerOrderId,
				SourceCompanyId,
				HandlerCompanyId,
				ReferenceOrderCode,
				BatchHandlerNumber,
				ShippingFromAddressId,
				ShippingToAddressId,
				ShippingChannelId,
				Price,
				CurrencyId,
				TotalWeight,
				WeightUnitId,
				ShippingOrderStatusCodeId,
				ShippingOrderStatus,
				ShippingOrderCode,
				UserId,
				CreateDate,
				LastUpdate,
				ShippingOrderIdentityProfileId,
				LabelReady,
			ROW_NUMBER() OVER (order by a.ShippingOrderId desc) AS RowNumber
			from @pShippingOrderTable a
	)

	SELECT *
	from PagedQuery
	where RowNumber  between @RecStart and @RecEnd
	order by RowNumber ASC;
 


return

/*

*/



GO


