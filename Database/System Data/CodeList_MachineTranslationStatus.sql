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



------------------------------------- Begin MachineTranslationStatus ------------------------------------- 
--delete [CodeList] where Category = 'MachineTranslationStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'MachineTranslationStatus' as Category, 1 as CodeId, 'Image recognition in process' as CodeShort, 'Image recognition in process' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'MachineTranslationStatus' as Category, 2 as CodeId, 'Audio recognition in process' as CodeShort, 'Audio recognition in process' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'MachineTranslationStatus' as Category, 3 as CodeId, 'Machine translation in process' as CodeShort, 'Machine translation in process' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'MachineTranslationStatus' as Category, 4 as CodeId, 'Text to speech in process' as CodeShort, 'Text to speech in process' as CodeLong, '004' as SortOrder, 1 as Available
	
	UNION
	
	select 'MachineTranslationStatus' as Category, 5 as CodeId, 'Re-process started' as CodeShort, 'Re-process started' as CodeLong, '005' as SortOrder, 1 as Available

	UNION

	select 'MachineTranslationStatus' as Category, 91 as CodeId, 'Image recognition Failed' as CodeShort, 'Image recognition failed' as CodeLong, '091' as SortOrder, 1 as Available
	
	UNION
	
	select 'MachineTranslationStatus' as Category, 92 as CodeId, 'Audio recognition Failed' as CodeShort, 'Audio recognition failed' as CodeLong, '092' as SortOrder, 1 as Available

	UNION
	
	select 'MachineTranslationStatus' as Category, 93 as CodeId, 'Machine translation Failed' as CodeShort, 'Machine translation failed' as CodeLong, '093' as SortOrder, 1 as Available

	UNION
	
	select 'MachineTranslationStatus' as Category, 94 as CodeId, 'Text ro speech Failed' as CodeShort, 'Text to speech Failed' as CodeLong, '094' as SortOrder, 1 as Available

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
CodeListY where CodeListId in (select Id from CodeList where Category = 'MachineTranslationStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'MachineTranslationStatus' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'MachineTranslationStatus'


------------------------------------- End MachineTranslationStatus ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)