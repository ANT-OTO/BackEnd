--select * from CodeList where Category = 'SecurityAvailability'

declare @TblCode as Table
(
	[Category] [nvarchar](100) NOT NULL,
	[CodeId] [int] NOT NULL,
	[CodeShort] [nvarchar](256) NOT NULL,
	[CodeLong] [nvarchar](256) NOT NULL,
	[SortOrder] [nvarchar](256) NOT NULL,
	[Available] [bit] NOT NULL
)	



------------------------------------- Begin ScheduledRequestStatus ------------------------------------- 
--delete [CodeList] where Category = 'ScheduledRequestStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'ScheduledRequestStatus' as Category, 1 as CodeId, 'Initialized' as CodeShort, 'Initialized' as CodeLong, '001' as SortOrder,1 as Available
	
	UNION
	
	select 'ScheduledRequestStatus' as Category, 2 as CodeId, 'Interpreter Confirmed' as CodeShort, 'Interpreter Confirmed' as CodeLong, '002' as SortOrder, 1 as Available
	
	UNION
	
	select 'ScheduledRequestStatus' as Category, 3 as CodeId, 'In Service' as CodeShort, 'In Service' as CodeLong, '003' as SortOrder, 1 as Available
	
	UNION
	
	select 'ScheduledRequestStatus' as Category, 4 as CodeId, 'Serviced' as CodeShort, 'Serviced' as CodeLong, '004' as SortOrder,  1 as Available
	
	UNION
	
	select 'ScheduledRequestStatus' as Category, 5 as CodeId, 'Canceled' as CodeShort, 'Serviced' as CodeLong, '005' as SortOrder,  1 as Available
	
	UNION
	
	select 'ScheduledRequestStatus' as Category, 6 as CodeId, 'Canceled (Late)' as CodeShort, 'Canceled (Late)' as CodeLong, '006' as SortOrder,  1 as Available

	UNION
	
	select 'ScheduledRequestStatus' as Category, 7 as CodeId, 'Canceled (By Force)' as CodeShort, 'Canceled (By Force)' as CodeLong, '007' as SortOrder,  1 as Available
	
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
CodeListY where CodeListId in (select Id from CodeList where Category = 'ScheduledRequestStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'ScheduledRequestStatus' and CodeId not in (select CodeId from @TblCode)


select * from CodeList where Category = 'ScheduledRequestStatus' order by SortOrder

go

------------------------------------- End ScheduledRequestStatus ------------------------------------- 

