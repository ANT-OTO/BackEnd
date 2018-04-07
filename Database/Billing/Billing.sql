-- Support ProviderProductCodeId {Request, Interview, DPT}

select * from Provider 

select * from BillProviderPayTermRate

select * from BillPayTerm

--sp_help BillPayTerm

select  *from CodeList

I.
1.BillPayTerm
-- truncate table BillPayTerm
insert BillPayTerm (Name,
	Description,
	ProviderProductCodeId,
	BillActionTimeCodeId,
	RelatedId,
	RelatedTable,
	CurrentlyOffered,
	StartTime,
	EndTime,
	CreateDate,
	LastUpdated)
select 'HOURFEE',
	'Hourly Rate for processing Requests and Interviews based on Payment Agreement',
	1,
	1,
	null,
	null,
	1,
	'7/1/2015',
	null,
	GETUTCDATE(),
	GETUTCDATE()

select * from BillPayTerm


--sp_help BillPayTermDetail

2.BillPayTermDetail

insert BillPayTermDetail(
	BillPayTermId,
	DescTxt,
	UnitTxt,
	QuantityTxt,
	CreateDate)
select 1,
	'Service Fee for #ServiceType# (#StartTime# - #EndTime#)',
	'#Rate# per Hour',
	'Minutes',
	GETUTCDATE()

select * from BillPayTermDetail


--sp_help BillProviderPayTermRate
3. BillProviderPayTermRate

insert BillProviderPayTermRate (ProviderId,
	ProviderServiceId,
	BillPayTermId,
	StartDate,
	EndDate,
	Rate,
	CreateDate,
	PMId,
	Active
)
select b.ProviderId,
	null,
	1,
	min(cast(c.PropertyValue as datetime)),--a.ApprovalDate,
	null,
	45,
	GETUTCDATE(),
	null,
	1
from Provider a join ProviderService b on b.ProviderId = a.Id join ProviderServiceProperty c on c.ProviderServiceId = b.Id--dbo.TempTransactionHistory_20151111 a
left join ProviderProperty d on d.ProviderId = a.Id and d.PropertyType = N'Setup' and (d.PropertyName = N'Test' or d.PropertyName = N'China')
where c.PropertyType = N'Report' and c.PropertyName = N'ApproveDate' and d.Id is null
group by b.ProviderId--c.ApprovalDate


insert BillProviderPayTermRate (ProviderId,
	ProviderServiceId,
	BillPayTermId,
	StartDate,
	EndDate,
	Rate,
	CreateDate,
	PMId,
	Active
)
select a.Id,
	null,
	1,
	min(cast(c.PropertyValue as datetime)),--a.ApprovalDate,
	null,
	0,
	GETUTCDATE(),
	null,
	1
from Provider a join ProviderService b on b.ProviderId = a.Id join ProviderServiceProperty c on c.ProviderServiceId = b.Id
where a.Id in (select ProviderId from ProviderProperty where PropertyType = N'Setup' and PropertyName = N'Test' and PropertyValue = N'Y' group by ProviderId)
and c.PropertyType = N'Report' and c.PropertyName = N'ApproveDate'
group by a.Id


select * from ProviderServiceProperty

select * from BillProviderPayTermRate
-- truncate table BillProviderPayTermRate

II.
1.BillPayTerm
-- truncate table BillPayTerm
insert BillPayTerm (Name,
	Description,
	ProviderProductCodeId,
	BillActionTimeCodeId,
	RelatedId,
	RelatedTable,
	CurrentlyOffered,
	StartTime,
	EndTime,
	CreateDate,
	LastUpdated)
select 'MINMFEE',
	'Minimum Rate per Month for processing Requests and Interviews, based on Payment Agreement',
	1,
	2,
	null,
	null,
	1,
	'7/1/2015',
	null,
	GETUTCDATE(),
	GETUTCDATE()

select * from BillPayTerm


--sp_help BillPayTermDetail

2.BillPayTermDetail

insert BillPayTermDetail(
	BillPayTermId,
	DescTxt,
	UnitTxt,
	QuantityTxt,
	CreateDate)
