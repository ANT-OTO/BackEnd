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



------------------------------------- Begin QualityLevel ------------------------------------- 
--delete [CodeList] where Category = 'QualityLevel'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'QualityLevel' as Category, 1 as CodeId, 'Level 3' as CodeShort, 'Level 3 Professional Performance' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'QualityLevel' as Category, 2 as CodeId, 'Level 3+' as CodeShort, 'Level 3+ Professional Performance Plus' as CodeLong, '002' as SortOrder, 1 as Available


	UNION
	
	select 'QualityLevel' as Category, 3 as CodeId, 'Level 4' as CodeShort, 'Level 4 Advanced Professional Performance' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'QualityLevel' as Category, 4 as CodeId, 'Level 4+' as CodeShort, 'Level 4+ Advanced Professional Performance Plus' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'QualityLevel' as Category, 5 as CodeId, 'Level 5' as CodeShort, 'Level 5 Master Performance' as CodeLong, '005' as SortOrder, 1 as Available

	UNION
	
	select 'QualityLevel' as Category, 11 as CodeId, 'Level 2' as CodeShort, 'Level 2 Limited Working Performance' as CodeLong, '0000' as SortOrder, 1 as Available

	UNION
	
	select 'QualityLevel' as Category, 12 as CodeId, 'Level 2+' as CodeShort, 'Level 2+ Limited Working Performance Plus' as CodeLong, '0001' as SortOrder, 1 as Available


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
--select * from
CodeListY where CodeListId in (select Id from CodeList where Category = 'QualityLevel' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'QualityLevel' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'QualityLevel' order by SortOrder


------------------------------------- End Gender ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)

Go