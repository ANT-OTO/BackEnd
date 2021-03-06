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



------------------------------------- Begin ShippingOrderStatus ------------------------------------- 
--delete [CodeList] where Category = 'ShippingOrderStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'ShippingOrderStatus' as Category, 1 as CodeId, N'已生成' as CodeShort, N'已生成' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION

	select 'ShippingOrderStatus' as Category, 2 as CodeId, N'门店审核中' as CodeShort, N'门店审核中' as CodeLong, '002' as SortOrder, 1 as Available

	UNION

	select 'ShippingOrderStatus' as Category, 3 as CodeId, N'审核完毕' as CodeShort, N'审核完毕' as CodeLong, '003' as SortOrder, 1 as Available

	UNION

	select 'ShippingOrderStatus' as Category, 4 as CodeId, N'门店已出库' as CodeShort, N'门店已出库' as CodeLong, '004' as SortOrder, 1 as Available

	UNION

	select 'ShippingOrderStatus' as Category, 5 as CodeId, N'航班已抵达' as CodeShort, N'航班已抵达' as CodeLong, '005' as SortOrder, 1 as Available

	UNION

	select 'ShippingOrderStatus' as Category, 6 as CodeId, N'清关中' as CodeShort, N'清关中' as CodeLong, '006' as SortOrder, 1 as Available

	UNION

	select 'ShippingOrderStatus' as Category, 7 as CodeId, N'国内派送' as CodeShort, N'国内派送' as CodeLong, '007' as SortOrder, 1 as Available

	UNION

	select 'ShippingOrderStatus' as Category, 8 as CodeId, N'已送达' as CodeShort, N'已送达' as CodeLong, '008' as SortOrder, 1 as Available

	UNION

	select 'ShippingOrderStatus' as Category, 9 as CodeId, N'已退回' as CodeShort, N'已退回' as CodeLong, '009' as SortOrder, 1 as Available

	UNION

	select 'ShippingOrderStatus' as Category, 10 as CodeId, N'已拦截' as CodeShort, N'已拦截' as CodeLong, '010' as SortOrder, 1 as Available

	UNION

	select 'ShippingOrderStatus' as Category, 11 as CodeId, N'已取消' as CodeShort, N'已取消' as CodeLong, '011' as SortOrder, 1 as Available
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
CodeListY where CodeListId in (select Id from CodeList where Category = 'ShippingOrderStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'ShippingOrderStatus' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'ShippingOrderStatus'


------------------------------------- End ShippingOrderStatus ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)