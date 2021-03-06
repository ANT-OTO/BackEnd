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



------------------------------------- Begin DPTEscalateReason ------------------------------------- 
--delete [CodeList] where Category = 'DPTEscalateReason'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'DPTEscalateReason' as Category, 1 as CodeId, 'Accept By Mistake' as CodeShort, 'Accept By Mistake' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'DPTEscalateReason' as Category, 2 as CodeId, 'Content not very clear' as CodeShort, 'Content not very clear' as CodeLong, '002' as SortOrder, 1 as Available

	--UNION
	
	--select 'DPTEscalateReason' as Category, 2 as CodeId, 'Audio not very clear' as CodeShort, 'Audio not very clear' as CodeLong, '002' as SortOrder, 1 as Available

	--UNION
	
	--select 'DPTEscalateReason' as Category, 3 as CodeId, 'Image not very clear' as CodeShort, 'Image not very clear' as CodeLong, '003' as SortOrder, 1 as Available

	--UNION
	
	--select 'DPTEscalateReason' as Category, 4 as CodeId, 'Meaning of text not very clear' as CodeShort, 'Meaning of text not very clear' as CodeLong, '004' as SortOrder, 1 as Available

	--UNION
	
	--select 'DPTEscalateReason' as Category, 5 as CodeId, 'Instruction not very clear' as CodeShort, 'Instruction not very clear' as CodeLong, '005' as SortOrder, 1 as Available
	
	UNION
	
	select 'DPTEscalateReason' as Category, 6 as CodeId, 'Not able to handle' as CodeShort, 'Not able to handle' as CodeLong, '006' as SortOrder, 1 as Available

	UNION
	
	select 'DPTEscalateReason' as Category, 999 as CodeId, 'Other' as CodeShort, 'Other' as CodeLong, '999' as SortOrder, 1 as Available


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
CodeListY where CodeListId in (select Id from CodeList where Category = 'DPTEscalateReason' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'DPTEscalateReason' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'DPTEscalateReason'


------------------------------------- End DPTEscalateReason ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)