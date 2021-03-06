--select * from CodeList

declare @TblCode as Table
(
	[Category] [nvarchar](128) NOT NULL,
	[CodeId] [int] NOT NULL,
	[CodeShort] [nvarchar](64) NOT NULL,
	[CodeLong] [nvarchar](256) NOT NULL,
	[SortOrder] [varchar](8) NOT NULL,
	[Available] [bit] NOT NULL
)	




------------------------------------- Begin ProviderBillingType ------------------------------------- 
--delete [CodeList] where Category = 'ProviderBillingType'

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
--New, Accepted, In Process, Finished, Cancelled
	select 'ProviderBillingType' as Category, 1 as CodeId, 'Service Fee' as CodeShort, 'Service Fee' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderBillingType' as Category, 2 as CodeId, 'Payment' as CodeShort, 'Payment' as CodeLong, '002' as SortOrder, 1 as Available
	

	
	
) a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

select * from CodeList where Category = 'ProviderBillingType'

------------------------------------- End ProviderBillingType ------------------------------------- 



------------------------------------- Begin PersonBillingType ------------------------------------- 
--delete [CodeList] where Category = 'PersonBillingType'

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
--New, Accepted, In Process, Finished, Cancelled
	select 'PersonBillingType' as Category, 1 as CodeId, 'Credit' as CodeShort, 'Credit' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'PersonBillingType' as Category, 2 as CodeId, 'Charge' as CodeShort, 'Charge' as CodeLong, '002' as SortOrder, 1 as Available
	
	UNION
	
	select 'PersonBillingType' as Category, 3 as CodeId, 'Payment' as CodeShort, 'Payment' as CodeLong, '003' as SortOrder, 1 as Available
	
	UNION
	
	select 'PersonBillingType' as Category, 4 as CodeId, 'Refund' as CodeShort, 'Refund' as CodeLong, '004' as SortOrder, 1 as Available
	

	
	
) a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

select * from CodeList where Category = 'PersonBillingType'

------------------------------------- End PersonBillingType ------------------------------------- 




------------------------------------- Begin CallType ------------------------------------- 
--delete [CodeList] where Category = 'CallType'

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
--New, Accepted, In Process, Finished, Cancelled
	select 'CallType' as Category, 1 as CodeId, 'Voice' as CodeShort, 'Voice Call' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'CallType' as Category, 2 as CodeId, 'Video' as CodeShort, 'Video Call' as CodeLong, '002' as SortOrder, 1 as Available
	
	
) a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

select * from CodeList where Category = 'CallType'

------------------------------------- End CallType ------------------------------------- 





------------------------------------- Begin InterviewProviderStatus ------------------------------------- 
--delete [CodeList] where Category = 'InterviewProviderStatus'

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
--New, Accepted, In Process, Finished, Cancelled
	select 'InterviewProviderStatus' as Category, 1 as CodeId, 'New' as CodeShort, 'New' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'InterviewProviderStatus' as Category, 2 as CodeId, 'Sent' as CodeShort, 'Sent' as CodeLong, '002' as SortOrder, 1 as Available
	
	UNION
	
	select 'InterviewProviderStatus' as Category, 3 as CodeId, 'Received' as CodeShort, 'Received' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'InterviewProviderStatus' as Category, 4 as CodeId, 'Accepted' as CodeShort, 'Accepted' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'InterviewProviderStatus' as Category, 5 as CodeId, 'Confirmed' as CodeShort, 'Confirmed' as CodeLong, '005' as SortOrder, 1 as Available
	
) a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

select * from CodeList where Category = 'InterviewProviderStatus'

------------------------------------- End InterviewProviderStatus ------------------------------------- 



------------------------------------- Begin RequestProviderStatus ------------------------------------- 
--delete [CodeList] where Category = 'RequestProviderStatus'

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
--New, Accepted, In Process, Finished, Cancelled
	select 'RequestProviderStatus' as Category, 1 as CodeId, 'New' as CodeShort, 'New' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'RequestProviderStatus' as Category, 2 as CodeId, 'Sent' as CodeShort, 'Sent' as CodeLong, '002' as SortOrder, 1 as Available
	
	UNION
	
	select 'RequestProviderStatus' as Category, 3 as CodeId, 'Received' as CodeShort, 'Received' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'RequestProviderStatus' as Category, 4 as CodeId, 'Accepted' as CodeShort, 'Accepted' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'RequestProviderStatus' as Category, 5 as CodeId, 'Confirmed' as CodeShort, 'Confirmed' as CodeLong, '005' as SortOrder, 1 as Available
	
) a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

