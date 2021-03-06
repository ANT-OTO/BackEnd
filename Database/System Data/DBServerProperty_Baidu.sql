--select * from DBServerProperty

declare @TblContent as Table
(
	[PropertyType] [nvarchar](64) NOT NULL,
	[PropertyName] [nvarchar](64) NOT NULL,
	[PropertyValue] [nvarchar](max) NOT NULL
)	



delete @TblContent

-- select * from [DBServerProperty]
insert into @TblContent
(PropertyType, PropertyName, PropertyValue)
select a.*
from (
	select distinct a.*
	from (
		select 'Baidu' as PropertyType, 'TokenURL' as PropertyName, 'https://openapi.baidu.com/oauth/2.0/token' as PropertyValue
	
		UNION

		select 'Baidu' as PropertyType, 'AppId' as PropertyName, '+VfuJTbmdf6dKgMTlw/q1234' as PropertyValue
	
		UNION

		select 'Baidu' as PropertyType, 'AppKey' as PropertyName, 'YaD97OBCb4pfjzswLYAWu5c7TRtKpJzZF2q5zxWj1VznR1AacVY+pfeUef1/nj3iaVETq+z28scrmRaz7rRU1234' as PropertyValue
	
		UNION

		select 'Baidu' as PropertyType, 'SecretKey' as PropertyName, 'GRyzTScOIkhGD6Melz+fSe7G3zJSioeJvUWMNL8PZYOf8VlDr4c5CKfgi5k4iexXA16SaJOvFQS6LROY3gKaA2MIHb4fwpUla1C47yRe1234' as PropertyValue
		
		UNION

		select 'Baidu' as PropertyType, 'ASRURL' as PropertyName, 'http://112.80.255.15/server_api' as PropertyValue

	) a
	
	
) a 

insert into [DBServerProperty]
(PropertyType, PropertyName, PropertyValue, CreateDate, LastUpdate)
select a.*, getutcdate(), getutcdate()
from @TblContent a 
	left join  [DBServerProperty] z on a.PropertyType = z.PropertyType and a.PropertyName = z.PropertyName
where z.Id is null


update a
set a.PropertyValue = b.PropertyValue, a.LastUpdate = getutcdate()
--select a.*
from [DBServerProperty] a 
	inner join  @TblContent b on a.PropertyType = b.PropertyType and a.PropertyName = b.PropertyName 
		and a.PropertyValue <> b.PropertyValue

delete 
--select * from
[DBServerProperty] where PropertyType = 'Baidu' and Id not in (
	select a.Id 
	from [DBServerProperty] a 
		inner join  @TblContent b on a.PropertyType = b.PropertyType and a.PropertyName = b.PropertyName )

select * from DBServerProperty
