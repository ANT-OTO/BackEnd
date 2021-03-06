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



------------------------------------- Begin TransactionType ------------------------------------- 
--delete [CodeList] where Category = 'TransactionType'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'TransactionType' as Category, 1 as CodeId, N'付款' as CodeShort, N'付款' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION

	select 'TransactionType' as Category, 2 as CodeId, N'收款' as CodeShort, N'收款' as CodeLong, '002' as SortOrder, 1 as Available

	UNION

	select 'TransactionType' as Category, 3 as CodeId, N'转入' as CodeShort, N'转入' as CodeLong, '003' as SortOrder, 1 as Available

	UNION

	select 'TransactionType' as Category, 4 as CodeId, N'付款取消' as CodeShort, N'付款取消' as CodeLong, '004' as SortOrder, 1 as Available

	UNION

	select 'TransactionType' as Category, 5 as CodeId, N'收款取消' as CodeShort, N'收款取消' as CodeLong, '005' as SortOrder, 1 as Available

	UNION

	select 'TransactionType' as Category, 6 as CodeId, N'转入取消' as CodeShort, N'转入取消' as CodeLong, '006' as SortOrder, 1 as Available

	UNION

	select 'TransactionType' as Category, 7 as CodeId, N'转出' as CodeShort, N'转出' as CodeLong, '007' as SortOrder, 1 as Available

	UNION

	select 'TransactionType' as Category, 8 as CodeId, N'转出取消' as CodeShort, N'转出取消' as CodeLong, '008' as SortOrder, 1 as Available
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
CodeListY where CodeListId in (select Id from CodeList where Category = 'TransactionType' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'TransactionType' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'TransactionType'


------------------------------------- End TransactionType ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)