select * from CodeList where Category = 'RequestProviderStatus'

------------------------------------- End RequestProviderStatus ------------------------------------- 



------------------------------------- Begin ProviderPaymentMethod ------------------------------------- 
--delete [CodeList] where Category = 'ProviderPaymentMethod'

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
--New, Accepted, In Process, Finished, Cancelled
	select 'ProviderPaymentMethod' as Category, 1 as CodeId, 'Check' as CodeShort, 'Check' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderPaymentMethod' as Category, 2 as CodeId, 'PayPal' as CodeShort, 'PayPal' as CodeLong, '002' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderPaymentMethod' as Category, 3 as CodeId, 'ACH' as CodeShort, 'ACH' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderPaymentMethod' as Category, 4 as CodeId, 'Wire' as CodeShort, 'Wire' as CodeLong, '004' as SortOrder, 1 as Available

	
) a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

select * from CodeList where Category = 'ProviderPaymentMethod'

------------------------------------- End ProviderPaymentMethod ------------------------------------- 



------------------------------------- Begin PersonPaymentMethod ------------------------------------- 
--delete [CodeList] where Category = 'PersonPaymentMethod'

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
--New, Accepted, In Process, Finished, Cancelled
	select 'PersonPaymentMethod' as Category, 1 as CodeId, 'Credit Card' as CodeShort, 'Credit Card' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'PersonPaymentMethod' as Category, 2 as CodeId, 'PayPal' as CodeShort, 'PayPal' as CodeLong, '002' as SortOrder, 1 as Available
	
	
) a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

select * from CodeList where Category = 'PersonPaymentMethod'

------------------------------------- End PersonPaymentMethod ------------------------------------- 




------------------------------------- Begin ProviderServiceApplicationStatus ------------------------------------- 
--delete [CodeList] where Category = 'ProviderServiceApplicationStatus'

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
--New, Accepted, In Process, Finished, Cancelled
	select 'ProviderServiceApplicationStatus' as Category, 1 as CodeId, 'Pending Interview' as CodeShort, 'Pending Interview' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderServiceApplicationStatus' as Category, 2 as CodeId, 'Approved' as CodeShort, 'Approved' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderServiceApplicationStatus' as Category, 3 as CodeId, 'Denied' as CodeShort, 'Denied' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderServiceApplicationStatus' as Category, 4 as CodeId, 'Cancelled' as CodeShort, 'Cancelled' as CodeLong, '004' as SortOrder, 1 as Available
	
	
) a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

select * from CodeList where Category = 'ProviderServiceApplicationStatus'

------------------------------------- End ProviderServiceApplicationStatus ------------------------------------- 




------------------------------------- Begin ProviderScheduleAvailable ------------------------------------- 
--delete [CodeList] where Category = 'ProviderScheduleAvailable'

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
--New, Accepted, In Process, Finished, Cancelled
	select 'ProviderScheduleAvailable' as Category, 1 as CodeId, 'Available' as CodeShort, 'Available' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderScheduleAvailable' as Category, 2 as CodeId, 'Available as Alternative' as CodeShort, 'Available as Alternative' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderScheduleAvailable' as Category, 3 as CodeId, 'Not Available' as CodeShort, 'Not Available' as CodeLong, '003' as SortOrder, 1 as Available
	
	
) a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

select * from CodeList where Category = 'ProviderScheduleAvailable'

------------------------------------- End ProviderScheduleAvailable ------------------------------------- 




------------------------------------- Begin ProviderTodayScheduleOption ------------------------------------- 
--delete [CodeList] where Category = 'ProviderTodayScheduleOption'
delete @TblCode


insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'ProviderTodayScheduleOption' as Category, 1 as CodeId, 'I am available today' as CodeShort, 'I am available today' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderTodayScheduleOption' as Category, 2 as CodeId, 'I am available for the rest of today' as CodeShort, 'I am available for the rest of today' as CodeLong, '002' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderTodayScheduleOption' as Category, 3 as CodeId, 'I serve as alternative today' as CodeShort, 'I serve as alternative today' as CodeLong, '003' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderTodayScheduleOption' as Category, 4 as CodeId, 'I serve as alternative for the rest of today' as CodeShort, 'I serve as alternative for the rest of today' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderTodayScheduleOption' as Category, 5 as CodeId, 'I am not available for the rest of today' as CodeShort, 'I am not available for the rest of today' as CodeLong, '005' as SortOrder, 1 as Available
	
) a 

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from @TblCode a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

