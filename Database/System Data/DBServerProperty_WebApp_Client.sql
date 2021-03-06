
-- select * from [DBServerProperty]
insert into [DBServerProperty]
(PropertyType, PropertyName, PropertyValue, CreateDate, LastUpdate)
select a.*, GETDATE(), GETDATE()
from (
	select distinct a.*
	from (
		select 'WEYIClient' as PropertyType, 'WEYIClient' as PropertyName, 'https://www.weyi.co/Client/' as PropertyValue
	) a
	
	
) a left join  [DBServerProperty] z on a.PropertyType = z.PropertyType and a.PropertyName = z.PropertyName
where z.Id is null

select * from DBServerProperty