--select * from CodeList

declare @TblCode as Table
(
	[Category] [nvarchar](128) NOT NULL,
	[CodeId] [int] NOT NULL,
	[CodeShort] [nvarchar](1024) NOT NULL,
	[CodeLong] [nvarchar](1024) NOT NULL,
	[SortOrder] [varchar](8) NOT NULL,
	[Available] [bit] NOT NULL
)	



------------------------------------- Begin DPTDenyReason ------------------------------------- 
--delete [CodeList] where Category = 'DPTDenyReason'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'DPTDenyReason' as Category, 2 as CodeId, 'Content not clear' as CodeShort, 'Content not clear' as CodeLong, '002' as SortOrder, 1 as Available

	--UNION
	
	--select 'DPTDenyReason' as Category, 2 as CodeId, 'Audio not clear' as CodeShort, 'Audio not clear' as CodeLong, '002' as SortOrder, 1 as Available

	--UNION
	
	--select 'DPTDenyReason' as Category, 3 as CodeId, 'Image not clear' as CodeShort, 'Image not clear' as CodeLong, '003' as SortOrder, 1 as Available

	--UNION
	
	--select 'DPTDenyReason' as Category, 4 as CodeId, 'Meaning of text not clear' as CodeShort, 'Meaning of text not clear' as CodeLong, '004' as SortOrder, 1 as Available

	--UNION
	
	--select 'DPTDenyReason' as Category, 5 as CodeId, 'Instruction not clear' as CodeShort, 'Instruction not clear' as CodeLong, '005' as SortOrder, 1 as Available
	
	UNION
	
	select 'DPTDenyReason' as Category, 6 as CodeId, 'Wrong Language' as CodeShort, 'Wrong Language' as CodeLong, '006' as SortOrder, 1 as Available
	
	UNION
	
	select 'DPTDenyReason' as Category, 7 as CodeId, 'Illegal Content.' as CodeShort, 
		'This translation request involves illegal information. We will disable your account if you send more.' as CodeLong, '999' as SortOrder, 1 as Available

	UNION

	
	select 'DPTDenyReason' as Category, 8 as CodeId, 
		'Content too long. Need Pro.' as CodeShort, 
		'Fong Translation is only for short and conversational sentences for now. For longer text or complex images, please stay tuned for Fong Translation Pro. Thank you.' as CodeLong, '007' as SortOrder, 1 as Available

	UNION

	select 'DPTDenyReason' as Category, 999 as CodeId, 'Other' as CodeShort, 'Other' as CodeLong, '998' as SortOrder, 1 as Available

	UNION
	
	select 'DPTDenyReason' as Category, 9999 as CodeId, 'You have reached your daily limit for Fong Live. Please use Fong Auto.' as CodeShort, 'You have reached your daily limit for Fong Live. Please use Fong Auto.' as CodeLong, 'ZZY' as SortOrder, 0 as Available

	UNION
	
	select 'DPTDenyReason' as Category, 10000 as CodeId, 'This cannot be serviced. Reason: ' as CodeShort, 'This cannot be serviced. Reason:  ' as CodeLong, 'ZZZ' as SortOrder, 0 as Available


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
CodeListY where CodeListId in (select Id from CodeList where Category = 'DPTDenyReason' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'DPTDenyReason' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'DPTDenyReason' order by SortOrder


------------------------------------- End DPTDenyReason ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)