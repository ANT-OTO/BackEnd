-- drop table TempPaymentData

create table TempPaymentData(
ProviderId int,
Amount decimal (9,2),
Acct nvarchar (500),
PaidDate datetime
)

insert TempPaymentData select 379,20,'beckybut1315@gmail.com','11/17/2015'
insert TempPaymentData select 390,20,'elissee@gmail.com','11/17/2015'
--insert TempPaymentData select 393,20,'check','12/30/1899'
insert TempPaymentData select 395,20,'pmattlee@gmail.com','11/17/2015'
insert TempPaymentData select 421,20,'652810069@qq.com','11/17/2015'
insert TempPaymentData select 422,10,'flauschig.15@gmail.com','11/17/2015'
--insert TempPaymentData select 427,10,'','12/30/1899'
insert TempPaymentData select 428,10,'nuno_134@hotmail.com','11/17/2015'
--insert TempPaymentData select 436,10,'','12/30/1899'
insert TempPaymentData select 438,10,'gingerwang@gingerwang.com','11/13/2015'
--insert TempPaymentData select 441,10,'','12/30/1899'
insert TempPaymentData select 444,10,'clarissetranslate@gmail.com','11/17/2015'
--insert TempPaymentData select 449,10,' tmurakoshi@yahoo.com','12/30/1899'
insert TempPaymentData select 451,10,'rollandegirard@gmail.com','11/17/2015'
insert TempPaymentData select 458,10,' mariesoleil.lemire@gmail.com','11/17/2015'
insert TempPaymentData select 462,10,'jun.kim.bank@gmail.com','11/30/2015'
insert TempPaymentData select 509,10,'underdasea78@gmail.com','11/17/2015'
insert TempPaymentData select 511,58.50,'PAID THRU 10/29','10/30/2015'
insert TempPaymentData select 511,87.75,'','12/15/2015'


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

	b.Id,
	'BillProviderAcctPaypal',


	1,
	1,
	'BillProviderPayGateway_Paypal',

	isnull((select max(Id) from BillProviderPayGateway_PayPalManualLog),0),
	'BillProviderPayGateway_PayPalManualLog',

	a.PaidDate,
	GETUTCDATE()
from TempPaymentData a
join BillProviderAcctPaypal b on b.ProviderId = a.ProviderId
left join [BillProviderPaid] z on z.ProviderId = a.ProviderId
where z.Id is null

--select * from [BillProviderPaid]
insert BillProviderTransaction
	(ProviderId,
	TransactionDate,
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
	b.PaidDate,
	2,
	null,
	1,
	b.Amount,
	b.Amount,
	a.Id,
	'BillProviderPaid',
	GETUTCDATE()
from dbo.[BillProviderPaid] a
join TempPaymentData b on a.ProviderId = b.ProviderId


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


insert [BillProviderStatementTransaction](
	[BillProviderStatementId],
	[BillProviderTransactionId],
	[CreateDate])
select a.StatId as [BillProviderStatementId],
	b.Id as [BillProviderTransactionId],
	GETUTCDATE()
from (select max(Id) as StatId,ProviderId  from BillProviderStatement where IsCurrent = 0 group by ProviderId)  a
join BillProviderTransaction b on a.ProviderId = b.ProviderId
left join [BillProviderStatementTransaction] c on c.BillProviderTransactionId = b.Id
where c.Id is null 
and b.ProviderBillingTypeCodeId = 2

go


select * from [BillProviderStatementTransaction]
select * from [BillProviderTransaction] where ProviderBillingTypeCodeId = 2

update [BillProviderTransaction] set  ProviderBillingTypeCodeId = 1 where ProviderBillingTypeCodeId = 2 and CreateDate < '12/16/2015'

select  *from BillProviderStatement where Id = 97

select * from TempPaymentData

97