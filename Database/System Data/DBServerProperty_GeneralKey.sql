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
		select 'Security' as PropertyType, 'GeneralKey' as PropertyName, convert(nvarchar(64), newid()) as PropertyValue		-- convert(nvarchar(64), newid())
	) a
	
	
) a 

insert into [DBServerProperty]
(PropertyType, PropertyName, PropertyValue, CreateDate, LastUpdate)
select a.*, getutcdate(), getutcdate()
from @TblContent a 
	left join  [DBServerProperty] z on a.PropertyType = z.PropertyType and a.PropertyName = z.PropertyName
where z.Id is null


--update a
--set a.PropertyValue = b.PropertyValue, a.LastUpdate = getutcdate()
----select a.*
--from [DBServerProperty] a 
--	inner join  @TblContent b on a.PropertyType = b.PropertyType and a.PropertyName = b.PropertyName 
--		and a.PropertyValue <> b.PropertyValue

--delete 
----select * from
--[DBServerProperty] where PropertyType = 'Security' and Id not in (
--	select a.Id 
--	from [DBServerProperty] a 
--		inner join  @TblContent b on a.PropertyType = b.PropertyType and a.PropertyName = b.PropertyName )

select * from DBServerProperty where PropertyType = 'Security'
