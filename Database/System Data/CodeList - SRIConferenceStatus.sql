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



------------------------------------- Begin SRIConferenceStatus ------------------------------------- 
--delete [CodeList] where Category = 'SRIConferenceStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'SRIConferenceStatus' as Category, 1 as CodeId, 'Created' as CodeShort, 'Created' as CodeLong, '001' as SortOrder, 1 as Available
	
	

	UNION
	
	select 'SRIConferenceStatus' as Category, 2 as CodeId, 'PresenterAdded' as CodeShort, 'PresenterAdded' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'SRIConferenceStatus' as Category, 3 as CodeId, 'AudioChannelSelected' as CodeShort, 'AudioChannelSelected' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'SRIConferenceStatus' as Category, 4 as CodeId, 'ServicePairSelected' as CodeShort, 'ServicePairSelected' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'SRIConferenceStatus' as Category, 5 as CodeId, 'InterpreterOneLinkFinished' as CodeShort, 'InterpreterOneLinkFinished' as CodeLong, '005' as SortOrder, 1 as Available
	
	UNION
	
	select 'SRIConferenceStatus' as Category, 6 as CodeId, 'InterpreterRelayFinished' as CodeShort, 'InterpreterRelayFinished' as CodeLong, '006' as SortOrder, 1 as Available

	UNION
	
	select 'SRIConferenceStatus' as Category, 7 as CodeId, 'ConferenceSetupFinished' as CodeShort, 'ConferenceSetupFinished' as CodeLong, '007' as SortOrder, 1 as Available

	UNION
	
	select 'SRIConferenceStatus' as Category, 8 as CodeId, 'ConferenceRehearsalStart' as CodeShort, 'ConferenceRehearsalStart' as CodeLong, '008' as SortOrder, 1 as Available

	UNION
	
	select 'SRIConferenceStatus' as Category, 90 as CodeId, 'ConferenceStarted' as CodeShort, 'ConferenceStarted' as CodeLong, '090' as SortOrder, 1 as Available

	UNION
	
	select 'SRIConferenceStatus' as Category, 91 as CodeId, 'PresenterSessionStarted' as CodeShort, 'PresenterSessionStarted' as CodeLong, '091' as SortOrder, 1 as Available

	UNION
	
	select 'SRIConferenceStatus' as Category, 99 as CodeId, 'ConferenceFinished' as CodeShort, 'ConferenceFinished' as CodeLong, '099' as SortOrder, 1 as Available


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
CodeListY where CodeListId in (select Id from CodeList where Category = 'SRIConferenceStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'SRIConferenceStatus' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'SRIConferenceStatus'


------------------------------------- End SRIConferenceStatus ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)