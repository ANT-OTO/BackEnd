--select * from CodeList where Category = 'ProviderVideoOption'

declare @TblCode as Table
(
	[Category] [nvarchar](100) NOT NULL,
	[CodeId] [int] NOT NULL,
	[CodeShort] [nvarchar](256) NOT NULL,
	[CodeLong] [nvarchar](256) NOT NULL,
	[SortOrder] [nvarchar](256) NOT NULL,
	[Available] [bit] NOT NULL
)	




delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'ProviderVideoOption' as Category, 1 as CodeId, 'Video Only' as CodeShort, 'Video Only' as CodeLong, '001' as SortOrder, 0 as Available
	
	UNION
	
	select 'ProviderVideoOption' as Category, 2 as CodeId, 'Audio Only' as CodeShort, 'Audio Only' as CodeLong, '003' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderVideoOption' as Category, 3 as CodeId, 'Video and Audio' as CodeShort, 'Video and Audio' as CodeLong, '002' as SortOrder, 1 as Available
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

select * from CodeList where Category = 'ProviderVideoOption' order by SortOrder


go

