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



------------------------------------- Begin InterviewStatus ------------------------------------- 
--delete [CodeList] where Category = 'InterviewStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'InterviewStatus' as Category, 1 as CodeId, 'New' as CodeShort, 'New' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'InterviewStatus' as Category, 2 as CodeId, 'In Service' as CodeShort, 'In Service' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'InterviewStatus' as Category, 3 as CodeId, 'Serviced' as CodeShort, 'Serviced' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'InterviewStatus' as Category, 4 as CodeId, 'Cancelled' as CodeShort, 'Cancelled' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'InterviewStatus' as Category, 5 as CodeId, 'Cancelled After Failed Service' as CodeShort, 'Cancelled After Failed Service' as CodeLong, '005' as SortOrder, 1 as Available

	UNION
	
	select 'InterviewStatus' as Category, 6 as CodeId, 'In Service Cleared' as CodeShort, 'In Service Cleared By Force' as CodeLong, '006' as SortOrder, 1 as Available

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
CodeListY where CodeListId in (select Id from CodeList where Category = 'InterviewStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'InterviewStatus' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'InterviewStatus'


------------------------------------- End InterviewStatus ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)