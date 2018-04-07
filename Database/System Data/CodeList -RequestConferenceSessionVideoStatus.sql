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



------------------------------------- Begin RequestConferenceSessionVideoStatus ------------------------------------- 
--delete [CodeList] where Category = 'RequestConferenceSessionVideoStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'RequestConferenceSessionVideoStatus' as Category, 1 as CodeId, 'Informed' as CodeShort, 'Informed' as CodeLong, '001' as SortOrder, 1 as Available
	
	

	UNION
	
	select 'RequestConferenceSessionVideoStatus' as Category, 2 as CodeId, 'Confirmed' as CodeShort, 'Confirmed' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'RequestConferenceSessionVideoStatus' as Category, 3 as CodeId, 'ConferenceRouted' as CodeShort, 'ConferenceRouted' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'RequestConferenceSessionVideoStatus' as Category, 4 as CodeId, 'ConferenceConnected' as CodeShort, 'ConferenceConnected' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'RequestConferenceSessionVideoStatus' as Category, 5 as CodeId, 'ConferenceDisconnected' as CodeShort, 'ConferenceDisconnected' as CodeLong, '005' as SortOrder, 1 as Available

	UNION
	
	select 'RequestConferenceSessionVideoStatus' as Category, 6 as CodeId, 'Finished' as CodeShort, 'Finished' as CodeLong, '006' as SortOrder, 1 as Available

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
CodeListY where CodeListId in (select Id from CodeList where Category = 'RequestConferenceSessionVideoStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'RequestConferenceSessionVideoStatus' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'RequestConferenceSessionVideoStatus'


------------------------------------- End RequestConferenceSessionVideoStatus ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)