select 2,
	'Minimum Service Fee for #StartTime# - #EndTime#',
	'#Rate# per Month',
	'N/A',
	GETUTCDATE()

select * from BillPayTermDetail


--sp_help BillProviderPayTermRate
3. BillProviderPayTermRate

/*insert BillProviderPayTermRate (ProviderId,
	ProviderServiceId,
	BillPayTermId,
	StartDate,
	EndDate,
	Rate,
	CreateDate,
	PMId,
	Active
)
select a.ProviderId,
	null,
	1,
	a.ApprovalDate,
	null,
	45,
	GETUTCDATE(),
	null,
	1
from dbo.TempTransactionHistory_20151111 a
group by ProviderId, a.ApprovalDate

insert BillProviderPayTermRate (ProviderId,
	ProviderServiceId,
	BillPayTermId,
	StartDate,
	EndDate,
	Rate,
	CreateDate,
	PMId,
	Active
)
select a.ProviderId,
	null,
	2,
	a.ApprovalDate,
	null,
	10,
	GETUTCDATE(),
	null,
	1
from dbo.TempTransactionHistory_20151111 a
group by ProviderId, a.ApprovalDate*/

insert BillProviderPayTermRate (ProviderId,
	ProviderServiceId,
	BillPayTermId,
	StartDate,
	EndDate,
	Rate,
	CreateDate,
	PMId,
	Active
)
select b.ProviderId,
	null,
	2,
	min(cast(c.PropertyValue as datetime)),--a.ApprovalDate,
	null,
	10,
	GETUTCDATE(),
	null,
	1
from Provider a join ProviderService b on b.ProviderId = a.Id join ProviderServiceProperty c on c.ProviderServiceId = b.Id--dbo.TempTransactionHistory_20151111 a
left join ProviderProperty d on d.ProviderId = a.Id and d.PropertyType = N'Setup' and (d.PropertyName = N'Test' or d.PropertyName = N'China')
where c.PropertyType = N'Report' and c.PropertyName = N'ApproveDate' and d.Id is null
group by b.ProviderId--c.ApprovalDate

select * from BillProviderPayTermRate


-- 
select * from dbo.TempTransactionHistory_20151111
order by ProviderId,  AcceptedTimeLocal

select * from ProviderProperty


-- III. Transactions

sp_help [BillProviderTransactionRequest]

1.
	insert [BillProviderTransactionRequest] (
		ProviderId,
		RequestId,
		PersonId,
		ServiceSeconds,
		AcceptedTime,
		OffsetTime,
		CreateDate
	)
	select a.ProviderId,
			a.RequestId,
			a.PersonId,
			isnull(a.ServiceSeconds,60),
			DATEADD(hour, 5, a.AcceptedTimeLocal),
			null,
			GETUTCDATE()
	from dbo.TempTransactionHistory_20151111 a
	where a.AcceptedTimeLocal is not null
	and DATEADD(second, a.ServiceSeconds,  DATEADD(hour, 5, AcceptedTimeLocal)) <= DATEADD (day, 30, ApprovalDate) 


select  *from [BillProviderTransactionRequest]


sp_help BillProviderTransactionDetail



truncate table BillProviderTransactionRequest
sp_help BillProviderTransactionRequest
3. ????
insert BillProviderTransactionRequest
(
	ProviderId,
	RequestId,
	PersonId,
	ServiceSeconds,
	AcceptedTime,
	OffsetTime,
	CreateDate
)
select a.ProviderId,
	a.RequestId,
	a.PersonId,
	a.ServiceSeconds,
	dateadd(hour, 5, a.AcceptedTimeLocal),
	5,
	GETUTCDATE()
from dbo.TempTransactionHistory_20151111 a
where ServiceSeconds is not null
and DATEADD(second, a.ServiceSeconds, AcceptedTimeLocal) <= DATEADD (day, 30, ApprovalDate)
and not exists (select * from BillProviderTransactionRequest b where b.ProviderId = a.ProviderId and b.RequestId = a.RequestId)

truncate table BillProviderTransaction
sp_help BillProviderTransaction
4. 

select * from Request
select * from RequestProvider
select * from ProviderOpenTaskAcceptLog

