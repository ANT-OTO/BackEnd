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



------------------------------------- Begin DPTStatus ------------------------------------- 
--delete [CodeList] where Category = 'DPTStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
/*
Real Status:
1	Human Translator Direct Translation Request Received
2	Sent To Translator
3	Accepted by Translator
4	Translation In Process
5	Finished
91	Cancelled By Client
92	Cancelled by System
93	Escalated by Translator
94	Denied by Translator
95	Denied by System
96	Escalated by System
*/
	
	select 'DPTStatus' as Category, 1 as CodeId, 'Human Translator Direct Translation Request Received' as CodeShort, 'Sending to Translators' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'DPTStatus' as Category, 2 as CodeId, 'Sent To Translators' as CodeShort, 'Sent To Translators' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'DPTStatus' as Category, 3 as CodeId, 'Accepted by Translator' as CodeShort, 'Accepted by Translator' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'DPTStatus' as Category, 4 as CodeId, 'Translation In Process' as CodeShort, 'Translation In Process' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'DPTStatus' as Category, 5 as CodeId, 'Finished' as CodeShort, 'Finished' as CodeLong, '005' as SortOrder, 1 as Available

	UNION

	select 'DPTStatus' as Category, 91 as CodeId, 'Cancelled By Client' as CodeShort, 'User Terminated the Translation Service.' as CodeLong, '091' as SortOrder, 1 as Available
	
	UNION
	
	select 'DPTStatus' as Category, 92 as CodeId, 'Cancelled by System' as CodeShort, 'WEYI Terminated the Translation Service.' as CodeLong, '092' as SortOrder, 1 as Available

	UNION
	
	select 'DPTStatus' as Category, 93 as CodeId, 'Escalated by Translator' as CodeShort, 'Service Escalating to Upper-graded Translators' as CodeLong, '093' as SortOrder, 1 as Available

	UNION
	
	select 'DPTStatus' as Category, 94 as CodeId, 'Denied by Translator' as CodeShort, 'Translation Request Declined' as CodeLong, '094' as SortOrder, 1 as Available

	UNION
	
	select 'DPTStatus' as Category, 95 as CodeId, 'Denied by System' as CodeShort, 'Translation Request Declined' as CodeLong, '095' as SortOrder, 1 as Available

	UNION
	
	select 'DPTStatus' as Category, 96 as CodeId, 'Escalated by System' as CodeShort, 'Service Escalating to Upper-graded Translators' as CodeLong, '093' as SortOrder, 1 as Available
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
CodeListY where CodeListId in (select Id from CodeList where Category = 'DPTStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'DPTStatus' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'DPTStatus' order by SortOrder, CodeId


------------------------------------- End DPTStatus ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)