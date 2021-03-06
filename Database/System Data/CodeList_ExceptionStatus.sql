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



------------------------------------- Begin ExceptionStatus ------------------------------------- 
--delete [CodeList] where Category = 'ExceptionStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'ExceptionStatus' as Category, 1 as CodeId, 'New' as CodeShort, 'New' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'ExceptionStatus' as Category, 2 as CodeId, 'Contact PM' as CodeShort, 'Contact PM' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'ExceptionStatus' as Category, 3 as CodeId, 'PM Confirmed' as CodeShort, 'PM Confirmed' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'ExceptionStatus' as Category, 4 as CodeId, 'Contact Backup' as CodeShort, 'Contact Backup' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'ExceptionStatus' as Category, 5 as CodeId, 'Backup Confirmed' as CodeShort, 'Backup Confirmed' as CodeLong, '005' as SortOrder, 1 as Available

	UNION
	
	select 'ExceptionStatus' as Category, 6 as CodeId, 'Contact Provider' as CodeShort, 'Contact Provider' as CodeLong, '006' as SortOrder, 1 as Available

	UNION
	
	select 'ExceptionStatus' as Category, 7 as CodeId, 'Provider Confirmed' as CodeShort, 'Provider Confirmed' as CodeLong, '007' as SortOrder, 1 as Available

	UNION
	
	select 'ExceptionStatus' as Category, 97 as CodeId, 'Cancelled by Client' as CodeShort, 'Cancelled by Client' as CodeLong, '097' as SortOrder, 1 as Available

	UNION
	
	select 'ExceptionStatus' as Category, 98 as CodeId, 'Finished' as CodeShort, 'Finished' as CodeLong, '099' as SortOrder, 1 as Available

	UNION
	
	select 'ExceptionStatus' as Category, 99 as CodeId, 'Killed by force' as CodeShort, 'Killed by force' as CodeLong, '099' as SortOrder, 1 as Available

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
CodeListY where CodeListId in (select Id from CodeList where Category = 'ExceptionStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'ExceptionStatus' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'ExceptionStatus'


------------------------------------- End ExceptionStatus ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)