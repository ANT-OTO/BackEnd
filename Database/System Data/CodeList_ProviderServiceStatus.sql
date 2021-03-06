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



------------------------------------- Begin ProviderServiceStatus ------------------------------------- 
--delete [CodeList] where Category = 'ProviderServiceStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'ProviderServiceStatus' as Category, 1 as CodeId, 'Pending Interview' as CodeShort, 'Pending Interview' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderServiceStatus' as Category, 2 as CodeId, 'Approved' as CodeShort, 'Approved' as CodeLong, '002' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderServiceStatus' as Category, 3 as CodeId, 'Denied' as CodeShort, 'Denied' as CodeLong, '003' as SortOrder, 1 as Available
	
	UNION

	select 'ProviderServiceStatus' as Category, 4 as CodeId, 'In Training' as CodeShort, 'In Training' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderServiceStatus' as Category, 5 as CodeId, 'Pending Paper Work' as CodeShort, 'Pending Paper Work' as CodeLong, '005' as SortOrder, 1 as Available
	
	UNION

	select 'ProviderServiceStatus' as Category, 998 as CodeId, 'Suspended' as CodeShort, 'Suspended' as CodeLong, '998' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderServiceStatus' as Category, 999 as CodeId, 'Cancelled' as CodeShort, 'Cancelled' as CodeLong, '999' as SortOrder, 1 as Available


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
CodeListY where CodeListId in (select Id from CodeList where Category = 'ProviderServiceStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'ProviderServiceStatus' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'ProviderServiceStatus'
select * from CodeListY where CodeListId in (
select Id from CodeList where Category = 'ProviderServiceStatus'
) 
order by SystemLanguageId, CodeListId


------------------------------------- End ProviderServiceStatus ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)