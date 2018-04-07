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
--delete [CodeList] where Category = 'GenderTypePreferredOption'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'GenderTypePreferredOption' as Category, 1 as CodeId, 'Male Preferred' as CodeShort, 'Prefer a male interpreter' as CodeLong, '001' as SortOrder,1 as Available
	
	UNION
	
	select 'GenderTypePreferredOption' as Category, 2 as CodeId, 'Female Preferred' as CodeShort, 'Prefer a female interpreter' as CodeLong, '002' as SortOrder, 1 as Available
	
	UNION
	
	select 'GenderTypePreferredOption' as Category, 3 as CodeId, 'Male Only' as CodeShort, 'Only need a male interpreter' as CodeLong, '003' as SortOrder, 1 as Available
	
	UNION
	
	select 'GenderTypePreferredOption' as Category, 4 as CodeId, 'Female Only' as CodeShort, 'Only need a female interpreter' as CodeLong, '004' as SortOrder,  1 as Available
	
	UNION
	
	select 'GenderTypePreferredOption' as Category, 5 as CodeId, 'No Preference' as CodeShort, 'No Preference' as CodeLong, '005' as SortOrder,  1 as Available
	
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

select * from CodeList where Category = 'GenderTypePreferredOption' order by SortOrder

------------------------------------- End SecurityAvailability ------------------------------------- 

