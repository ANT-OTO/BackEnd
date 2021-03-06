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



------------------------------------- Begin StockActionType ------------------------------------- 
--delete [CodeList] where Category = 'StockActionType'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'StockActionType' as Category, 1 as CodeId, N'入库登记' as CodeShort, N'入库登记' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION

	select 'StockActionType' as Category, 2 as CodeId, N'入库途中' as CodeShort, N'入库途中' as CodeLong, '002' as SortOrder, 1 as Available

	UNION

	select 'StockActionType' as Category, 3 as CodeId, N'已在库' as CodeShort, N'已在库' as CodeLong, '003' as SortOrder, 1 as Available
	
	UNION

	select 'StockActionType' as Category, 4 as CodeId, N'拣货车' as CodeShort, N'拣货车' as CodeLong, '004' as SortOrder, 1 as Available

	UNION

	select 'StockActionType' as Category, 5 as CodeId, N'打包' as CodeShort, N'打包' as CodeLong, '005' as SortOrder, 1 as Available

	UNION

	select 'StockActionType' as Category, 6 as CodeId, N'已出库' as CodeShort, N'已出库' as CodeLong, '006' as SortOrder, 1 as Available
	
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
CodeListY where CodeListId in (select Id from CodeList where Category = 'StockActionType' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'StockActionType' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'StockActionType'


------------------------------------- End StockActionType ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)