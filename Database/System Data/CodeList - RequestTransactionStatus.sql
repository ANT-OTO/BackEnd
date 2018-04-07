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



------------------------------------- Begin RequestTransactionStatus ------------------------------------- 
--delete [CodeList] where Category = 'RequestTransactionStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'RequestTransactionStatus' as Category, 1 as CodeId, 'New' as CodeShort, 'New' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'RequestTransactionStatus' as Category, 2 as CodeId, 'Route To Provider' as CodeShort, 'Route To Provider' as CodeLong, '002' as SortOrder, 1 as Available
	
	UNION
	
	select 'RequestTransactionStatus' as Category, 3 as CodeId, 'Provider Manager Assist' as CodeShort, 'Provider Manager Assist' as CodeLong, '003' as SortOrder, 1 as Available

	UNION

	select 'RequestTransactionStatus' as Category, 4 as CodeId, 'Route to Backup' as CodeShort, 'Route to Backup' as CodeLong, '004' as SortOrder, 1 as Available

	UNION

	select 'RequestTransactionStatus' as Category, 5 as CodeId, 'In Service' as CodeShort, 'In Service' as CodeLong, '005' as SortOrder, 1 as Available

	UNION

	select 'RequestTransactionStatus' as Category, 6 as CodeId, 'Serviced' as CodeShort, 'Serviced' as CodeLong, '006' as SortOrder, 1 as Available

	UNION

	select 'RequestTransactionStatus' as Category, 998 as CodeId, 'Pending' as CodeShort, 'Pending' as CodeLong, '998' as SortOrder, 1 as Available
	
	UNION

	select 'RequestTransactionStatus' as Category, 999 as CodeId, 'Cancelled' as CodeShort, 'Cancelled' as CodeLong, '999' as SortOrder, 1 as Available
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
CodeListY where CodeListId in (select Id from CodeList where Category = 'RequestTransactionStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'RequestTransactionStatus' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'RequestTransactionStatus' order by SortOrder
select * from CodeListY where CodeListId in (
select Id from CodeList where Category = 'RequestTransactionStatus'
) 
order by SystemLanguageId, CodeListId


------------------------------------- End RequestTransactionStatus ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)