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



------------------------------------- Begin ProviderServiceTrainingStatus ------------------------------------- 
--delete [CodeList] where Category = 'ProviderServiceTrainingStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'ProviderServiceTrainingStatus' as Category, 1 as CodeId, 'In Registration' as CodeShort, 'In Registration' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION

	select 'ProviderServiceTrainingStatus' as Category, 2 as CodeId, 'Ready For Training' as CodeShort, 'Ready For Training' as CodeLong, '002' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderServiceTrainingStatus' as Category, 3 as CodeId, 'In Training' as CodethShort, 'In Training' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderServiceTrainingStatus' as Category, 4 as CodeId, 'Trained' as CodethShort, 'Trained' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderServiceTrainingStatus' as Category, 5 as CodeId, 'Live' as CodethShort, 'Live' as CodeLong, '005' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderServiceTrainingStatus' as Category, 6 as CodeId, 'Denied' as CodethShort, 'Denied' as CodeLong, '006' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderServiceTrainingStatus' as Category, 7 as CodeId, 'Live Test' as CodethShort, 'Live Test' as CodeLong, '007' as SortOrder, 1 as Available


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
CodeListY where CodeListId in (select Id from CodeList where Category = 'ProviderServiceTrainingStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'ProviderServiceTrainingStatus' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'ProviderServiceTrainingStatus'


------------------------------------- End ProviderServiceTrainingStatus ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)