update a
set a.CodeShort = b.CodeShort, a.CodeLong = b.CodeLong, a.SortOrder = b.SortOrder, a.Available = b.Available
from [CodeList] a inner join  @TblCode b on a.Category = b.Category and a.CodeId = b.CodeId 

delete 
--select * from
CodeList where Category = 'ProviderTodayScheduleOption' and CodeId not in (select CodeId from @TblCode)


select * from CodeList where Category = 'ProviderTodayScheduleOption'

------------------------------------- End ProviderTodayScheduleOption ------------------------------------- 





------------------------------------- Begin ProviderScheduleDaysType ------------------------------------- 
--delete [CodeList] where Category = 'ProviderScheduleDaysType'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'ProviderScheduleDaysType' as Category, 1 as CodeId, 'Everyday in the date range' as CodeShort, 'All Days' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderScheduleDaysType' as Category, 2 as CodeId, 'Available Days Only' as CodeShort, 'Available Days Only' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderScheduleDaysType' as Category, 3 as CodeId, 'Not Available Days Only' as CodeShort, 'Not Available Days Only' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderScheduleDaysType' as Category, 4 as CodeId, 'Monday Only' as CodeShort, 'Monday Only' as CodeLong, '004' as SortOrder, 1 as Available


	UNION
	
	select 'ProviderScheduleDaysType' as Category, 5 as CodeId, 'Tuesday Only' as CodeShort, 'Tuesday Only' as CodeLong, '005' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderScheduleDaysType' as Category, 6 as CodeId, 'Wednesday Only' as CodeShort, 'Wednesday Only' as CodeLong, '006' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderScheduleDaysType' as Category, 7 as CodeId, 'Thursday Only' as CodeShort, 'Thursday Only' as CodeLong, '007' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderScheduleDaysType' as Category, 8 as CodeId, 'Friday Only' as CodeShort, 'Friday Only' as CodeLong, '008' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderScheduleDaysType' as Category, 9 as CodeId, 'Saturday Only' as CodeShort, 'Saturday Only' as CodeLong, '009' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderScheduleDaysType' as Category, 10 as CodeId, 'Sunday Only' as CodeShort, 'Sunday Only' as CodeLong, '010' as SortOrder, 1 as Available

) a 

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from @TblCode a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

update a
set a.CodeShort = b.CodeShort, a.CodeLong = b.CodeLong, a.SortOrder = b.SortOrder, a.Available = b.Available
from [CodeList] a inner join  @TblCode b on a.Category = b.Category and a.CodeId = b.CodeId 

select * from CodeList where Category = 'ProviderScheduleDaysType'

------------------------------------- End ProviderScheduleDaysType ------------------------------------- 




------------------------------------- Begin ProviderScheduleHoursType ------------------------------------- 
delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'ProviderScheduleHoursType' as Category, 1 as CodeId, '24 Hours a Day' as CodeShort, '24 Hours a Day' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderScheduleHoursType' as Category, 2 as CodeId, 'Available Hours Only' as CodeShort, 'Available Hours Only' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderScheduleHoursType' as Category, 3 as CodeId, 'Not Available Hours Only' as CodeShort, 'Not Available Hours Only' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderScheduleHoursType' as Category, 4 as CodeId, 'User Defined' as CodeShort, 'User Defined' as CodeLong, '004' as SortOrder, 1 as Available
	
	
) a


insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from @TblCode a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

update a
set a.CodeShort = b.CodeShort, a.CodeLong = b.CodeLong, a.SortOrder = b.SortOrder, a.Available = b.Available
from [CodeList] a inner join  @TblCode b on a.Category = b.Category and a.CodeId = b.CodeId 

delete @TblCode


select * from CodeList where Category = 'ProviderScheduleHoursType'

------------------------------------- End ProviderScheduleHoursType ------------------------------------- 




------------------------------------- Begin DescrCategory ------------------------------------- 
--delete [CodeList] where Category = 'DescrCategory'

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
--New, Accepted, In Process, Finished, Cancelled
	select 'DescrCategory' as Category, 1 as CodeId, 'PersonBilling' as CodeShort, 'PersonBilling' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'DescrCategory' as Category, 2 as CodeId, 'PersonService' as CodeShort, 'PersonService' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'DescrCategory' as Category, 101 as CodeId, 'ProviderBilling' as CodeShort, 'ProviderBilling' as CodeLong, '101' as SortOrder, 1 as Available

	UNION
	
	select 'DescrCategory' as Category, 102 as CodeId, 'ProviderService' as CodeShort, 'ProviderService' as CodeLong, '102' as SortOrder, 1 as Available
	
	
) a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

