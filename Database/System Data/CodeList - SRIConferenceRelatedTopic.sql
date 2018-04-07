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



------------------------------------- Begin SRIConferenceRelatedTopic ------------------------------------- 
--delete [CodeList] where Category = 'SRIConferenceRelatedTopic'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'SRIConferenceRelatedTopic' as Category, 1 as CodeId, 'Business' as CodeShort, 'Business' as CodeLong, '001' as SortOrder, 1 as Available
	
	

	UNION
	
	select 'SRIConferenceRelatedTopic' as Category, 2 as CodeId, 'Science' as CodeShort, 'Science' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'SRIConferenceRelatedTopic' as Category, 3 as CodeId, 'Linguistic' as CodeShort, 'Linguistic' as CodeLong, '003' as SortOrder, 1 as Available


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
CodeListY where CodeListId in (select Id from CodeList where Category = 'SRIConferenceRelatedTopic' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'SRIConferenceRelatedTopic' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'SRIConferenceRelatedTopic'


------------------------------------- End SRIConferenceRelatedTopic ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)