--select * from ScriptList

declare @TblCode as Table
(
	CompanyId int NULL,
	ListName nvarchar(128) NOT NULL,
	Deleted bit NOT NULL
)	



------------------------------------- Begin  ------------------------------------- 

delete @TblCode

insert into @TblCode	
(CompanyId, ListName, Deleted)
select distinct a.*
from (
	select NULL as CompanyId, 'TargetLanguage' as ListName, 0 as Deleted
	
	UNION
	
	select NULL as CompanyId, 'YesNo' as ListName, 0 as Deleted
	
	UNION
	
	select NULL as CompanyId, 'TargetLanguageSelfOrOperator' as ListName, 0 as Deleted

	UNION

	select NULL as CompanyId, 'IU - CDCR-CCHCS' as ListName, 0 as Deleted
) a 

insert into ScriptList
(CompanyId, ListName, Deleted)
select a.*
from @TblCode a left join  ScriptList z on isnull(a.CompanyId, 0) = isnull(z.CompanyId, 0) and a.ListName = z.ListName
where z.Id is null

update a
set a.Deleted = b.Deleted
	, a.LastUpdate = GETUTCDATE()
from ScriptList a inner join  @TblCode b on isnull(a.CompanyId, 0) = isnull(b.CompanyId, 0) and a.ListName = b.ListName

delete 
--select * from
ScriptList where isnull(CompanyId, 0) = 0 and ListName not in (select ListName from @TblCode)

select * from ScriptList


------------------------------------- End  ------------------------------------- 

go

