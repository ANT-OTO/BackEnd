
-- select * from [DBServerProperty]
insert into [DBServerProperty]
(PropertyType, PropertyName, PropertyValue, CreateDate, LastUpdate)
select a.*, GETDATE(), GETDATE()
from (
	select distinct a.*
	from (
		select 'Security' as PropertyType, 'CreditCardKey' as PropertyName, convert(nvarchar(64), newid()) as PropertyValue
	
	) a
	
	
) a left join  [DBServerProperty] z on a.PropertyType = z.PropertyType and a.PropertyName = z.PropertyName
where z.Id is null

select * from DBServerProperty