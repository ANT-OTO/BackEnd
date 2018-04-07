--select * from CodeList where Category = 'SecurityAvailability'

declare @TblCode as Table
(
	[Category] [nvarchar](100) NOT NULL,
	[CodeId] [int] NOT NULL,
	[CodeShort] [nvarchar](256) NOT NULL,
	[CodeLong] [nvarchar](256) NOT NULL,
	[SortOrder] [nvarchar](256) NOT NULL,
	[Available] [bit] NOT NULL
)	



------------------------------------- Begin SecurityAvailability ------------------------------------- 
--delete [CodeList] where Category = 'ProductVideoRequirement'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'ProductVideoRequirement' as Category, 1 as CodeId, 'Video Remote Interpretation (VRI)' as CodeShort, 'Video Remote Interpretation (VRI)' as CodeLong, '001' as SortOrder,1 as Available
	
	UNION
	
	--select 'ProductVideoRequirement' as Category, 2 as CodeId, 'Video Preferred' as CodeShort, 'Prefer Video Interpretation' as CodeLong, '002' as SortOrder, 1 as Available
	
	--UNION
	
	select 'ProductVideoRequirement' as Category, 3 as CodeId, 'Audio Only (OPI)' as CodeShort, 'Audio Only (OPI)' as CodeLong, '003' as SortOrder, 1 as Available
	
	UNION
	
	--select 'ProductVideoRequirement' as Category, 4 as CodeId, 'Audio Preferred' as CodeShort, 'Prefer Audio Interpretation' as CodeLong, '004' as SortOrder,  1 as Available
	
	--UNION
	
	select 'ProductVideoRequirement' as Category, 9 as CodeId, 'VRI Preferred, Auto Switch to OPI when VRI not available' as CodeShort, 'VRI Preferred, Auto Switch to OPI when VRI not available' as CodeLong, '005' as SortOrder,  1 as Available
	
	UNION
	
	select 'ProductVideoRequirement' as Category, 7 as CodeId, 'VRI Preferred, Require User Confirmation to Switch to OPI' as CodeShort, 'VRI Preferred, Require User Confirmation to Switch to OPI' as CodeLong, '007' as SortOrder,  1 as Available

	UNION
	
	select 'ProductVideoRequirement' as Category, 5 as CodeId, 'No Preferrence' as CodeShort, 'No Preferrence' as CodeLong, '009' as SortOrder,  1 as Available
	
) a 

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available, CreateDate, LastUpdate)
select a.Category, a.CodeId, a.CodeShort, a.CodeLong, a.SortOrder, a.Available,
	getutcdate(), getutcdate()
from @TblCode a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

update a
set a.CodeShort = b.CodeShort, a.CodeLong = b.CodeLong, a.SortOrder = b.SortOrder, a.Available = b.Available
from [CodeList] a inner join  @TblCode b on a.Category = b.Category and a.CodeId = b.CodeId 



delete 
--select * from
CodeListY where CodeListId in (select Id from CodeList where Category = 'ProductVideoRequirement' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'ProductVideoRequirement' and CodeId not in (select CodeId from @TblCode)


select * from CodeList where Category = 'ProductVideoRequirement' order by SortOrder

------------------------------------- End SecurityAvailability ------------------------------------- 

