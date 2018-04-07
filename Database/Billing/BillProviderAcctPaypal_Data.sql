insert BillProviderAcctPaypal (ProviderId,
AccountNumber,
AccountName,
CreateDate)
select 511,
'oandrino@live.com',
'',
GETUTCDATE()

insert BillProviderAcctPaypal (ProviderId,
AccountNumber,
AccountName,
CreateDate)
select 509,
'underdasea78@gmail.com',
'',
GETUTCDATE()

insert BillProviderAcctPaypal (ProviderId,
AccountNumber,
AccountName,
CreateDate)
select 458,
'mariesoleil.lemire@gmail.com',
'',
GETUTCDATE()


insert BillProviderAcctPaypal (ProviderId,
AccountNumber,
AccountName,
CreateDate)
select 451,
'rollandegirard@gmail.com',
'',
GETUTCDATE()

insert BillProviderAcctPaypal (ProviderId,
AccountNumber,
AccountName,
CreateDate)
select 444,
'clarissetranslate@gmail.com',
'',
GETUTCDATE()

insert BillProviderAcctPaypal (ProviderId,
AccountNumber,
AccountName,
CreateDate)
select 438,
'gingerwang@gingerwang.com',
'',
GETUTCDATE()


insert BillProviderAcctPaypal (ProviderId,
AccountNumber,
AccountName,
CreateDate)
select 428,
'nuno_134@hotmail.com',
'',
GETUTCDATE()

insert BillProviderAcctPaypal (ProviderId,
AccountNumber,
AccountName,
CreateDate)
select 422,
'flauschig.15@gmail.com',
'',
GETUTCDATE()

insert BillProviderAcctPaypal (ProviderId,
AccountNumber,
AccountName,
CreateDate)
select 421,
'652810069@qq.com',
'',
GETUTCDATE()

insert BillProviderAcctPaypal (ProviderId,
AccountNumber,
AccountName,
CreateDate)
select 395,
'pmattlee@gmail.com',
'',
GETUTCDATE()

insert BillProviderAcctPaypal (ProviderId,
AccountNumber,
AccountName,
CreateDate)
select 379,
'beckybut1315@gmail.com',
'',
GETUTCDATE()

insert BillProviderAcctPaypal (ProviderId,
AccountNumber,
AccountName,
CreateDate)
select 390,
'elissee@gmail.com',
'',
GETUTCDATE()

insert BillProviderAcctPaypal (ProviderId,
AccountNumber,
AccountName,
CreateDate)
select 462,
'jun.kim.bank@gmail.com',
'',
GETUTCDATE()

-- BillProviderPayGateway

insert BillProviderPayGateway (
	ProviderPaymentMethodCodeId,
	ProviderPaymentTypeCodeId,
	Description,
	Active,
	DetailTable,
	CreateDate
)
select 2,
		2,
		'Manual PayPal payment',
		1,
		'BillProviderPayGateway_Paypal',
		GETUTCDATE()
--select * from CodeList where Category = 'ProviderPaymentMethod'
-- select * from BillProviderPayGateway


insert BillProviderPayGateway_Paypal (
	BillProviderPayGatewayId,
	Name,
	UserId,
	Secret,
	AuthUrl,
	CreateDate
)
select 1,
		'First PayPal Acct',
		'',
		'',
		'',
		GETUTCDATE()
go

--begin
--	declare @ProviderId = 

insert [BillProviderPaid](
	[ProviderId],

	[BillProviderAcctRefId],
	[BillProviderAcctTable],

	[BillPaymentEngineId],
	[BillPaymentEngineInfoId],
	[BillPaymentEngineInfoTable],

	[BillPaymentEngineLogId],
	[BillPaymentEngineLogTable],
	
	[PaidDate],

	[CreateDate]
)
select 
	a.ProviderId,

	a.Id,
	'BillProviderAcctPaypal',


	1,
	1,
	'BillProviderPayGateway_Paypal',

	isnull((select max(Id) from BillProviderPayGateway_PayPalManualLog),0),
	'BillProviderPayGateway_PayPalManualLog',

	'11/17/2015',
	GETUTCDATE()
from BillProviderAcctPaypal a
where a.ProviderId = @ProviderId




-- select * from BillProviderAcctPaypal where ProviderId = 379

insert BillProviderTransaction
	(ProviderId,
	ProviderBillingTypeCodeId,
	BillProviderPayTermRateId,
	Quantity,
	UnitValue,
	TotalValue,
	SourceTableId,
	SourceTable,
	CreateDate)

select 
	a.ProviderId,
	2,
	null,
	1,
	a.Rate,
	a.AdjustValue,
	null,
	null,
	GETUTCDATE()
from dbo.[BillProviderPaid] a



 ( select a.ProviderId,
		case when c.AdjustValue is null then b.Rate when c.AdjustValue < b.Rate then b.Rate - c.AdjustValue else 0 end as AdjustValue,
		b.Id as BillProviderPayTermRateId,
		b.Rate
		from BillProviderStatement a
		join BillProviderPayTermRate b on b.ProviderId = a.ProviderId and b.BillPayTermId = 2
		left join (select a.BillProviderStatementId,
					sum (b.TotalValue) as AdjustValue, b.ProviderId
					from BillProviderStatementTransaction a
					join BillProviderTransaction b on b.Id = a.BillProviderTransactionId
					join BillProviderPayTermRate c on c.Id = b.BillProviderPayTermRateId and c.BillPayTermId = 1
					group by a.BillProviderStatementId, b.ProviderId) c on c.BillProviderStatementId = a.Id
		where a.IsCurrent = 1 and (c.AdjustValue is null or c.AdjustValue < b.Rate) and DATEADD(day, 30, a.StartDate)<GETUTCDATE()
) a

insert [BillProviderStatementTransaction](
	[BillProviderStatementId],
	[BillProviderTransactionId],
	[CreateDate])
select a.Id as [BillProviderStatementId],
	b.Id as [BillProviderTransactionId],
	GETUTCDATE()
from BillProviderStatement  a
join BillProviderTransaction b on a.ProviderId = b.ProviderId
left join [BillProviderStatementTransaction] c on c.BillProviderTransactionId = b.Id
where c.Id is null 
and b.ProviderBillingTypeCodeId = 2
and a.IsCurrent = 1

