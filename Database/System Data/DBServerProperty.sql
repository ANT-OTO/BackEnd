
-- select * from [DBServerProperty]
insert into [DBServerProperty]
(PropertyType, PropertyName, PropertyValue, CreateDate, LastUpdate)
select a.*, GETDATE(), GETDATE()
from (
	select distinct a.*
	from (
		select 'DBName' as PropertyType, 'DBName' as PropertyName, 'WEYIDB001' as PropertyValue
	
		UNION
	
		select 'TimeZone' as PropertyType, 'TimeZone' as PropertyName, 'EST' as PropertyValue

		UNION
	
		select 'Location' as PropertyType, 'Location' as PropertyName, 'USA' as PropertyValue

		UNION
	
		select 'Environment' as PropertyType, 'Type' as PropertyName, 'Dev' as PropertyValue
	) a
	
	
) a left join  [DBServerProperty] z on a.PropertyType = z.PropertyType and a.PropertyName = z.PropertyName
where z.Id is null

select * from DBServerProperty