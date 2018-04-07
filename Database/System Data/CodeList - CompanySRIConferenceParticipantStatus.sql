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



------------------------------------- Begin CompanySRIConferenceParticipantStatus ------------------------------------- 
--delete [CodeList] where Category = 'CompanySRIConferenceParticipantStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'CompanySRIConferenceParticipantStatus' as Category, 1 as CodeId, 'Invited' as CodeShort, 'Invited' as CodeLong, '001' as SortOrder, 1 as Available
	
	

	UNION
	
	select 'CompanySRIConferenceParticipantStatus' as Category, 2 as CodeId, 'Confirmed' as CodeShort, 'Confirmed' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'CompanySRIConferenceParticipantStatus' as Category, 3 as CodeId, 'Tested' as CodeShort, 'Tested' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'CompanySRIConferenceParticipantStatus' as Category, 4 as CodeId, 'Active' as CodeShort, 'Active' as CodeLong, '004' as SortOrder, 1 as Available
	
	UNION
	
	select 'CompanySRIConferenceParticipantStatus' as Category, 5 as CodeId, 'Deactive' as CodeShort, 'Deactive' as CodeLong, '005' as SortOrder, 1 as Available

	UNION
	
	select 'CompanySRIConferenceParticipantStatus' as Category, 6 as CodeId, 'Kicked' as CodeShort, 'Kicked' as CodeLong, '006' as SortOrder, 1 as Available

	UNION
	
	select 'CompanySRIConferenceParticipantStatus' as Category, 7 as CodeId, 'ReleaseRequest' as CodeShort, 'ReleaseRequest' as CodeLong, '007' as SortOrder, 1 as Available

	UNION
	
	select 'CompanySRIConferenceParticipantStatus' as Category, 8 as CodeId, 'ReleaseRequestAccepted' as CodeShort, 'ReleaseRequestAccepted' as CodeLong, '008' as SortOrder, 1 as Available

	UNION
	
	select 'CompanySRIConferenceParticipantStatus' as Category, 9 as CodeId, 'ReleaseRequestPending' as CodeShort, 'ReleaseRequestPending' as CodeLong, '009' as SortOrder, 1 as Available

	UNION
	
	select 'CompanySRIConferenceParticipantStatus' as Category, 10 as CodeId, 'AcceptReleaseRequest' as CodeShort, 'AcceptReleaseRequest' as CodeLong, '010' as SortOrder, 1 as Available

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
CodeListY where CodeListId in (select Id from CodeList where Category = 'CompanySRIConferenceParticipantStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'CompanySRIConferenceParticipantStatus' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'CompanySRIConferenceParticipantStatus'


------------------------------------- End CompanySRIConferenceParticipantStatus ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)