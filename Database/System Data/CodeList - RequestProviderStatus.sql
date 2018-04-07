--select * from CodeList where Category = 'ScheduledRequestProviderStatus'

declare @TblCode as Table
(
	[Category] [nvarchar](100) NOT NULL,
	[CodeId] [int] NOT NULL,
	[CodeShort] [nvarchar](256) NOT NULL,
	[CodeLong] [nvarchar](256) NOT NULL,
	[SortOrder] [nvarchar](256) NOT NULL,
	[Available] [bit] NOT NULL
)	




delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'ScheduledRequestProviderStatus' as Category, 1 as CodeId, 'New' as CodeShort, 'New' as CodeLong, '001' as SortOrder,1 as Available
	
	UNION
	
	select 'ScheduledRequestProviderStatus' as Category, 2 as CodeId, 'Sent' as CodeShort, 'Sent' as CodeLong, '002' as SortOrder, 1 as Available
	
	UNION
	
	select 'ScheduledRequestProviderStatus' as Category, 3 as CodeId, 'Received' as CodeShort, 'Received' as CodeLong, '003' as SortOrder, 1 as Available
	
	UNION
	
	select 'ScheduledRequestProviderStatus' as Category, 4 as CodeId, 'Accepted' as CodeShort, 'Accepted' as CodeLong, '004' as SortOrder, 1 as Available
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

select * from CodeList where Category = 'ScheduledRequestProviderStatus' order by SortOrder


go