select * from CodeList where Category = 'DescrCategory'

------------------------------------- End DescrCategory ------------------------------------- 





------------------------------------- Begin RequestStatus ------------------------------------- 
--delete [CodeList] where Category = 'RequestStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'RequestStatus' as Category, 1 as CodeId, 'New' as CodeShort, 'New' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'RequestStatus' as Category, 2 as CodeId, 'In Service' as CodeShort, 'In Service' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'RequestStatus' as Category, 3 as CodeId, 'Serviced' as CodeShort, 'Serviced' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'RequestStatus' as Category, 4 as CodeId, 'Cancelled' as CodeShort, 'Cancelled' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'RequestStatus' as Category, 5 as CodeId, 'Cancelled After Failed Service' as CodeShort, 'Cancelled After Failed Service' as CodeLong, '005' as SortOrder, 1 as Available

	UNION
	
	select 'RequestStatus' as Category, 6 as CodeId, 'In Service Cleared' as CodeShort, 'In Service Cleared By Force' as CodeLong, '006' as SortOrder, 1 as Available

) a 

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from @TblCode a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

update a
set a.CodeShort = b.CodeShort, a.CodeLong = b.CodeLong, a.SortOrder = b.SortOrder, a.Available = b.Available
from [CodeList] a inner join  @TblCode b on a.Category = b.Category and a.CodeId = b.CodeId 

delete 
--select * from
CodeList where Category = 'RequestStatus' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'RequestStatus'

------------------------------------- End RequestStatus ------------------------------------- 






------------------------------------- Begin SessionStatus ------------------------------------- 
delete [CodeList] where Category = 'SessionStatus'

--insert into [CodeList]
--(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
--select a.*
--from (
--New, Accepted, In Process, Finished, Cancelled
--	select 'SessionStatus' as Category, 1 as CodeId, 'LoggedIn' as CodeShort, 'LoggedIn' as CodeLong, '001' as SortOrder, 1 as Available
	
--	UNION
	
--	select 'SessionStatus' as Category, 2 as CodeId, 'Registration' as CodeShort, 'Registration' as CodeLong, '002' as SortOrder, 1 as Available

	
	
--) a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
--where z.Id is null

--select * from CodeList where Category = 'SessionStatus'

------------------------------------- End SessionStatus ------------------------------------- 


------------------------------------- Begin LanguageProficiency ------------------------------------- 
--delete [CodeList] where Category = 'LanguageProficiency'

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
--New, Accepted, In Process, Finished, Cancelled
	select 'LanguageProficiency' as Category, 1 as CodeId, 'Native' as CodeShort, 'Native' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'LanguageProficiency' as Category, 2 as CodeId, 'Near Native/fluent' as CodeShort, 'Near Native / fluent' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'LanguageProficiency' as Category, 3 as CodeId, 'Highly Proficient' as CodeShort, 'Highly Proficient' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'LanguageProficiency' as Category, 4 as CodeId, 'Very good command' as CodeShort, 'Very good command' as CodeLong, '004' as SortOrder, 1 as Available
	
	
) a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

select * from CodeList where Category = 'LanguageProficiency'

------------------------------------- End LanguageProficiency ------------------------------------- 




------------------------------------- Begin WeekDay ------------------------------------- 
--delete [CodeList] where Category = 'WeekDay'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'WeekDay' as Category, 1 as CodeId, 'Monday' as CodeShort, 'Monday' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'WeekDay' as Category, 2 as CodeId, 'Tuesday' as CodeShort, 'Tuesday' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'WeekDay' as Category, 3 as CodeId, 'Wednesday' as CodeShort, 'Wednesday' as CodeLong, '003' as SortOrder, 1 as Available
	
	UNION
	
	select 'WeekDay' as Category, 4 as CodeId, 'Thursday' as CodeShort, 'Thursday' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'WeekDay' as Category, 5 as CodeId, 'Friday' as CodeShort, 'Friday' as CodeLong, '005' as SortOrder, 1 as Available

	UNION
	
	select 'WeekDay' as Category, 6 as CodeId, 'Saturday' as CodeShort, 'Saturday' as CodeLong, '006' as SortOrder, 1 as Available

	UNION
	
	select 'WeekDay' as Category, 7 as CodeId, 'Sunday' as CodeShort, 'Sunday' as CodeLong, '007' as SortOrder, 1 as Available

) a 

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from @TblCode a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

