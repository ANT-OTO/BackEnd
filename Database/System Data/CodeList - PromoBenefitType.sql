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



------------------------------------- Begin PromoBenefitType ------------------------------------- 
--delete [CodeList] where Category = 'PromoBenefitType'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'PromoBenefitType' as Category, 1 as CodeId, 'FreeMoney' as CodeShort, 'FreeMoney' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'PromoBenefitType' as Category, 2 as CodeId, 'Spend&Gain' as CodeShort, 'Spend&Gain' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'PromoBenefitType' as Category, 3 as CodeId, 'RequestDiscount' as CodeShort, 'RequestDiscount' as CodeLong, '003' as SortOrder, 1 as Available


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
CodeListY where CodeListId in (select Id from CodeList where Category = 'PromoBenefitType' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'PromoBenefitType' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'PromoBenefitType'


------------------------------------- End PromoBenefitType ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)