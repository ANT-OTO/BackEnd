
-- select * from [DBServerProperty]
insert into [DBServerProperty]
(PropertyType, PropertyName, PropertyValue, CreateDate, LastUpdate)
select a.*, GETDATE(), GETDATE()
from (
	select distinct a.*
	from (
		select 'WEYISupport' as PropertyType, 'WEYISupport' as PropertyName, 'https://www.weyimobile.com/WEYISupport/' as PropertyValue
	
		UNION
	
		select 'WEYIAPI' as PropertyType, 'WEYIAPI' as PropertyName, 'https://www.weyimobile.com/api/' as PropertyValue

		UNION
	
		select 'WEYIProvider' as PropertyType, 'WEYIProvider' as PropertyName, 'https://www.weyimobile.com/Provider/' as PropertyValue
	) a
	
	
) a left join  [DBServerProperty] z on a.PropertyType = z.PropertyType and a.PropertyName = z.PropertyName
where z.Id is null

select * from DBServerProperty