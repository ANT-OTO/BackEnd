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



------------------------------------- Begin ProviderServiceTrainingAction ------------------------------------- 
--delete [CodeList] where Category = 'ProviderServiceTrainingAction'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'ProviderServiceTrainingAction' as Category, 1 as CodeId, 'Start Training' as CodeShort, 'Start Training' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION

	select 'ProviderServiceTrainingAction' as Category, 2 as CodeId, 'Training Finished' as CodeShort, 'Training Finished' as CodeLong, '002' as SortOrder, 1 as Available

	UNION

	select 'ProviderServiceTrainingAction' as Category, 3 as CodeId, 'Cancel Training' as CodeShort, 'Cancel Training' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderServiceTrainingAction' as Category, 4 as CodeId, 'Go Live' as CodeShort, 'Go Live' as CodeLong, '004' as SortOrder, 1 as Available
	
	UNION

	select 'ProviderServiceTrainingAction' as Category, 5 as CodeId, 'Deny Service' as CodeShort, 'Deny Service' as CodeLong, '005' as SortOrder, 1 as Available

	UNION

	select 'ProviderServiceTrainingAction' as Category, 6 as CodeId, 'Live Test' as CodeShort, 'Live Test' as CodeLong, '006' as SortOrder, 1 as Available

	UNION

	select 'ProviderServiceTrainingAction' as Category, 7 as CodeId, 'Cancel Live Test' as CodeShort, 'Cancel Live Test' as CodeLong, '007' as SortOrder, 1 as Available

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
CodeListY where CodeListId in (select Id from CodeList where Category = 'ProviderServiceTrainingAction' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'ProviderServiceTrainingAction' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'ProviderServiceTrainingAction'


------------------------------------- End ProviderServiceTrainingAction ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)