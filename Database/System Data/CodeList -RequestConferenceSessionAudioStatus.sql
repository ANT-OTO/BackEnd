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



------------------------------------- Begin RequestConferenceSessionAudioStatus ------------------------------------- 
--delete [CodeList] where Category = 'RequestConferenceSessionAudioStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'RequestConferenceSessionAudioStatus' as Category, 1 as CodeId, 'Informed' as CodeShort, 'Informed' as CodeLong, '001' as SortOrder, 1 as Available

	UNION
	
	select 'RequestConferenceSessionAudioStatus' as Category, 2 as CodeId, 'Confirmed' as CodeShort, 'Confirmed' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'RequestConferenceSessionAudioStatus' as Category, 3 as CodeId, 'InCalling' as CodeShort, 'InCalling' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'RequestConferenceSessionAudioStatus' as Category, 4 as CodeId, 'IndividualConnected' as CodeShort, 'IndividualConnected' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'RequestConferenceSessionAudioStatus' as Category, 5 as CodeId, 'InCallingFail' as CodeShort, 'InCallingFail' as CodeLong, '005' as SortOrder, 1 as Available

	UNION
	
	select 'RequestConferenceSessionAudioStatus' as Category, 6 as CodeId, 'ConferenceRouted' as CodeShort, 'ConferenceRouted' as CodeLong, '006' as SortOrder, 1 as Available

	UNION
	
	select 'RequestConferenceSessionAudioStatus' as Category, 7 as CodeId, 'ConferenceConnected' as CodeShort, 'ConferenceConnected' as CodeLong, '007' as SortOrder, 1 as Available

	UNION
	
	select 'RequestConferenceSessionAudioStatus' as Category, 8 as CodeId, 'ConferenceDisconnected' as CodeShort, 'ConferenceDisconnected' as CodeLong, '008' as SortOrder, 1 as Available

	UNION 
	
	select 'RequestConferenceSessionAudioStatus' as Category, 9 as CodeId, 'Inqueue' as CodeShort, 'Inqueue' as CodeLong, '009' as SortOrder, 1 as Available
 
	UNION 
	
	select 'RequestConferenceSessionAudioStatus' as Category, 10 as CodeId, 'RouteToBackup' as CodeShort, 'RouteToBackup' as CodeLong, '010' as SortOrder, 1 as Available
 
	UNION
	
	select 'RequestConferenceSessionAudioStatus' as Category, 99 as CodeId, 'Finished' as CodeShort, 'Finished' as CodeLong, '099' as SortOrder, 1 as Available

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
CodeListY where CodeListId in (select Id from CodeList where Category = 'RequestConferenceSessionAudioStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'RequestConferenceSessionAudioStatus' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'RequestConferenceSessionAudioStatus'


------------------------------------- End RequestConferenceSessionAudioStatus ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)