select * from RequestProvider where Id = 16320

-- truncate table BillProviderTransaction


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
	1,
	b.Id,
	a.ServiceMinutes,
	b.Rate/60.0,
	round(a.ServiceMinutes*(b.Rate/60.0), 2),
	a.Id,
	'BillProviderTransactionRequest',
	GETUTCDATE()
from  (select a.Id,
	a.ProviderId,
	a.ServiceSeconds/60 + case when  (a.ServiceSeconds/60.0 - a.ServiceSeconds/60) > 0 then 1 else 0 end as ServiceMinutes,
	c.Id as ProviderServiceId,
	a.AcceptedTime
	from BillProviderTransactionRequest a
	join RequestProvider b on b.RequestId = a.RequestId and b.ProviderId = a.ProviderId	
	join ProviderService c on c.Id = b.ProviderServiceId
	--left join ProviderOpenTaskAcceptLog as y on y.RequestProviderId = a.I
	) a
join BillProviderPayTermRate b on b.ProviderId = a.ProviderId and b.BillPayTermId = 1
								and (b.ProviderServiceId = a.ProviderServiceId or b.ProviderServiceId is null)
								and AcceptedTime between b.StartDate and isnull(b.EndDate, dateadd(year, 1, getutcdate()))
								

-- select * from BillProviderTransaction

-- truncate table BillProviderStatement

sp_help BillProviderStatement

5. Statement
--truncate table BillProviderStatement

insert BillProviderStatement (ProviderId,
	StatementDate,
	StartDate,
	EndDate,
	PayableAmount,
	PaidAmount,
	IsCurrent,
	Approved,
	CreateDate)
select c.ProviderId,
	null,
	c.ApprovalDate,
	null,
	0,
	0,
	1,
	1,
	GETUTCDATE()
from --BillProviderTransaction a
--join BillProviderTransactionRequest b on b.ProviderId = a.ProviderId and b.Id = a.SourceTableId and SourceTable = 'BillProviderTransactionRequest'
TempTransactionHistory_20151111 c --on c.ProviderId = a.ProviderId --and c.RequestId = b.RequestId
group by c.ProviderId, c.ApprovalDate

--truncate table BillProviderStatementTransaction

sp_help BillProviderStatementTransaction

6. BillProviderStatementTransaction
--truncate table BillProviderStatementTransaction
insert [BillProviderStatementTransaction](
	[BillProviderStatementId],
	[BillProviderTransactionId],
	[CreateDate])
select a.Id as [BillProviderStatementId],
	b.Id as [BillProviderTransactionId],
	GETUTCDATE()
from BillProviderStatement a
join BillProviderTransaction b on a.ProviderId = b.ProviderId
join (select ProviderId, ApprovalDate from TempTransactionHistory_20151111 group by ProviderId, ApprovalDate) c on c.ProviderId = a.ProviderId
left join BillProviderTransactionRequest w on w.ProviderId = a.ProviderId and b.SourceTableId = w.Id  and SourceTable = 'BillProviderTransactionRequest'
where (b.CreateDate between a.StartDate and a.EndDate) or dateadd(second, w.ServiceSeconds ,w.AcceptedTime) between a.StartDate and a.EndDate

select  *from BillProviderTransactionRequest where ProviderId = 348

select  *from TempTransactionHistory_20151111 where ProviderId = 348

select  *from BillProviderStatement where ProviderId = 348


7. Adjustment

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
	a.BillProviderPayTermRateId,
	1,
	Rate,
	AdjustValue,
	null,
	null,
	GETUTCDATE()
from  ( select a.ProviderId,
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
		where c.AdjustValue is null or c.AdjustValue < b.Rate
) a
		-- and c.ProviderId = a.ProviderId


insert [BillProviderStatementTransaction](
	[BillProviderStatementId],
	[BillProviderTransactionId],
	[CreateDate])
select a.Id as [BillProviderStatementId],
	b.Id as [BillProviderTransactionId],
	GETUTCDATE()
from BillProviderStatement a
join BillProviderTransaction b on a.ProviderId = b.ProviderId
left join [BillProviderStatementTransaction] c on c.BillProviderStatementId = a.Id and c.BillProviderTransactionId = b.Id
where c.Id is null 



