 
select ProviderId,
		ProviderEmail,
		ProviderName,
		ApprovalDate,
		RequestId,
		PersonId,
		Email as PersonEmail, --RequestStatusCodeId, 
	case when EndTime = '1/1/2000' then 60 
		when RequestStatusCodeId in (5, 6) and StartTime = EndTime then 60
		when RequestStatusCodeId <> 3 then datediff(second, StartTime, EndTime) else RequestLogTime end as ServiceSeconds,
	AcceptedTimeLocal 
	--,a.*
--into dbo.TempTransactionHistory_20151111
from 
(
select c.email,
	b.RequestStatusCodeId,
	datediff(second, b.CreateDate, b.LastUpdate) as RequestLogTime, 
	case
		when isnull(y.StartTime, GETUTCDATE()) <= isnull(x.StartDate, GETUTCDATE()) then isnull(y.StartTime, GETUTCDATE())
		else isnull(x.StartDate, GETUTCDATE())
	end as StartTime,
	case
		when isnull(y.FinishTime, '1/1/2000') >= isnull(x.FinishDate, '1/1/2000') then isnull(y.FinishTime, '1/1/2000')
		else isnull(x.FinishDate, '1/1/2000')
	end as EndTime,
	DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), a.AcceptedTime) AS AcceptedTimeLocal,
	b.Id as RequestId,
	a.Id as RequestProviderId,
	a.ProviderId,
	c.Id as PersonId,
	a.AcceptedTime,
	d.ApprovalDate,
	d.ProviderEmail,
	d.ProviderName
from RequestProvider a
	inner join Request b on a.requestId = b.Id
	inner join Person c on b.PersonId = c.Id
	inner join (
		select a.Id as ProviderId, a.Email as ProviderEmail, a.[Name] as ProviderName, b.ApprovalDate
		from Provider a (nolock)
		inner join (
			select ProviderId, min(convert(datetime, a.PropertyValue)) as ApprovalDate
			from ProviderServiceProperty a (nolock) inner join ProviderService b (nolock) on a.ProviderServiceId = b.Id where PropertyType = 'Report' and PropertyName = 'ApproveDate'
			group by ProviderId
		) b on a.Id = b.ProviderId
		where a.PromoCode = '' and dateadd(day, 45, b.ApprovalDate) <= getutcdate() and a.Id not in (96, 336, 344, 349, 358, 388)
	) d on a.ProviderId = d.ProviderId
	left join ProviderOpenTaskAcceptLog as w on w.RequestProviderId = a.Id
	left join TextSession z on a.RequestId = z.RequestId
	left join (
		select a.Id as TextSessionId, case when isnull(z.StartDate, GETUTCDATE()) <= isnull(y.StartDate, GETUTCDATE()) and isnull(z.StartDate, GETUTCDATE()) <= isnull(x.StartDate, GETUTCDATE()) 
							then isnull(z.StartDate, GETUTCDATE())
						when isnull(y.StartDate, GETUTCDATE()) <= isnull(z.StartDate, GETUTCDATE()) and isnull(y.StartDate, GETUTCDATE()) <= isnull(x.StartDate, GETUTCDATE()) 
							then isnull(y.StartDate, GETUTCDATE())
						else isnull(x.StartDate, GETUTCDATE()) end as StartTime,
						case when isnull(z.FinishDate, GETUTCDATE()) >= isnull(y.FinishDate, '1/1/2000') and isnull(z.FinishDate, GETUTCDATE()) >= isnull(x.FinishDate, '1/1/2000') 
							then isnull(z.FinishDate, GETUTCDATE())
						when isnull(y.FinishDate, GETUTCDATE()) >= isnull(z.FinishDate, '1/1/2000') and isnull(y.FinishDate, GETUTCDATE()) >= isnull(x.FinishDate, '1/1/2000') 
							then isnull(y.FinishDate, GETUTCDATE())
						else isnull(x.FinishDate, GETUTCDATE()) end as FinishTime
		from TextSession a (nolock)
			left join (
				select b.TextSessionId, min(a.CreateDate) as StartDate, max(a.CreateDate) as FinishDate  from TextBlockText a (nolock) inner join TextBlock b (nolock) on a.TextBlockId = b.Id
				where FromCaller = 0 and Msg <> ''
				group by b.TextSessionId
			) z on a.Id = z.TextSessionId
			left join (
				select b.TextSessionId, min(a.CreateDate) as StartDate, max(a.CreateDate) as FinishDate  from TextBlockAudio a (nolock) inner join TextBlock b (nolock) on a.TextBlockId = b.Id
				where FromCaller = 0 
				group by b.TextSessionId
				) y on a.Id = y.TextSessionId
			left join (
				select b.TextSessionId, min(a.CreateDate) as StartDate, max(a.CreateDate) as FinishDate  from TextBlockImage a (nolock) inner join TextBlock b (nolock) on a.TextBlockId = b.Id
				where FromCaller = 0 
				group by b.TextSessionId
			) x on a.Id = x.TextSessionId
	) y on z.Id = y.TextSessionId
	left join (
		select RequestId, min(CreateDate) as StartDate, max(LastUpdate) as FinishDate
		from RequestCall 
		group by RequestId) x on a.RequestId = x.RequestId
where (w.Id is not null and w.CreateDate > d.ApprovalDate and w.CreateDate < case when DATEADD (day, 60, d.ApprovalDate) <= getutcdate() then DATEADD (day, 60, d.ApprovalDate) else DATEADD (day, 30, d.ApprovalDate) end) --and a.RequestId = 11963
or (a.AcceptedTime > d.ApprovalDate and a.AcceptedTime < case when DATEADD (day, 60, d.ApprovalDate) <= getutcdate() then DATEADD (day, 60, d.ApprovalDate) else DATEADD (day, 30, d.ApprovalDate) end) --and a.RequestId = 11963

union
-- Provider w/o any Request for the Period
select '', 0, null as RequestLogTime, 
	null as StartTime,
	null as EndTime,
	null AS AcceptedTimeLocal,
	0 as RequestId,
	0 as RequestProviderId,
	a.Id as ProviderId,
	0 as PersonId,
	null as AcceptedTime,
	b.ApprovalDate,
	a.Email as ProviderEmail,
	a.Name as ProviderName
	from Provider a
	inner join (
			select ProviderId, min(convert(datetime, a.PropertyValue)) as ApprovalDate
			from ProviderServiceProperty a (nolock) inner join ProviderService b (nolock) on a.ProviderServiceId = b.Id where PropertyType = 'Report' and PropertyName = 'ApproveDate'
			group by ProviderId
		) b on a.Id = b.ProviderId
	left join RequestProvider c on c.ProviderId = b.ProviderId and b.ApprovalDate < c.CreateDate and c.AcceptedTime is not null 
	where  dateadd(day, 45, b.ApprovalDate) <= getutcdate()  and a.Id not in (96, 336, 344, 349, 358, 388) and c.Id is null) as a
order by ProviderId, AcceptedTimeLocal  --511


select * from dbo.TempTransactionHistory_20151111
order by ProviderId,  AcceptedTimeLocal