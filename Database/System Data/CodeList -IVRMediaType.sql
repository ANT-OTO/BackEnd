--select * from CodeList where Category = 'IVRMediaType'

declare @TblCode as Table
(
	[Category] [nvarchar](100) NOT NULL,
	[CodeId] [int] NOT NULL,
	[CodeShort] [nvarchar](256) NOT NULL,
	[CodeLong] [nvarchar](256) NOT NULL,
	[SortOrder] [nvarchar](256) NOT NULL,
	[Available] [bit] NOT NULL
)	



------------------------------------- Begin IVRMediaType ------------------------------------- 
--delete [CodeList] where Category = 'IVRMediaType'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'IVRMediaType' as Category, 1 as CodeId, 'Greeting' as CodeShort, 'Greeting' as CodeLong, '001' as SortOrder,1 as Available
	
	UNION
	
	select 'IVRMediaType' as Category, 2 as CodeId, 'Authorization' as CodeShort, 'Authorization' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'IVRMediaType' as Category, 3 as CodeId, 'Authorization Retry' as CodeShort, 'Authorization Retry' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'IVRMediaType' as Category, 4 as CodeId, 'Authorization Fail' as CodeShort, 'Authorization Fail' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'IVRMediaType' as Category, 5 as CodeId, 'Language Selection' as CodeShort, 'Language Selection' as CodeLong, '005' as SortOrder, 1 as Available

	UNION
	
	select 'IVRMediaType' as Category, 6 as CodeId, 'Language Selection Retry' as CodeShort, 'Language Selection Retry' as CodeLong, '006' as SortOrder, 1 as Available

	UNION
	
	select 'IVRMediaType' as Category, 7 as CodeId, 'Language Selection Fail' as CodeShort, 'Language Selection Fail' as CodeLong, '007' as SortOrder, 1 as Available

	UNION
	
	select 'IVRMediaType' as Category, 8 as CodeId, 'Operator Routing' as CodeShort, 'Operator Routing' as CodeLong, '097' as SortOrder, 1 as Available

	UNION
	
	select 'IVRMediaType' as Category, 9 as CodeId, 'Service Routing' as CodeShort, 'Service Routing' as CodeLong, '098' as SortOrder, 1 as Available

	UNION
	
	select 'IVRMediaType' as Category, 10 as CodeId, 'Service Routing After Operator' as CodeShort, 'Service Routing After Operator' as CodeLong, '099' as SortOrder, 1 as Available

	UNION
	
	select 'IVRMediaType' as Category, 11 as CodeId, 'Language Selection Confirmation' as CodeShort, 'Language Selection Confirmation' as CodeLong, '008' as SortOrder, 1 as Available

	UNION
	
	select 'IVRMediaType' as Category, 12 as CodeId, 'Gender Option' as CodeShort, 'Gender Option' as CodeLong, '009' as SortOrder, 1 as Available

	UNION
	
	select 'IVRMediaType' as Category, 13 as CodeId, 'Gender Selection' as CodeShort, 'Gender Selection' as CodeLong, '010' as SortOrder, 1 as Available

) a 

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available, CreateDate, LastUpdate)
select a.Category, a.CodeId, a.CodeShort, a.CodeLong, a.SortOrder, a.Available,
	getutcdate(), getutcdate()
from @TblCode a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

update a
set a.CodeShort = b.CodeShort, a.CodeLong = b.CodeLong, a.SortOrder = b.SortOrder, a.Available = b.Available
from [CodeList] a inner join  @TblCode b on a.Category = b.Category and a.CodeId = b.CodeId 



delete 
--select * from
CodeListY where CodeListId in (select Id from CodeList where Category = 'IVRMediaType' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'IVRMediaType' and CodeId not in (select CodeId from @TblCode)


select * from CodeList where Category = 'IVRMediaType' order by SortOrder

------------------------------------- End IVRMediaType ------------------------------------- 

GO


