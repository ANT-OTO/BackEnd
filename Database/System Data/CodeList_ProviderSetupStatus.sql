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



------------------------------------- Begin ProviderSetupStatus ------------------------------------- 
--delete [CodeList] where Category = 'ProviderSetupStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'ProviderSetupStatus' as Category, 1 as CodeId, 'General Information' as CodeShort, 'General Information' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderSetupStatus' as Category, 2 as CodeId, 'Phone Verification' as CodeShort, 'Phone Verification' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderSetupStatus' as Category, 3 as CodeId, 'Name/Photo' as CodeShort, 'Name/Photo' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderSetupStatus' as Category, 4 as CodeId, 'Language' as CodeShort, 'Language' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderSetupStatus' as Category, 5 as CodeId, 'Translation Certificate' as CodeShort, 'Translation Certificate' as CodeLong, '005' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderSetupStatus' as Category, 6 as CodeId, 'Services' as CodeShort, 'Services' as CodeLong, '006' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderSetupStatus' as Category, 7 as CodeId, 'Interview Time' as CodeShort, 'Interview Time' as CodeLong, '007' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderSetupStatus' as Category, 999 as CodeId, 'Registration Done' as CodeShort, 'Registration Done' as CodeLong, '999' as SortOrder, 1 as Available

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
CodeListY where CodeListId in (select Id from CodeList where Category = 'ProviderSetupStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'ProviderSetupStatus' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'ProviderSetupStatus'


------------------------------------- End ProviderSetupStatus ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)