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
--delete [CodeList] where Category = 'ProviderServiceProductQualificationStatus'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'ProviderServiceProductQualificationStatus' as Category, 1 as CodeId, 'Qualified' as CodeShort, 'Qualified' as CodeLong, '001' as SortOrder,1 as Available
	
	UNION
	
	select 'ProviderServiceProductQualificationStatus' as Category, 2 as CodeId, 'Company Language Pair Not Active' as CodeShort, 'Company Language Pair Not Active' as CodeLong, '002' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderServiceProductQualificationStatus' as Category, 3 as CodeId, 'Interpreter not active' as CodeShort, 'Interpreter not active' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderServiceProductQualificationStatus' as Category, 4 as CodeId, 'Interpreter specialty Not Qualified' as CodeShort, 'Interpreter specialty Not Qualified' as CodeLong, '004' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderServiceProductQualificationStatus' as Category, 5 as CodeId, 'Interpreter certification Not Qualified' as CodeShort, 'Interpreter certification Not Qualified' as CodeLong, '005' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderServiceProductQualificationStatus' as Category, 6 as CodeId, 'Language Pair is not included in product' as CodeShort, 'Language Pair is not included in product' as CodeLong, '006' as SortOrder, 1 as Available

	UNION
	
	select 'ProviderServiceProductQualificationStatus' as Category, 7 as CodeId, 'Interpreter is not included in product' as CodeShort, 'Interpreter is not included in product' as CodeLong, '007' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderServiceProductQualificationStatus' as Category, 8 as CodeId, 'Interpreter Performance Not Qualified' as CodeShort, 'Interpreter Performance Not Qualified' as CodeLong, '008' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderServiceProductQualificationStatus' as Category, 9 as CodeId, 'Interpreter Video/Audio Option Not Qualified' as CodeShort, 'Interpreter Video/Audio Option Not Qualified' as CodeLong, '009' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderServiceProductQualificationStatus' as Category, 10 as CodeId, 'Interpreter Region Not Qualified' as CodeShort, 'Interpreter Region Option Not Qualified' as CodeLong, '010' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderServiceProductQualificationStatus' as Category, 99 as CodeId, 'Unknown Reason' as CodeShort, 'Unknown Reason' as CodeLong, '099' as SortOrder, 1 as Available
	

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
CodeListY where CodeListId in (select Id from CodeList where Category = 'ProviderServiceProductQualificationStatus' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'ProviderServiceProductQualificationStatus' and CodeId not in (select CodeId from @TblCode)


select * from CodeList where Category = 'ProviderServiceProductQualificationStatus' order by SortOrder

------------------------------------- End SecurityAvailability ------------------------------------- 

