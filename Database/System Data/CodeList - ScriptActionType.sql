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



------------------------------------- Begin  ------------------------------------- 
--delete [CodeList] where Category = 'ScriptActionType'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'ScriptActionType' as Category, 1 as CodeId, 'Go to' as CodeShort, 'Go to' as CodeLong, '001' as SortOrder,1 as Available
	
	UNION
	
	select 'ScriptActionType' as Category, 2 as CodeId, 'Close Prompt' as CodeShort, 'Close Prompt' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'ScriptActionType' as Category, 3 as CodeId, 'Finish Conversation' as CodeShort, 'Finish Conversation' as CodeLong, '003' as SortOrder, 1 as Available
) a 

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available, CreateDate, LastUpdate)
select a.Category, a.CodeId, a.CodeShort, a.CodeLong, a.SortOrder, a.Available,
	getutcdate(), getutcdate()
from @TblCode a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null
order by a.SortOrder

update a
set a.CodeShort = b.CodeShort, a.CodeLong = b.CodeLong, a.SortOrder = b.SortOrder, a.Available = b.Available
	, a.LastUpdate = GETUTCDATE()
from [CodeList] a inner join  @TblCode b on a.Category = b.Category and a.CodeId = b.CodeId 



delete 
--select * from
CodeListY where CodeListId in (select Id from CodeList where Category = 'ScriptActionType' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'ScriptActionType' and CodeId not in (select CodeId from @TblCode)


select * from CodeList where Category = 'ScriptActionType' order by SortOrder

------------------------------------- End  ------------------------------------- 

go

