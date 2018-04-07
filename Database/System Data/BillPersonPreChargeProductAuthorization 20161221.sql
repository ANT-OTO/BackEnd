
update a
set a.AuthorizationStatusCodeId = 3				-- select * from CodeList where Category = 'AuthorizationStatus'
												-- 3	Voided
--select * 
from BillPersonPreChargeProductAuthorization a
	inner join BillPersonTransactionPayment b (nolock) on b.Id = a.BillPersonTransactionPaymentId 
	left join BillPersonTransactionPaymentAuthorizeNet z (nolock) on z.BillPersonTransactionPaymentId = b.Id 
			and z.x_type = 'auth_only' and z.x_response_code = '1'
where z.Id is null


update a
set a.AuthorizationStatusCodeId = 2				-- select * from CodeList where Category = 'AuthorizationStatus'
												-- 2	Captured
--select * 
--select c.*, a.*
from BillPersonPreChargeProductAuthorization a
	inner join BillPersonTransactionPayment b (nolock) on b.Id = a.BillPersonTransactionPaymentId 
	inner join BillPersonTransactionPaymentAuthorizeNet c (nolock) on c.BillPersonTransactionPaymentId = b.Id 
			and c.x_type = 'auth_only' and c.x_response_code = '1'
	inner join (
		select a.Id as BillPersonPreChargeProductAuthorizationId, b.Id as BillPersonTransactionPaymentId, c.x_trans_id
		from BillPersonPreChargeProductAuthorization a
			inner join BillPersonTransactionPayment b (nolock) on b.Id = a.BillPersonTransactionPaymentId 
			inner join BillPersonTransactionPaymentAuthorizeNet c (nolock) on c.BillPersonTransactionPaymentId = b.Id 
					and c.x_type = 'prior_auth_capture' and c.x_response_code = '1'			
		where a.AuthorizationStatusCodeId is null
	) d on a.Id = d.BillPersonPreChargeProductAuthorizationId and a.BillPersonTransactionPaymentId = d.BillPersonTransactionPaymentId and c.x_trans_id = d.x_trans_id
where a.AuthorizationStatusCodeId is null

update a
set a.AuthorizationStatusCodeId = 3				-- select * from CodeList where Category = 'AuthorizationStatus'
												-- 3	Voided
--select * 
--select c.*, a.*
from BillPersonPreChargeProductAuthorization a
	inner join BillPersonTransactionPayment b (nolock) on b.Id = a.BillPersonTransactionPaymentId 
	inner join BillPersonTransactionPaymentAuthorizeNet c (nolock) on c.BillPersonTransactionPaymentId = b.Id 
			and c.x_type = 'auth_only' and c.x_response_code = '1'
	inner join BillPersonTransactionPaymentAuthorizeNet d (nolock) on d.BillPersonTransactionPaymentId = b.Id 
			and d.x_type = 'void' and c.x_response_code = '1'
where a.AuthorizationStatusCodeId is null 


update a
set a.AuthorizationStatusCodeId = 1				-- select * from CodeList where Category = 'AuthorizationStatus'
												-- 1	Authorized
--select * 
--select c.*, a.*
from BillPersonPreChargeProductAuthorization a
	inner join BillPersonTransactionPayment b (nolock) on b.Id = a.BillPersonTransactionPaymentId 
	inner join BillPersonTransactionPaymentAuthorizeNet c (nolock) on c.BillPersonTransactionPaymentId = b.Id 
			and c.x_type = 'auth_only' and c.x_response_code = '1'
	left join BillPersonTransactionPaymentAuthorizeNet z (nolock) on z.BillPersonTransactionPaymentId = b.Id and z.Id <> c.Id
where a.AuthorizationStatusCodeId is null and z.Id is null


select * 
--select c.*, a.*
from BillPersonPreChargeProductAuthorization a
where a.AuthorizationStatusCodeId is null

--select z.*, * 
----select c.*, a.*
--from BillPersonPreChargeProductAuthorization a
--inner join BillPersonTransactionPayment b (nolock) on b.Id = a.BillPersonTransactionPaymentId 
--inner join BillPersonTransactionPaymentAuthorizeNet c (nolock) on c.BillPersonTransactionPaymentId = b.Id 
--			and c.x_type = 'auth_only' and c.x_response_code = '1'
--left join BillPersonTransactionPaymentAuthorizeNet z (nolock) on z.BillPersonTransactionPaymentId = b.Id and z.Id <> c.Id
--where a.AuthorizationStatusCodeId is null and z.Id is null