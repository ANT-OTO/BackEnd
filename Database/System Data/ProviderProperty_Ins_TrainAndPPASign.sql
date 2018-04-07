insert ProviderProperty (
	ProviderId,
	PropertyType,
	PropertyName,
	PropertyValue,
	CreateDate,
	LastUpdate
)
select y.Id, 'Train', 'Complete', 'Y', GETUTCDATE(), GETUTCDATE()
-- select *
from (
	select c.Id as Id from ProviderServiceProperty a (nolock)
	join ProviderService b (nolock) on b.Id = a.ProviderServiceId
	join Provider c (nolock) on c.Id = b.ProviderId
	where a.PropertyName = N'ApproveDate' and a.PropertyType = N'Report'
	group by c.Id) y
left join ProviderProperty x on x.ProviderId = y.Id and x.PropertyType = 'Train' and x.PropertyName = 'Complete'
where x.Id is null


insert ProviderProperty (
	ProviderId,
	PropertyType,
	PropertyName,
	PropertyValue,
	CreateDate,
	LastUpdate
)
select y.Id, 'Setup', 'ContractSigned', 'Y', GETUTCDATE(), GETUTCDATE()
-- select *
from (
	select c.Id as Id from ProviderServiceProperty a (nolock)
	join ProviderService b (nolock) on b.Id = a.ProviderServiceId
	join Provider c (nolock) on c.Id = b.ProviderId
	where a.PropertyName = N'ApproveDate' and a.PropertyType = N'Report'
	group by c.Id) y
left join ProviderProperty x on x.ProviderId = y.Id and x.PropertyType = 'Setup' and x.PropertyName = 'ContractSigned'
where x.Id is null
