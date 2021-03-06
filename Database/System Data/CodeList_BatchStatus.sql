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



------------------------------------- Begin BatchStatus ------------------------------------- 
--delete [CodeList] where Category = 'BatchStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'BatchStatus' as Category, 1 as CodeId, N'initialized' as CodeShort, N'initialized' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION

	select 'BatchStatus' as Category, 2 as CodeId, N'confirmed' as CodeShort, N'confirmed' as CodeLong, '002' as SortOrder, 1 as Available

	UNION

	select 'BatchStatus' as Category, 3 as CodeId, N'cancelled' as CodeShort, N'cancelled' as CodeLong, '003' as SortOrder, 1 as Available

	UNION

	select 'BatchStatus' as Category, 4 as CodeId, N'completed' as CodeShort, N'completed' as CodeLong, '004' as SortOrder, 1 as Available

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
CodeListY where CodeListId in (select Id from CodeList where Category = 'BatchStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'BatchStatus' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'BatchStatus'


------------------------------------- End BatchStatus ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)