--select a.BillProviderStatementId, sum (b.TotalValue) as AdjustValue, b.ProviderId
--from BillProviderStatementTransaction a
--join BillProviderTransaction b on b.Id = a.BillProviderTransactionId
--join BillProviderPayTermRate c on c.Id = b.BillProviderPayTermRateId and c.BillPayTermId = 1



8. Generate New Statement

-- a) Create New Statement

update c
set EndDate = b.EndDate,
	StatementDate = b.EndDate,
	IsCurrent = 0
from (select max(dateadd(hour, 5, a.AcceptedTimeLocal)) as AcceptedTime, a.ProviderId from TempTransactionHistory_20151111 a where AcceptedTimeLocal is not null group by ProviderId) a
join (select max(Id) as StatementId, ProviderId, dateadd(day, 30, max(StartDate)) as EndDate from BillProviderStatement group by ProviderId) b on b.ProviderId = a.ProviderId
join BillProviderStatement c on c.Id = b.StatementId
where b.EndDate <= a.AcceptedTime


insert BillProviderStatement (ProviderId,
	StatementDate,
	StartDate,
	EndDate,
	PayableAmount,
	PaidAmount,
	IsCurrent,
	Approved,
	CreateDate)
select a.ProviderId,
	null,
	a.EndDate,
	null,
	sum(d.TotalValue),
	0,
	1,
	1,
	GETUTCDATE()
from 
	(select a.ProviderId, b.StatementId, b.EndDate
	from (select max(dateadd(hour, 5, a.AcceptedTimeLocal)) as AcceptedTime, a.ProviderId from TempTransactionHistory_20151111 a where AcceptedTimeLocal is not null  group by ProviderId) a
	join (select max(Id) as StatementId, ProviderId, dateadd(day, 30, max(StartDate)) as EndDate from BillProviderStatement group by ProviderId) b on b.ProviderId = a.ProviderId
	group by a.ProviderId, b.EndDate, a.AcceptedTime, b.StatementId
	having b.EndDate <= a.AcceptedTime
	) a
	join BillProviderStatement b on b.Id = a.StatementId
	join BillProviderStatementTransaction c on c.BillProviderStatementId = b.Id
	join BillProviderTransaction d on d.Id = c.BillProviderTransactionId
group by a.ProviderId, a.EndDate

-- b)
	insert [BillProviderTransactionRequest] (
		ProviderId,
		RequestId,
		PersonId,
		ServiceSeconds,
		AcceptedTime,
		OffsetTime,
		CreateDate
	)
	select a.ProviderId,
			a.RequestId,
			a.PersonId,
			isnull(a.ServiceSeconds,60),
			DATEADD(hour, 5, a.AcceptedTimeLocal),
			null,
			GETUTCDATE()
	from dbo.TempTransactionHistory_20151111 a
	where a.AcceptedTimeLocal is not null
	and DATEADD(second, a.ServiceSeconds,  DATEADD(hour, 5, AcceptedTimeLocal)) >= DATEADD (day, 30, ApprovalDate)
	and not exists (select * from BillProviderTransactionRequest b where b.ProviderId = a.ProviderId and b.RequestId = a.RequestId)


insert BillProviderTransactionRequest
(
	ProviderId,
	RequestId,
	PersonId,
	ServiceSeconds,
	AcceptedTime,
	OffsetTime,
	CreateDate
)
select a.ProviderId,
	a.RequestId,
	a.PersonId,
	a.ServiceSeconds,
	dateadd(hour, 5, a.AcceptedTimeLocal),
	5,
	GETUTCDATE()
from dbo.TempTransactionHistory_20151111 a
where ServiceSeconds is not null
and DATEADD(second, a.ServiceSeconds, AcceptedTimeLocal) > DATEADD (day, 30, ApprovalDate)
and not exists (select * from BillProviderTransactionRequest b where b.ProviderId = a.ProviderId and b.RequestId = a.RequestId)


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
	1,
	b.Id,
	a.ServiceMinutes,
	b.Rate/60.0,
	round(a.ServiceMinutes*(b.Rate/60.0), 2),
	a.Id,
	'BillProviderTransactionRequest',
	GETUTCDATE()
