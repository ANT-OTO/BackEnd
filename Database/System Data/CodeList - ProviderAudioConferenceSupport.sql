--select * from CodeList where Category = 'ProviderAudioConferenceSupport'

declare @TblCode as Table
(
	[Category] [nvarchar](100) NOT NULL,
	[CodeId] [int] NOT NULL,
	[CodeShort] [nvarchar](256) NOT NULL,
	[CodeLong] [nvarchar](256) NOT NULL,
	[SortOrder] [nvarchar](256) NOT NULL,
	[Available] [bit] NOT NULL
)	



------------------------------------- Begin ProviderAudioConferenceSupport ------------------------------------- 
--delete [CodeList] where Category = 'ProviderAudioConferenceSupport'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'ProviderAudioConferenceSupport' as Category, 1 as CodeId, 'Support' as CodeShort, 'Support' as CodeLong, '001' as SortOrder,1 as Available
	
	UNION
	
	select 'ProviderAudioConferenceSupport' as Category, 2 as CodeId, 'Disable' as CodeShort, 'Disable' as CodeLong, '002' as SortOrder, 1 as Available
	
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
CodeListY where CodeListId in (select Id from CodeList where Category = 'ProviderAudioConferenceSupport' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'ProviderAudioConferenceSupport' and CodeId not in (select CodeId from @TblCode)


select * from CodeList where Category = 'ProviderAudioConferenceSupport' order by SortOrder

------------------------------------- End ProviderAudioConferenceSupport ------------------------------------- 

GO


