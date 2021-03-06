--select * from CodeList

declare @TblCode as Table
(
	[Category] [nvarchar](128) NOT NULL,
	[CodeId] [int] NOT NULL,
	[CodeShort] [nvarchar](64) NOT NULL,
	[CodeLong] [nvarchar](256) NOT NULL,
	[SortOrder] [varchar](8) NOT NULL,
	[Available] [bit] NOT NULL
)	



------------------------------------- Begin RequestSituation ------------------------------------- 
--delete [CodeList] where Category = 'RequestSituation'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'RequestSituation' as Category, 1 as CodeId, 'Restaurant' as CodeShort, 'Restaurant' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'RequestSituation' as Category, 2 as CodeId, 'Attactions' as CodeShort, 'Attactions' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'RequestSituation' as Category, 3 as CodeId, 'Hotel' as CodeShort, 'Hotel' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'RequestSituation' as Category, 4 as CodeId, 'Airport' as CodeShort, 'Airport' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'RequestSituation' as Category, 5 as CodeId, 'Taxi' as CodeShort, 'Taxi' as CodeLong, '005' as SortOrder, 1 as Available

	UNION
	
	select 'RequestSituation' as Category, 6 as CodeId, 'Bus' as CodeShort, 'Bus' as CodeLong, '006' as SortOrder, 1 as Available

	UNION
	
	select 'RequestSituation' as Category, 999 as CodeId, 'Other' as CodeShort, 'Other' as CodeLong, '999' as SortOrder, 1 as Available

) a 

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from @TblCode a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

update a
set a.CodeShort = b.CodeShort, a.CodeLong = b.CodeLong, a.SortOrder = b.SortOrder, a.Available = b.Available
from [CodeList] a inner join  @TblCode b on a.Category = b.Category and a.CodeId = b.CodeId 

delete
CodeList where Id in (
	select a.Id from CodeList a left join @TblCode z on a.Category = z.Category and a.CodeId = z.CodeId
	where a.Category = 'RequestSituation' and z.CodeId is null
) 



select * from CodeList where Category = 'RequestSituation'

------------------------------------- End RequestSituation ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)