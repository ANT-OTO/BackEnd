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



------------------------------------- Begin DPTType ------------------------------------- 
--delete [CodeList] where Category = 'DPTType'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'DPTType' as Category, 4 as CodeId, 'Direct Translation: Audio' as CodeShort, 'Direct Translation: Audio' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'DPTType' as Category, 5 as CodeId, 'Direct Translation: Text' as CodeShort, 'Direct Translation: Text' as CodeLong, '005' as SortOrder, 1 as Available
	
	UNION
	
	select 'DPTType' as Category, 6 as CodeId, 'Direct Translation: Image' as CodeShort, 'Direct Translation: Image' as CodeLong, '006' as SortOrder, 1 as Available

	UNION
	
	select 'DPTType' as Category, 7 as CodeId, 'Direct Translation' as CodeShort, 'Direct Translation' as CodeLong, '001' as SortOrder, 1 as Available

	UNION
	
	select 'DPTType' as Category, 8 as CodeId, 'Direct Translation: Image/Audio' as CodeShort, 'Direct Translation: Image/Audio' as CodeLong, '008' as SortOrder, 1 as Available


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
CodeListY where CodeListId in (select Id from CodeList where Category = 'DPTType' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'DPTType' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'DPTType' order by SortOrder


------------------------------------- End DPTType ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)