update a
set a.CodeShort = b.CodeShort, a.CodeLong = b.CodeLong, a.SortOrder = b.SortOrder, a.Available = b.Available
from [CodeList] a inner join  @TblCode b on a.Category = b.Category and a.CodeId = b.CodeId 

select * from CodeList where Category = 'WeekDay'

------------------------------------- End WeekDay ------------------------------------- 





------------------------------------- Begin AroundToday ------------------------------------- 
--delete [CodeList] where Category = 'AroundToday'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'AroundToday' as Category, 1 as CodeId, 'Today' as CodeShort, 'Today' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'AroundToday' as Category, 2 as CodeId, 'Tomorrow' as CodeShort, 'Tomorrow' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'AroundToday' as Category, 3 as CodeId, 'Yesterday' as CodeShort, 'Yesterday' as CodeLong, '003' as SortOrder, 1 as Available
) a 

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from @TblCode a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

update a
set a.CodeShort = b.CodeShort, a.CodeLong = b.CodeLong, a.SortOrder = b.SortOrder, a.Available = b.Available
from [CodeList] a inner join  @TblCode b on a.Category = b.Category and a.CodeId = b.CodeId 

select * from CodeList where Category = 'AroundToday'

------------------------------------- End AroundToday ------------------------------------- 







------------------------------------- Begin RequestProviderCallStatus ------------------------------------- 
--delete [CodeList] where Category = 'RequestProviderCallStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'RequestProviderCallStatus' as Category, 1 as CodeId, 'New' as CodeShort, 'New' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'RequestProviderCallStatus' as Category, 2 as CodeId, 'Listener Account Number Ready' as CodeShort, 'Listener Account Number Ready' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'RequestProviderCallStatus' as Category, 3 as CodeId, 'Listening' as CodeShort, 'Listening' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'RequestProviderCallStatus' as Category, 4 as CodeId, 'Caller Account Number Ready' as CodeShort, 'Caller Account Number Ready' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'RequestProviderCallStatus' as Category, 5 as CodeId, 'Calling' as CodeShort, 'Calling' as CodeLong, '005' as SortOrder, 1 as Available

	UNION
	
	select 'RequestProviderCallStatus' as Category, 6 as CodeId, 'Disconnected' as CodeShort, 'Disconnected' as CodeLong, '006' as SortOrder, 1 as Available

) a 

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from @TblCode a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

update a
set a.CodeShort = b.CodeShort, a.CodeLong = b.CodeLong, a.SortOrder = b.SortOrder, a.Available = b.Available
from [CodeList] a inner join  @TblCode b on a.Category = b.Category and a.CodeId = b.CodeId 

select * from CodeList where Category = 'RequestProviderCallStatus'

------------------------------------- End RequestProviderCallStatus ------------------------------------- 




------------------------------------- Begin InterviewProviderCallStatus ------------------------------------- 
--delete [CodeList] where Category = 'InterviewProviderCallStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'InterviewProviderCallStatus' as Category, 1 as CodeId, 'New' as CodeShort, 'New' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'InterviewProviderCallStatus' as Category, 2 as CodeId, 'Listener Account Number Ready' as CodeShort, 'Listener Account Number Ready' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'InterviewProviderCallStatus' as Category, 3 as CodeId, 'Listening' as CodeShort, 'Listening' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'InterviewProviderCallStatus' as Category, 4 as CodeId, 'Caller Account Number Ready' as CodeShort, 'Caller Account Number Ready' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'InterviewProviderCallStatus' as Category, 5 as CodeId, 'Calling' as CodeShort, 'Calling' as CodeLong, '005' as SortOrder, 1 as Available

	UNION
	
	select 'InterviewProviderCallStatus' as Category, 6 as CodeId, 'Disconnected' as CodeShort, 'Disconnected' as CodeLong, '006' as SortOrder, 1 as Available

) a 

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from @TblCode a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

update a
set a.CodeShort = b.CodeShort, a.CodeLong = b.CodeLong, a.SortOrder = b.SortOrder, a.Available = b.Available
from [CodeList] a inner join  @TblCode b on a.Category = b.Category and a.CodeId = b.CodeId 

select * from CodeList where Category = 'InterviewProviderCallStatus'

------------------------------------- End InterviewProviderCallStatus ------------------------------------- 



delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)