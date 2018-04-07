
declare @CompanyId int = 1005,
		@BillGatewayCodeId int= 1,			--Authorize.net
		@PersonPaymentMethodCodeId int = 1	-- CC
-- select * from CodeList

/**** For Authorize.Net ******/
declare @Login varchar(100) = '9phX7Dk4AX',
	@Key varchar(100) = '4r38stW3GNXN678g',
	@Url varchar(1000) = 'https://test.authorize.net/gateway/transact.dll'
/**** End For Authorize.Net ******/



declare @BillCompanyPayGateway int = 0

insert [BillCompanyPayGateway]
(
	[CompanyId],
	[BillGatewayCodeId],
	[PersonPaymentMethodCodeId],
	[Active],
	[CreateDate]
)
select @CompanyId,
	@BillGatewayCodeId,
	@PersonPaymentMethodCodeId,
	1,
	GETUTCDATE()
where not exists (select * from [BillCompanyPayGateway] where CompanyId = @CompanyId and BillGatewayCodeId = @BillGatewayCodeId and PersonPaymentMethodCodeId = @PersonPaymentMethodCodeId)

select @BillCompanyPayGateway = SCOPE_IDENTITY()

/*
declare @BillCompanyPayGateway int = 1
declare @CompanyId int = 1005,
		@BillGatewayCodeId int= 1,			--Authorize.net
		@PersonPaymentMethodCodeId int = 1	
declare @Login varchar(100) = '9phX7Dk4AX',
	@Key varchar(100) = '4r38stW3GNXN678g',
	@Url varchar(1000) = 'https://test.authorize.net/gateway/transact.dll'
*/
if isnull(@BillCompanyPayGateway, 0) <> 0 and @BillGatewayCodeId = 1
begin
	insert BillCompanyPayGateway_AutorizeNet
	([BillCompanyPayGatewayId],
	[Login],
	[Key],
	[Url])
	select @BillCompanyPayGateway,
		@Login,
		@Key,
		@Url

end
select * from [BillCompanyPayGateway]
select * from BillCompanyPayGateway_AutorizeNet
