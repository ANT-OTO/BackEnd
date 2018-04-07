
insert into BillPersonInfo
(PersonId, IsIndividualBilling, Balance, RequiredPaymentNow, CreateDate, LastUpdate, LastUpdateBy, LastUpdateByType)
select a.Id, dbo.sfn_BillPersonIsIndividualBilling(a.Id), 
	case when dbo.sfn_BillPersonIsIndividualBilling(a.Id) = 1 then dbo.sfn_BillPersonTransaction_GetBalance(a.Id) else 0 end, 
	0, 
	getutcdate(), GETUTCDATE(), 1,1 
from Person a
	left join BillPersonInfo z on a.Id = z.PersonId
where z.Id is null
	and dbo.sfn_BillPersonIsIndividualBilling(a.Id) = 1

update a
set a.RequiredPaymentNow = dbo.sfn_BillPersonTransaction_GetPaymentAmount(a.PersonId, a.Balance)
	, a.LastUpdate = GETUTCDATE()
--select dbo.sfn_BillPersonTransaction_GetPaymentAmount(a.PersonId, a.Balance)
from BillPersonInfo a 
where a.IsIndividualBilling = 1 and a.RequiredPaymentNow = 0


select * from BillPersonInfo

go

