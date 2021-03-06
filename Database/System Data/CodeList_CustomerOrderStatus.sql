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



------------------------------------- Begin CustomerOrderStatus ------------------------------------- 
--delete [CodeList] where Category = 'CustomerOrderStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'CustomerOrderStatus' as Category, 1 as CodeId, N'已下单' as CodeShort, N'已下单' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION

	select 'CustomerOrderStatus' as Category, 2 as CodeId, N'处理中' as CodeShort, N'处理中' as CodeLong, '002' as SortOrder, 1 as Available

	UNION

	select 'CustomerOrderStatus' as Category, 3 as CodeId, N'已确认接单' as CodeShort, N'已确认接单' as CodeLong, '003' as SortOrder, 1 as Available
	
	UNION

	select 'CustomerOrderStatus' as Category, 4 as CodeId, N'采购中' as CodeShort, N'采购中' as CodeLong, '004' as SortOrder, 1 as Available
	
	UNION

	select 'CustomerOrderStatus' as Category, 5 as CodeId, N'已入库' as CodeShort, N'已入库' as CodeLong, '005' as SortOrder, 1 as Available
	
	UNION

	select 'CustomerOrderStatus' as Category, 6 as CodeId, N'转库中' as CodeShort, N'转库中' as CodeLong, '006' as SortOrder, 1 as Available
	
	UNION

	select 'CustomerOrderStatus' as Category, 7 as CodeId, N'库内打包' as CodeShort, N'库内打包' as CodeLong, '007' as SortOrder, 1 as Available
	
	UNION

	select 'CustomerOrderStatus' as Category, 8 as CodeId, N'正在安排运送' as CodeShort, N'正在安排运送' as CodeLong, '008' as SortOrder, 1 as Available
	
	UNION

	select 'CustomerOrderStatus' as Category, 9 as CodeId, N'运送中' as CodeShort, N'运送中' as CodeLong, '009' as SortOrder, 1 as Available
	
	UNION

	select 'CustomerOrderStatus' as Category, 10 as CodeId, N'货已送到' as CodeShort, N'货已送到' as CodeLong, '010' as SortOrder, 1 as Available
	
	UNION

	select 'CustomerOrderStatus' as Category, 11 as CodeId, N'确认收货' as CodeShort, N'确认收货' as CodeLong, '011' as SortOrder, 1 as Available
	
	UNION

	select 'CustomerOrderStatus' as Category, 12 as CodeId, N'已取消' as CodeShort, N'已取消' as CodeLong, '012' as SortOrder, 1 as Available

	UNION

	select 'CustomerOrderStatus' as Category, 13 as CodeId, N'申请退货' as CodeShort, N'申请退货' as CodeLong, '013' as SortOrder, 1 as Available

	UNION

	select 'CustomerOrderStatus' as Category, 14 as CodeId, N'退货驳回' as CodeShort, N'退货驳回' as CodeLong, '014' as SortOrder, 1 as Available

	UNION

	select 'CustomerOrderStatus' as Category, 15 as CodeId, N'退货已受理' as CodeShort, N'退货已受理' as CodeLong, '015' as SortOrder, 1 as Available

	UNION

	select 'CustomerOrderStatus' as Category, 16 as CodeId, N'已退货' as CodeShort, N'已退货' as CodeLong, '016' as SortOrder, 1 as Available

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
CodeListY where CodeListId in (select Id from CodeList where Category = 'CustomerOrderStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'CustomerOrderStatus' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'CustomerOrderStatus'


------------------------------------- End CustomerOrderStatus ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)