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



------------------------------------- Begin Recovery ------------------------------------- 
--delete [CodeList] where Category = 'Recovery'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'Recovery' as Category, 1 as CodeId, 'Interviewer In Waiting' as CodeShort, 'Interviewer In Waiting' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'Recovery' as Category, 2 as CodeId, 'Interviewer In Service' as CodeShort, 'Interviewer In Service' as CodeLong, '002' as SortOrder, 1 as Available
	
	UNION
	
	select 'Recovery' as Category, 3 as CodeId, 'Interviewer to Survey' as CodeShort, 'Interviewer to Survey' as CodeLong, '003' as SortOrder, 1 as Available
	
	UNION

	select 'Recovery' as Category, 4 as CodeId, 'Candidate In Waiting' as CodeShort, 'Candidate In Waiting' as CodeLong, '004' as SortOrder, 1 as Available
	
	UNION
	
	select 'Recovery' as Category, 5 as CodeId, 'Candidate In Service' as CodeShort, 'Candidate In Service' as CodeLong, '005' as SortOrder, 1 as Available
	
	UNION

	select 'Recovery' as Category, 6 as CodeId, 'Candidate to Survey' as CodeShort, 'Candidate to Survey' as CodeLong, '006' as SortOrder, 1 as Available
	
	UNION
	
	select 'Recovery' as Category, 7 as CodeId, 'Provider In Waiting' as CodeShort, 'Provider In Waiting' as CodeLong, '007' as SortOrder, 1 as Available

	UNION
	
	select 'Recovery' as Category, 8 as CodeId, 'Provider In Service' as CodeShort, 'Provider In Service' as CodeLong, '008' as SortOrder, 1 as Available
	
	UNION

	select 'Recovery' as Category, 9 as CodeId, 'Provider to Survey' as CodeShort, 'Provider to Survey' as CodeLong, '009' as SortOrder, 1 as Available

	UNION

	select 'Recovery' as Category, 10 as CodeId, 'DPT' as CodeShort, 'DPT' as CodeLong, '010' as SortOrder, 1 as Available


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
CodeListY where CodeListId in (select Id from CodeList where Category = 'Recovery' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'Recovery' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'Recovery' order by SortOrder
select * from CodeListY where CodeListId in (
select Id from CodeList where Category = 'Recovery'
) 
order by SystemLanguageId, CodeListId


------------------------------------- End Recovery ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)