IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_BatchHandlerRecordDetailGenerateShippingOrder]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_BatchHandlerRecordDetailGenerateShippingOrder] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_BatchHandlerRecordDetailGenerateShippingOrder] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_BatchHandlerRecordDetailGenerateShippingOrder] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_BatchHandlerRecordDetailGenerateShippingOrder] 
	@pBatchHandlerRecordId int,
	@pShippingOrderId int output
AS

SET NOCOUNT ON
begin

	declare @pTime datetime = getutcdate()
	declare @pShippingChannelId int = 0
	--select * from ShippingOrder

	--select * from ShippingAddress
	declare @pUserId int = 0
	declare @pBatchHandlerId int = 0
	select	@pUserId = a.UserId,
			@pBatchHandlerId = a.Id
	from BatchHandler a (nolock)
		inner join BatchHandlerRecord b (nolock) on a.Id = b.BatchHandlerId
	where b.Id = @pBatchHandlerRecordId 

	declare @pSourceCompanyId int = 0
	declare @pHandlerCompanyId int = 0

	select @pSourceCompanyId = convert(int, a.PropertyValue)
	from BatchHandlerProperty a (nolock)
	where a.BatchHandlerId = @pBatchHandlerId
	and a.PropertyName = 'SourceCompanyId'

	select @pHandlerCompanyId = convert(int, a.PropertyValue)
	from BatchHandlerProperty a (nolock)
	where a.BatchHandlerId = @pBatchHandlerId
	and a.PropertyName = 'HandlerCompanyId'

	declare @pSourceCompany nvarchar(256) = ''
	select @pSourceCompany = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'客户代码')

	if(@pSourceCompanyId = @pHandlerCompanyId)
	begin
		select @pSourceCompanyId = a.Id
		from Company a (nolock)
		where a.CompanyCode = @pSourceCompany
	end

	if(@pSourceCompanyId = @pHandlerCompanyId)
	begin
		return
	end

	declare @pFromPersonFirstName nvarchar(256) = ''
	select @pFromPersonFirstName = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'寄件人姓名')
	declare @pFromPersonLastName nvarchar(256) = ''
	if(ASCII(@pFromPersonFirstName) = 63)
	begin
		select @pFromPersonLastName = RIGHT(@pFromPersonFirstName, LEN(@pFromPersonFirstName) - 1)
		select @pFromPersonFirstName = SUBSTRING(@pFromPersonFirstName, 1, 1)
	end
	else 
	begin
		select @pFromPersonLastName = SUBSTRING(@pFromPersonFirstName,CHARINDEX(' ',@pFromPersonFirstName,0)+1,LEN(@pFromPersonFirstName))
		select @pFromPersonFirstName = SUBSTRING(@pFromPersonFirstName,0,CHARINDEX(' ',@pFromPersonFirstName,0))
	end

	
	
	declare @pFromPersonPhoneNumber nvarchar(256) = ''
	select @pFromPersonPhoneNumber = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'寄件人联系电话')

	declare @pFromPersonAddress nvarchar(256) = ''
	select @pFromPersonAddress = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'寄件人详细地址')

	declare @pFromPersonCity nvarchar(64) = ''
	select @pFromPersonCity = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'寄件人城市')

	declare @pFromPersonState nvarchar(256) = ''
	select @pFromPersonState = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'寄件人州/省')

	declare @pFromPersonCountryId int = 183
	declare @pFromPersonCountry nvarchar(256) = ''
	select @pFromPersonCountry = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'寄件人国家')
	select @pFromPersonCountryId = a.Id
	from Country a (nolock)
	where a.Abbreviation = @pFromPersonCountry
	declare @pFromPersonZip nvarchar(256) = ''
	select @pFromPersonZip = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'寄件人邮编')
	--select * from Address

	declare @pToPersonFirstName nvarchar(256) = ''
	select @pToPersonFirstName = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'收件人姓名')
	
	declare @pToPersonLastName nvarchar(256) = ''
	if(ASCII(@pFromPersonFirstName) = 63)
	begin
		select @pToPersonLastName = RIGHT(@pToPersonFirstName, LEN(@pToPersonFirstName) - 1)
		select @pToPersonFirstName = SUBSTRING(@pToPersonFirstName, 1, 1)
	end
	else 
	begin
		select @pToPersonLastName = SUBSTRING(@pToPersonFirstName,CHARINDEX(' ',@pToPersonFirstName,0)+1,LEN(@pFromPersonFirstName))
		select @pToPersonFirstName = SUBSTRING(@pToPersonFirstName,0,CHARINDEX(' ',@pToPersonFirstName,0))
	end

	declare @pToPersonPhoneNumber nvarchar(256) = ''
	select @pToPersonPhoneNumber = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'收件人联系电话')
	
	
	declare @pToPersonAddress nvarchar(256) = ''
	select @pToPersonAddress = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'收件人联系电话')
	declare @pToPersonCity nvarchar(64) = ''
	select @pToPersonCity = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'收件人城市')
	declare @pToPersonState nvarchar(256) = ''
	select @pToPersonState = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'收件人州/省')
	declare @pToPersonCountryId int = 37
	declare @pToPersonCountry nvarchar(256) = ''
	select @pToPersonCountry = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'收件人国家')
	select @pToPersonCountryId = a.Id
	from Country a (nolock)
	where a.Abbreviation = @pToPersonCountry

	declare @pToPersonZip nvarchar(256) = ''
	select @pToPersonZip = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'收件人邮编')
	
	--select * from BatchTemplateContent

	declare @ReferenceCode nvarchar(256) = ''
	select @ReferenceCode = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'运单关联编号')

	declare @ReferenceCode_2 nvarchar(256) = ''
	select @ReferenceCode_2 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'运单关联编号2')

	declare @ChannelCode nvarchar(256) = ''
	select @ChannelCode = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'渠道代码')

	select @pShippingChannelId = a.Id
	from ShippingChannel a (nolock)
		inner join ShippingChannelLogisticCompany b (nolock) on a.Id = b.ShippingChannelId
	where a.ChannelCode = @ChannelCode
	and b.LogisticCompanyId = @pHandlerCompanyId

	declare @PackageCount nvarchar(256) = ''
	select @PackageCount = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'包裹数量')

	declare @PackageCountInt int = 1
	if(len(@PackageCount) > 0)
	begin
		select @PackageCountInt = convert(int, @PackageCount)
	end

	declare @PackingService nvarchar(256) = ''
	select @PackingService = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'打包增值服务')

	declare @MaterialService nvarchar(256) = ''
	select @MaterialService = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'打包材料增值服务')

	declare @InsuranceService nvarchar(256) = ''
	select @InsuranceService = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'邮寄保险增值服务')

	declare @PaymentMethod nvarchar(256) = ''
	select @PaymentMethod = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'付款方式')

	declare @TaxPaymentMethod nvarchar(256) = ''
	select @TaxPaymentMethod = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'税金付款方式')

	declare @ShippingOrderTaxPaymentTypeCodeId int = 1 --select * from CodeList where Category = 'ShippingOrderTaxPaymentType'
	if(len(@TaxPaymentMethod) > 0)
	begin
		select @ShippingOrderTaxPaymentTypeCodeId = case when @TaxPaymentMethod = N'寄件方' then 1 else 2 end
	end

	declare @MerchantName1 nvarchar(256) = ''
	select @MerchantName1 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品名称1')

	declare @MerchantUPC1 nvarchar(256) = ''
	select @MerchantUPC1 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品UPC1')

	declare @MerchantSKU1 nvarchar(256) = ''
	select @MerchantSKU1 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品SKU1')

	declare @MerchantQuantity1 nvarchar(256) = ''
	select @MerchantQuantity1 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品数量1')

	declare @MerchantUnit1 nvarchar(256) = ''
	select @MerchantUnit1 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品单位1')

	declare @MerchantPrice1 nvarchar(256) = ''
	select @MerchantPrice1 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品单价1')

	declare @MerchantPriceDecimal1 decimal(10,2) = 0
	if(len(@MerchantPrice1) > 0)
	begin
		select @MerchantPriceDecimal1 = convert(decimal(10,2), @MerchantPrice1)
	end

	declare @MerchantWeight1 nvarchar(256) = ''
	select @MerchantWeight1 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品重量1')

	declare @MerchantWeightDecimal1 decimal(10,2) = 0
	if(len(@MerchantWeight1) > 0 and ISNUMERIC(@MerchantWeight1) = 1)
	begin
		select @MerchantWeightDecimal1 = convert(decimal(10,2), @MerchantWeight1)
	end

	declare @MerchantSourceArea1 nvarchar(256) = ''
	select @MerchantSourceArea1 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品源地区1')

	declare @MerchantBrand1 nvarchar(256) = ''
	select @MerchantBrand1 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品品牌1')

	declare @MerchantName2 nvarchar(256) = ''
	select @MerchantName2 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品名称2')

	declare @MerchantUPC2 nvarchar(256) = ''
	select @MerchantUPC2 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品UPC2')

	declare @MerchantSKU2 nvarchar(256) = ''
	select @MerchantSKU2 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品SKU2')

	declare @MerchantQuantity2 nvarchar(256) = ''
	select @MerchantQuantity2 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品数量2')

	declare @MerchantUnit2 nvarchar(256) = ''
	select @MerchantUnit2 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品单位2')

	declare @MerchantPrice2 nvarchar(256) = ''
	select @MerchantPrice2 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品单价2')

	declare @MerchantPriceDecimal2 decimal(10,2) = 0
	if(len(@MerchantPrice2) > 0)
	begin
		select @MerchantPriceDecimal2 = convert(decimal(10,2), @MerchantPrice2)
	end

	declare @MerchantWeight2 nvarchar(256) = ''
	select @MerchantWeight2 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品重量2')

	declare @MerchantWeightDecimal2 decimal(10,2) = 0
	if(len(@MerchantWeight2) > 0 and ISNUMERIC(@MerchantWeight2) = 1)
	begin
		select @MerchantWeightDecimal2 = convert(decimal(10,2), @MerchantWeight2)
	end

	declare @MerchantSourceArea2 nvarchar(256) = ''
	select @MerchantSourceArea2 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品源地区2')

	declare @MerchantBrand2 nvarchar(256) = ''
	select @MerchantBrand2 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品品牌2')

	declare @MerchantName3 nvarchar(256) = ''
	select @MerchantName3 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品名称3')

	declare @MerchantUPC3 nvarchar(256) = ''
	select @MerchantUPC3 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品UPC3')

	declare @MerchantSKU3 nvarchar(256) = ''
	select @MerchantSKU3 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品SKU3')

	declare @MerchantQuantity3 nvarchar(256) = ''
	select @MerchantQuantity3 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品数量3')

	declare @MerchantUnit3 nvarchar(256) = ''
	select @MerchantUnit3 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品单位3')

	declare @MerchantPrice3 nvarchar(256) = ''
	select @MerchantPrice3 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品单价3')

	declare @MerchantPriceDecimal3 decimal(10,2) = 0
	if(len(@MerchantPrice3) > 0)
	begin
		select @MerchantPriceDecimal3 = convert(decimal(10,2), @MerchantPrice3)
	end

	declare @MerchantWeight3 nvarchar(256) = ''
	select @MerchantWeight3 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品重量3')

	declare @MerchantWeightDecimal3 decimal(10,2) = 0
	if(len(@MerchantWeight3) > 0 and ISNUMERIC(@MerchantWeight3) = 1)
	begin
		select @MerchantWeightDecimal3 = convert(decimal(10,2), @MerchantWeight3)
	end

	declare @MerchantSourceArea3 nvarchar(256) = ''
	select @MerchantSourceArea3 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品源地区3')

	declare @MerchantBrand3 nvarchar(256) = ''
	select @MerchantBrand3 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品品牌3')

	declare @MerchantName4 nvarchar(256) = ''
	select @MerchantName4 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品名称4')

	declare @MerchantUPC4 nvarchar(256) = ''
	select @MerchantUPC4 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品UPC4')

	declare @MerchantSKU4 nvarchar(256) = ''
	select @MerchantSKU4 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品SKU4')

	declare @MerchantQuantity4 nvarchar(256) = ''
	select @MerchantQuantity4 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品数量4')

	declare @MerchantUnit4 nvarchar(256) = ''
	select @MerchantUnit4 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品单位4')

	declare @MerchantPrice4 nvarchar(256) = ''
	select @MerchantPrice4 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品单价4')

	declare @MerchantPriceDecimal4 decimal(10,2) = 0
	if(len(@MerchantPrice4) > 0)
	begin
		select @MerchantPriceDecimal4 = convert(decimal(10,2), @MerchantPrice4)
	end

	declare @MerchantWeight4 nvarchar(256) = ''
	select @MerchantWeight4 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品重量4')

	declare @MerchantWeightDecimal4 decimal(10,2) = 0
	if(len(@MerchantWeight4) > 0 and ISNUMERIC(@MerchantWeight4) = 1)
	begin
		select @MerchantWeightDecimal4 = convert(decimal(10,2), @MerchantWeight4)
	end

	declare @MerchantSourceArea4 nvarchar(256) = ''
	select @MerchantSourceArea4 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品源地区4')

	declare @MerchantBrand4 nvarchar(256) = ''
	select @MerchantBrand4 = [dbo].[sfnBatchHandlerDetailGetByColumnName](@pBatchHandlerRecordId, N'商品品牌4')

	declare @pFromShippingAddressId int = 0
	declare @pToShippingAddressId int = 0

	exec [dbo].[sp_ShippingAddressCreate] 
	@pFromPersonFirstName,
	'',
	@pFromPersonPhoneNumber,
	@pFromPersonCountryId,
	@pFromPersonAddress,
	'',
	@pFromPersonCity,
	@pFromPersonState,
	@pFromPersonZip,
	@pFromPersonCountryId,
	@pFromShippingAddressId output

	exec [dbo].[sp_ShippingAddressCreate] 
	@pToPersonFirstName,
	'',
	@pToPersonPhoneNumber,
	@pToPersonCountryId,
	@pToPersonAddress,
	'',
	@pToPersonCity,
	@pToPersonState,
	@pToPersonZip,
	@pToPersonCountryId,
	@pToShippingAddressId output

	--select * from Currency
	
	if(not exists(
		select *
		from ShippingOrder a (nolock)
		where a.ReferenceOrderCode = @ReferenceCode
		and a.ShippingOrderStatusCodeId not in (9, 10, 11)
	))
	begin
		exec sp_ANTOTOShippingOrderQuickCreate 0, @ReferenceCode, @pFromShippingAddressId, @pToShippingAddressId, @pShippingChannelId,
								0.0, 114, 0, 1, 1, @pUserId, @pSourceCompanyId, @pHandlerCompanyId, 
								@pShippingOrderId output
	end
	else
	begin
		select @pShippingOrderId = max(a.Id)
		from ShippingOrder a (nolock)
		where a.ReferenceOrderCode = @ReferenceCode
	end
	declare @pShippingOrderAdditionalInfoId int = 0
	exec [dbo].[sp_ANTOTOShippingOrderAdditionalInfoSet] @pShippingOrderId, @PackageCountInt, @ShippingOrderTaxPaymentTypeCodeId, @pShippingOrderAdditionalInfoId output

	if(@pShippingOrderId > 0)
	begin
		declare @pShippingOrderItemId int = 0
		--Item 1
		--select * from Currency
		declare @pQuantity int = 0
		if(len(@MerchantName1)>0)
		begin
			select @pQuantity = convert(int, @MerchantQuantity1)
			exec [dbo].[sp_ANTOTOShippingOrderItemInsert] @pShippingOrderId, null, null, @MerchantName1, @pQuantity,
			@MerchantUnit1, @MerchantWeightDecimal1, 1, @MerchantPriceDecimal1, 114, 0, @MerchantSourceArea1, 
			@MerchantSKU1, @MerchantUPC1, @MerchantBrand1, '', 1, 1, @pShippingOrderItemId output
		end

		if(len(@MerchantName2)>0)
		begin
			select @pQuantity = convert(int, @MerchantQuantity2)
			exec [dbo].[sp_ANTOTOShippingOrderItemInsert] @pShippingOrderId, null, null, @MerchantName2, @pQuantity,
			@MerchantUnit2, @MerchantWeightDecimal2, 1, @MerchantPriceDecimal2, 114, 0, @MerchantSourceArea2, 
			@MerchantSKU2, @MerchantUPC2, @MerchantBrand2, '', 1, 1, @pShippingOrderItemId output
		end

		if(len(@MerchantName3)>0)
		begin
			select @pQuantity = convert(int, @MerchantQuantity3)
			exec [dbo].[sp_ANTOTOShippingOrderItemInsert] @pShippingOrderId, null, null, @MerchantName3, @pQuantity,
			@MerchantUnit3, @MerchantWeightDecimal3, 1, @MerchantPriceDecimal3, 114, 0, @MerchantSourceArea3, 
			@MerchantSKU3, @MerchantUPC3, @MerchantBrand3, '', 1, 1, @pShippingOrderItemId output
		end

		if(len(@MerchantName4)>0)
		begin
			select @pQuantity = convert(int, @MerchantQuantity4)
			exec [dbo].[sp_ANTOTOShippingOrderItemInsert] @pShippingOrderId, null, null, @MerchantName4, @pQuantity,
			@MerchantUnit4, @MerchantWeightDecimal4, 1, @MerchantPriceDecimal4, 114, 0, @MerchantSourceArea4, 
			@MerchantSKU4, @MerchantUPC4, @MerchantBrand4, '', 1, 1, @pShippingOrderItemId output
		end
	end

	declare @pShippingOrderProperty nvarchar(256) = convert(nvarchar(256), @pShippingOrderId)
	exec sp_BatchHandlerRecordPropertySet @pBatchHandlerRecordId, 'ShippingOrderId', @pShippingOrderProperty, @pUserId, @pUserId, 1
	if(not exists(
		select *
		from ShippingOrderBatchHandlerRecord a (nolock)
		where a.ShippingOrderId = @pShippingOrderId
		and a.Available = 1
	))
	begin
		insert into ShippingOrderBatchHandlerRecord
		(
			[ShippingOrderId],
			[BatchHandlerRecordId],
			[Available],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select @pShippingOrderId, @pBatchHandlerRecordId, 1, @pTime, @pTime, 1, 1
	end
	


return
end
/*

*/



GO


