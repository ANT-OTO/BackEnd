--select * from CodeList where Category = 'ProviderTodayScheduleOption'

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
	select 'ProviderTodayScheduleOption' as Category, 1 as CodeId, 'I am available today' as CodeShort, 'I am available today' as CodeLong, '001' as SortOrder, 0 as Available
	
	UNION
	
	select 'ProviderTodayScheduleOption' as Category, 2 as CodeId, 'I am available for the rest of today' as CodeShort, 'I am available for the rest of today' as CodeLong, '002' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderTodayScheduleOption' as Category, 3 as CodeId, 'I serve as alternative today' as CodeShort, 'I serve as alternative today' as CodeLong, '003' as SortOrder, 0 as Available
	
	UNION
	
	select 'ProviderTodayScheduleOption' as Category, 4 as CodeId, 'I serve as alternative for the rest of today' as CodeShort, 'I serve as alternative for the rest of today' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderTodayScheduleOption' as Category, 5 as CodeId, 'I am not available for the rest of today' as CodeShort, 'I am not available for the rest of today' as CodeLong, '005' as SortOrder, 1 as Available
	
	
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

select * from CodeList where Category = 'ProviderTodayScheduleOption' order by SortOrder


go

