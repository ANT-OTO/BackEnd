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



------------------------------------- Begin VOSPhoneRequestStatus ------------------------------------- 
--delete [CodeList] where Category = 'VOSPhoneRequestStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'VOSPhoneRequestStatus' as Category, 1 as CodeId, 'PhoneIncoming' as CodeShort, 'PhoneIncoming' as CodeLong, '001' as SortOrder, 1 as Available
	
	

	UNION
	
	select 'VOSPhoneRequestStatus' as Category, 2 as CodeId, 'Authenrized' as CodeShort, 'Authenrized' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'VOSPhoneRequestStatus' as Category, 3 as CodeId, 'Route to Operator' as CodeShort, 'Route to Operator' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'VOSPhoneRequestStatus' as Category, 4 as CodeId, 'Operator Accepted' as CodeShort, 'Operator Accepted' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'VOSPhoneRequestStatus' as Category, 5 as CodeId, 'Operator Handled' as CodeShort, 'Operator Handled' as CodeLong, '005' as SortOrder, 1 as Available

	UNION
	
	select 'VOSPhoneRequestStatus' as Category, 93 as CodeId, 'AuthHelperRouting' as CodeShort, 'AuthHelperRouting' as CodeLong, '093' as SortOrder, 1 as Available

	UNION
	
	select 'VOSPhoneRequestStatus' as Category, 94 as CodeId, 'AuthHelperAnswered' as CodeShort, 'AuthHelperAnswered' as CodeLong, '094' as SortOrder, 1 as Available

	UNION
	
	select 'VOSPhoneRequestStatus' as Category, 95 as CodeId, 'RequestGenerated' as CodeShort, 'RequestGenerated' as CodeLong, '095' as SortOrder, 1 as Available

	UNION
	
	select 'VOSPhoneRequestStatus' as Category, 96 as CodeId, 'ProviderAccepted' as CodeShort, 'ProviderAccepted' as CodeLong, '096' as SortOrder, 1 as Available

	UNION
	
	select 'VOSPhoneRequestStatus' as Category, 97 as CodeId, 'RequestFinished' as CodeShort, 'RequestFinished' as CodeLong, '097' as SortOrder, 1 as Available

	UNION
	
	select 'VOSPhoneRequestStatus' as Category, 98 as CodeId, 'RequestCancelled' as CodeShort, 'RequestCancelled' as CodeLong, '098' as SortOrder, 1 as Available

	UNION
	
	select 'VOSPhoneRequestStatus' as Category, 99 as CodeId, 'Route To OPI' as CodeShort, 'Route To OPI' as CodeLong, '099' as SortOrder, 1 as Available


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
CodeListY where CodeListId in (select Id from CodeList where Category = 'VOSPhoneRequestStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'VOSPhoneRequestStatus' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'VOSPhoneRequestStatus'


------------------------------------- End VOSPhoneRequestStatus ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)