from  (select a.Id,
	a.ProviderId,
	a.ServiceSeconds/60 + case when  (a.ServiceSeconds/60.0 - a.ServiceSeconds/60) > 0 then 1 else 0 end as ServiceMinutes,
	c.Id as ProviderServiceId,
	a.AcceptedTime
	from BillProviderTransactionRequest a
	join RequestProvider b on b.RequestId = a.RequestId and b.ProviderId = a.ProviderId	
	join ProviderService c on c.Id = b.ProviderServiceId
	--left join ProviderOpenTaskAcceptLog as y on y.RequestProviderId = a.I
	) a
join BillProviderPayTermRate b on b.ProviderId = a.ProviderId and b.BillPayTermId = 1
								and (b.ProviderServiceId = a.ProviderServiceId or b.ProviderServiceId is null)
								and AcceptedTime between b.StartDate and isnull(b.EndDate, dateadd(year, 1, getutcdate()))
left join BillProviderTransaction w on w.SourceTableId = a.Id
where w.Id is null
			


insert [BillProviderStatementTransaction](
	[BillProviderStatementId],
	[BillProviderTransactionId],
	[CreateDate])
select a.Id as [BillProviderStatementId],
	b.Id as [BillProviderTransactionId],
	GETUTCDATE()
from BillProviderStatement a
join BillProviderTransaction b on a.ProviderId = b.ProviderId
left join [BillProviderStatementTransaction] c on c.BillProviderTransactionId = b.Id
where a.IsCurrent = 1 and c.Id is null 

--a.Id not in (96, 336, 344, 349, 358, 388)

DECLARE	@return_value int,
		@pProviderPropertyId int

declare @pTime datetime

select @pTime = getutcdate()

EXEC	@return_value = [dbo].[sp_ProviderProperty_Set]
		@pProviderId = 96,
		@pPropertyType = N'Setup',
		@pPropertyName = N'Test',
		@pPropertyValue = N'Y',
		@pTime = @pTime,
		@pProviderPropertyId = @pProviderPropertyId OUTPUT

SELECT	@pProviderPropertyId as N'@pProviderPropertyId'

SELECT	'Return Value' = @return_value

select	@return_value = 0,
		@pProviderPropertyId =0


EXEC	@return_value = [dbo].[sp_ProviderProperty_Set]
		@pProviderId = 336,
		@pPropertyType = N'Setup',
		@pPropertyName = N'Test',
		@pPropertyValue = N'Y',
		@pTime = @pTime,
		@pProviderPropertyId = @pProviderPropertyId OUTPUT

SELECT	@pProviderPropertyId as N'@pProviderPropertyId'

SELECT	'Return Value' = @return_value

select	@return_value = 0 ,
		@pProviderPropertyId  = 0


EXEC	@return_value = [dbo].[sp_ProviderProperty_Set]
		@pProviderId = 344,
		@pPropertyType = N'Setup',
		@pPropertyName = N'Test',
		@pPropertyValue = N'Y',
		@pTime = @pTime,
		@pProviderPropertyId = @pProviderPropertyId OUTPUT

SELECT	@pProviderPropertyId as N'@pProviderPropertyId'

SELECT	'Return Value' = @return_value

select	@return_value = 0 ,
		@pProviderPropertyId = 0


EXEC	@return_value = [dbo].[sp_ProviderProperty_Set]
		@pProviderId = 349,
		@pPropertyType = N'Setup',
		@pPropertyName = N'Test',
		@pPropertyValue = N'Y',
		@pTime = @pTime,
		@pProviderPropertyId = @pProviderPropertyId OUTPUT

SELECT	@pProviderPropertyId as N'@pProviderPropertyId'

SELECT	'Return Value' = @return_value

select	@return_value = 0,
		@pProviderPropertyId = 0

EXEC	@return_value = [dbo].[sp_ProviderProperty_Set]
		@pProviderId = 358,
		@pPropertyType = N'Setup',
		@pPropertyName = N'Test',
		@pPropertyValue = N'Y',
		@pTime = @pTime,
		@pProviderPropertyId = @pProviderPropertyId OUTPUT

