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



------------------------------------- Begin ScheduleDaysType ------------------------------------- 
--delete [CodeList] where Category = 'ScheduleDaysType'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'ScheduleDaysType' as Category, 1 as CodeId, 'Yes, Every Day' as CodeShort, 'Yes, Every Day' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'ScheduleDaysType' as Category, 2 as CodeId, 'Yes, Business Day Only' as CodeShort, 'Yes, Business Day Only' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'ScheduleDaysType' as Category, 3 as CodeId, 'Yes, Weekend/Holiday Only' as CodeShort, 'Yes, Weekend/Holiday Only' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'ScheduleDaysType' as Category, 4 as CodeId, 'Yes, Monday Only' as CodeShort, 'Yes, Monday Only' as CodeLong, '004' as SortOrder, 1 as Available


	UNION
	
	select 'ScheduleDaysType' as Category, 5 as CodeId, 'Yes, Tuesday Only' as CodeShort, 'Yes, Tuesday Only' as CodeLong, '005' as SortOrder, 1 as Available

	UNION
	
	select 'ScheduleDaysType' as Category, 6 as CodeId, 'Yes, Wednesday Only' as CodeShort, 'Yes, Wednesday Only' as CodeLong, '006' as SortOrder, 1 as Available

	UNION
	
	select 'ScheduleDaysType' as Category, 7 as CodeId, 'Yes, Thursday Only' as CodeShort, 'Yes, Thursday Only' as CodeLong, '007' as SortOrder, 1 as Available

	UNION
	
	select 'ScheduleDaysType' as Category, 8 as CodeId, 'Yes, Friday Only' as CodeShort, 'Yes, Friday Only' as CodeLong, '008' as SortOrder, 1 as Available

	UNION
	
	select 'ScheduleDaysType' as Category, 9 as CodeId, 'Yes, Saturday Only' as CodeShort, 'Yes, Saturday Only' as CodeLong, '009' as SortOrder, 1 as Available

	UNION
	
	select 'ScheduleDaysType' as Category, 10 as CodeId, 'Yes, Sunday Only' as CodeShort, 'Yes, Sunday Only' as CodeLong, '010' as SortOrder, 1 as Available

	UNION
	
	select 'ScheduleDaysType' as Category, 99 as CodeId, 'No repeat' as CodeShort, 'No repeat' as CodeLong, '000' as SortOrder, 1 as Available

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
CodeListY where CodeListId in (select Id from CodeList where Category = 'ScheduleDaysType' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'ScheduleDaysType' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'ScheduleDaysType' order by SortOrder


------------------------------------- End ScheduleDaysType ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)