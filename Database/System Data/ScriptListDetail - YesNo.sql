--select * from ScriptList


declare @ScriptListId int = 0

select @ScriptListId = a.Id
--select *
from ScriptList a 
where a.ListName = 'YesNo' and a.Deleted = 0

if( @ScriptListId <= 0)
begin
	return
end

declare @TblCode as Table
(
	ItemValue nvarchar(64) NOT NULL,
	ItemContent nvarchar(1024) NOT NULL,
	AdditionalInfo1 nvarchar(max) NULL,
	AdditionalInfo2 nvarchar(max) NULL,
	AdditionalInfo3 nvarchar(max) NULL,
	AdditionalInfo4 nvarchar(max) NULL,
	SortOrder varchar(8) NOT NULL,
	Available bit NOT NULL
)	



------------------------------------- Begin  ------------------------------------- 

delete @TblCode

insert into @TblCode	
(ItemValue, ItemContent, AdditionalInfo1, AdditionalInfo2, AdditionalInfo3, AdditionalInfo4, SortOrder, Available)
select distinct a.*
from (
	select 'Yes' as ItemValue, 'Yes' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
		'001' as SortOrder, 1 as Available
	
	UNION
	
	select 'No' as ItemValue, 'No' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
		'002' as SortOrder, 1 as Available

) a 

insert into ScriptListDetail
(ScriptListId, ItemValue, ItemContent, AdditionalInfo1, AdditionalInfo2, AdditionalInfo3, AdditionalInfo4, SortOrder, Available)
select @ScriptListId, a.*
from @TblCode a left join  ScriptListDetail z on z.ScriptListId = @ScriptListId and z.ItemValue = a.ItemValue
where z.Id is null

update a
set a.ItemContent = b.ItemContent, a.AdditionalInfo1 = b.AdditionalInfo1, a.AdditionalInfo2 = b.AdditionalInfo2
	, a.AdditionalInfo3 = b.AdditionalInfo3, a.AdditionalInfo4 = b.AdditionalInfo4
	, a.SortOrder = b.SortOrder, a.Available = b.Available
	, a.LastUpdate = GETUTCDATE()
from ScriptListDetail a inner join  @TblCode b on a.ScriptListId = @ScriptListId and a.ItemValue = b.ItemValue

delete 
--select * from
ScriptListDetail where ScriptListId = @ScriptListId and ItemValue not in (select ItemValue from @TblCode)

select * from ScriptListDetail  where ScriptListId = @ScriptListId


------------------------------------- End  ------------------------------------- 

go

