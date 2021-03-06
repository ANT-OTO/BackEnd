declare @Tbl_DBServerProperty as table
(
	[PropertyType] [nvarchar](64) NOT NULL,
	[PropertyName] [nvarchar](64) NOT NULL,
	[PropertyValue] [nvarchar](max) NOT NULL
)


insert into @Tbl_DBServerProperty
(PropertyType, PropertyName, PropertyValue)
select a.*
from (
	select distinct a.*
	from (
		select 'WEYIProvider' as PropertyType, 'WEYIProvider' as PropertyName, 'https://www.weyivideo.com/Provider/' as PropertyValue
	
		UNION
	
		select 'WEYIClient' as PropertyType, 'WEYIClient' as PropertyName, 'https://www.weyivideo.com/Client/' as PropertyValue
	) a
	
	
) a 

-- select * from [DBServerProperty]

insert into DBServerProperty
(PropertyType, PropertyName, PropertyValue, CreateDate, LastUpdate)
select a.*, GETUTCDATE(), GETUTCDATE()
from @Tbl_DBServerProperty a
	left join  [DBServerProperty] z on a.PropertyType = z.PropertyType and a.PropertyName = z.PropertyName
where z.Id is null

update b
set b.PropertyValue = a.PropertyValue
	, b.LastUpdate = getutcdate()
from @Tbl_DBServerProperty a
	inner join  [DBServerProperty] b on a.PropertyType = b.PropertyType and a.PropertyName = b.PropertyName
where b.PropertyValue <> a.PropertyValue

select * from DBServerProperty

go

