IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ANTOTOShippingOrderAdditionalInfoSet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ANTOTOShippingOrderAdditionalInfoSet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ANTOTOShippingOrderAdditionalInfoSet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ANTOTOShippingOrderAdditionalInfoSet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ANTOTOShippingOrderAdditionalInfoSet] 
	@pShippingOrderId int,
	@pPackageCount int,
	@pShippingOrderTaxPaymentTypeCodeId int,
	@pShippingOrderAdditionalInfoId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	insert into ShippingOrderAdditionalInfo
	(
		ShippingOrderId,
		Width,
		Height,
		Length,
		PackageCount,
		ShippingOrderTaxPaymentTypeCodeId,
		CreateDate,
		LastUpdate,
		LastUpdateBy,
		LastUpdateByType
	)
	select	a.ShippingOrderId, 0.0, 0.0, 0.0,
			a.PackageCount, a.ShippingOrderTaxPaymentTypeCodeId,
			@pTime, @pTime, 1, 1
	from 
	(
		select	@pPackageCount as PackageCount,
				@pShippingOrderTaxPaymentTypeCodeId as ShippingOrderTaxPaymentTypeCodeId,
				@pShippingOrderId as ShippingOrderId
	) a
	left join ShippingOrderAdditionalInfo z (nolock) on a.ShippingOrderId = z.ShippingOrderId
	where z.Id is null

	if(@@ROWCOUNT > 0)
	begin
		select @pShippingOrderAdditionalInfoId = SCOPE_IDENTITY()
	end
	else
	begin
		update a
		set a.Height = 0.0,
			a.Length = 0.0,
			a.Width = 0.0,
			a.PackageCount = @pPackageCount,
			a.ShippingOrderTaxPaymentTypeCodeId = @pShippingOrderTaxPaymentTypeCodeId,
			a.LastUpdate = getutcdate(),
			a.LastUpdateBy = 1,
			a.LastUpdateByType = 1
		from ShippingOrderAdditionalInfo a
		where a.ShippingOrderId = @pShippingOrderId

		select @pShippingOrderAdditionalInfoId = a.Id
		from ShippingOrderAdditionalInfo a (nolock)
		where a.ShippingOrderId = @pShippingOrderId

	end

	declare @pReferenceCode nvarchar(256) = ''
	declare @pShippingOrderCode nvarchar(256) = ''
	select	@pReferenceCode = a.ReferenceOrderCode,
			@pShippingOrderCode = a.ShippingOrderCode
	from ShippingOrder a (nolock)
	where a.Id = @pShippingOrderId

	if(len(@pReferenceCode) = 0)
	begin
		declare @i int = 0
		while(@i < @pPackageCount)
		begin
			select @pReferenceCode = @pReferenceCode + @pShippingOrderCode + '_' + CAST(@i as varchar(10))
			if(@i + 1 < @pPackageCount)
			begin
				select @pReferenceCode = @pReferenceCode + ','
			end
			select @i = @i + 1
		end
	end

return

/*

*/



GO


