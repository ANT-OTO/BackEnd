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



------------------------------------- Begin MsgDeliveryMethod ------------------------------------- 
--delete [CodeList] where Category = 'MsgDeliveryMethod'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'MsgDeliveryMethod' as Category, 1 as CodeId, 'Mobile Push' as CodeShort, 'Mobile Push' as CodeLong, '001' as SortOrder, 1 as Available
	
	--UNION
	
	--select 'MsgDeliveryMethod' as Category, 2 as CodeId, 'Android Push' as CodeShort, 'Android Push' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'MsgDeliveryMethod' as Category, 3 as CodeId, 'Email' as CodeShort, 'Email' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'MsgDeliveryMethod' as Category, 31 as CodeId, 'EmailSubject' as CodeShort, 'EmailSubject' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'MsgDeliveryMethod' as Category, 4 as CodeId, 'Text' as CodeShort, 'Text' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'MsgDeliveryMethod' as Category, 5 as CodeId, 'Application' as CodeShort, 'Application' as CodeLong, '005' as SortOrder, 1 as Available


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
CodeList where Category = 'MsgDeliveryMethod' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'MsgDeliveryMethod' order by SortOrder

------------------------------------- End MsgDeliveryMethod ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)