SELECT	@pProviderPropertyId as N'@pProviderPropertyId'

SELECT	'Return Value' = @return_value

select	@return_value = 0 ,
		@pProviderPropertyId = 0

EXEC	@return_value = [dbo].[sp_ProviderProperty_Set]
		@pProviderId = 388,
		@pPropertyType = N'Setup',
		@pPropertyName = N'Test',
		@pPropertyValue = N'Y',
		@pTime = @pTime,
		@pProviderPropertyId = @pProviderPropertyId OUTPUT

SELECT	@pProviderPropertyId as N'@pProviderPropertyId'

SELECT	'Return Value' = @return_value

declare @tblChina table (ProviderId int)
insert @tblChina
select Id from Provider where Id in (2742,
2743,
2744,
2745,
2746,
2750,
2751,
2753,
2754,
2755,
2758,
2759,
2760,
2762,
2763,
2764,
2765,
2766,
2770,
2776,
2779,
2781,
2784,
2785,
2786,
2788,
2793,
2794,
2804,
2805,
2808,
2809,
2810,
2811,
2812,
2814,
2816,
2817,
2823,
2824)

declare @Id int
declare cur cursor FAST_FORWARD
for select * from @tblChina;

open cur

fetch  next from cur into @Id

while @@fetch_status = 0
begin
	select	@return_value = 0 ,
		@pProviderPropertyId = 0

	EXEC	@return_value = [dbo].[sp_ProviderProperty_Set]
		@pProviderId = @Id,
		@pPropertyType = N'Setup',
		@pPropertyName = N'China',
		@pPropertyValue = N'Y',
		@pTime = @pTime,
		@pProviderPropertyId = @pProviderPropertyId OUTPUT

	fetch  next from cur into @Id
end

CLOSE cur;
DEALLOCATE cur;


--select * from ProviderProperty

---------------------------------------------------------------------------------------

delete BillProviderStatement where PayableAmount > 0

select * from BillProviderStatement where ProviderId = 348

select * from BillProviderTransaction



select * from BillProviderStatementTransaction c where c.BillProviderStatementId = 4

select * from BillProviderTransaction where ProviderId = 348




select DATEDIFF (day, min(ApprovalDate), max(AcceptedTimeLocal))  from TempTransactionHistory_20151111 where AcceptedTimeLocal is not null group by ProviderId  



-- b) Load Data for the new Statement
insert [BillProviderStatementTransaction](
	[BillProviderStatementId],
	[BillProviderTransactionId],
	[CreateDate])
select a.Id as [BillProviderStatementId],
	b.Id as [BillProviderTransactionId],
	GETUTCDATE()
from 
(select  a.ProviderId from BillProviderStatement a join TempTransactionHistory_20151111 b on b.ProviderId = a.ProviderId
--where 
group by a.ProviderId, a.EndDate, b.AcceptedTimeLocal
having a.EndDate < max(b.AcceptedTimeLocal))






select * from BillProviderTransaction

--delete BillProviderTransaction where ProviderBillingTypeCodeId=2

select * from BillProviderPayTermRate


select  *from BillProviderTransaction
select * from BillProviderPayTermRate



select sum(TotalValue) from BillProviderTransaction where ProviderId = 422

select * from BillProviderTransaction where ProviderId = 347

select * from BillProviderTransactionRequest where ProviderId = 347

select  *from TempTransactionHistory_20151111 a left join BillProviderTransactionRequest z on z.RequestId = a.RequestId
where z.Id is null and a.ProviderId = 347

/*
select 60/60 + case when  (60/60.0 - 60/60) > 0 then 1 else 0 end

select case when  (45/60.0 - 45/60) > 0 then 1 else 0 end
select (45/60.0 - 45/60)

select round((45/60.0)*10, 1)

select 45/60.0

select *, ServiceSeconds/60.0
from dbo.TempTransactionHistory_20151111 a where ProviderId = 355


select sum(Quantity), sum(TotalValue) from BillProviderTransaction where ProviderId = 346

*/