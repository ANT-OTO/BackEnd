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



------------------------------------- Begin BatchHandlerStatus ------------------------------------- 
--delete [CodeList] where Category = 'BatchHandlerStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'BatchHandlerStatus' as Category, 1 as CodeId, N'已生成' as CodeShort, N'已生成' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION

	select 'BatchHandlerStatus' as Category, 2 as CodeId, N'已取消' as CodeShort, N'已取消' as CodeLong, '002' as SortOrder, 1 as Available

	UNION

	select 'BatchHandlerStatus' as Category, 3 as CodeId, N'已完成' as CodeShort, N'已完成' as CodeLong, '003' as SortOrder, 1 as Available

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
CodeListY where CodeListId in (select Id from CodeList where Category = 'BatchHandlerStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'BatchHandlerStatus' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'BatchHandlerStatus'


------------------------------------- End BatchHandlerStatus ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)