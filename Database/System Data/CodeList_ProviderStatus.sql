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



------------------------------------- Begin ProviderStatus ------------------------------------- 
--delete [CodeList] where Category = 'ProviderStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'ProviderStatus' as Category, 1 as CodeId, 'New' as CodeShort, 'New' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderStatus' as Category, 2 as CodeId, 'MobilePhoneValidated' as CodeShort, 'MobilePhoneValidated' as CodeLong, '002' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderStatus' as Category, 3 as CodeId, 'SetUpFinished' as CodeShort, 'SetUpFinished' as CodeLong, '003' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderStatus' as Category, 4 as CodeId, 'Pending Interview' as CodeShort, 'Pending Interview' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderStatus' as Category, 5 as CodeId, 'No Approved Service' as CodeShort, 'No Approved Service' as CodeLong, '005' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderStatus' as Category, 6 as CodeId, 'Available' as CodeShort, 'Available' as CodeLong, '006' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderStatus' as Category, 7 as CodeId, 'Available as Alternative' as CodeShort, 'Available as Alternative' as CodeLong, '007' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderStatus' as Category, 8 as CodeId, 'Not Available' as CodeShort, 'Not Available' as CodeLong, '008' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderStatus' as Category, 9 as CodeId, 'Has Open Task' as CodeShort, 'Has Open Task' as CodeLong, '009' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderStatus' as Category, 10 as CodeId, 'TIS: Interviewing Accepted' as CodeShort, 'Task In Session: Interviewing Accepted' as CodeLong, '010' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderStatus' as Category, 11 as CodeId, 'TIS: Interviewing Confirmed' as CodeShort, 'Task In Session: Interviewing Confirmed' as CodeLong, '011' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderStatus' as Category, 12 as CodeId, 'TIS: Interviewing' as CodeShort, 'Task In Session: Interviewing' as CodeLong, '012' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderStatus' as Category, 13 as CodeId, 'TIS: Interviewing Finished' as CodeShort, 'Task In Session: Interviewing Finished' as CodeLong, '013' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderStatus' as Category, 14 as CodeId, 'TIS: Being Interviewed Accepted' as CodeShort, 'Task In Session: Being Interviewed Accepted' as CodeLong, '014' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderStatus' as Category, 15 as CodeId, 'TIS: Being Interviewed Confirmed' as CodeShort, 'Task In Session: Being Interviewed Confirmed' as CodeLong, '015' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderStatus' as Category, 16 as CodeId, 'TIS: Being Interviewed' as CodeShort, 'Task In Session: Being Interviewed' as CodeLong, '016' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderStatus' as Category, 17 as CodeId, 'TIS: Being Interviewed Finished' as CodeShort, 'Task In Session: Being Interviewed Finished' as CodeLong, '017' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderStatus' as Category, 18 as CodeId, 'TIS: Request Accepted' as CodeShort, 'Task In Session: Request Accepted' as CodeLong, '018' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderStatus' as Category, 19 as CodeId, 'TIS: Request Confirmed' as CodeShort, 'Task In Session: Request Confirmed' as CodeLong, '019' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderStatus' as Category, 20 as CodeId, 'TIS: Request In Service' as CodeShort, 'Task In Session: Request In Service' as CodeLong, '020' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderStatus' as Category, 21 as CodeId, 'TIS: Request Finished' as CodeShort, 'Task In Session: Request Finished' as CodeLong, '021' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderStatus' as Category, 22 as CodeId, 'TIS: DPT In Service' as CodeShort, 'Task In Session:DPT In Service' as CodeLong, '022' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderStatus' as Category, 23 as CodeId, 'TIS: DPT Finished' as CodeShort, 'Task In Session: DPT Finished' as CodeLong, '023' as SortOrder, 1 as Available

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
CodeListY where CodeListId in (select Id from CodeList where Category = 'ProviderStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'ProviderStatus' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'ProviderStatus'


------------------------------------- End ProviderStatus ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)