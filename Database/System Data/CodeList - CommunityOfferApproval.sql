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
--delete [CodeList] where Category = 'CommunityOfferApproval'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'CommunityOfferApproval' as Category, 1 as CodeId, 'Approved to Offer to All Qualifed Community Consumers' as CodeShort, 'Approved to Offer to All Qualifed Community Consumers' as CodeLong, '001' as SortOrder,1 as Available
	
	UNION
	
	select 'CommunityOfferApproval' as Category, 2 as CodeId, 'Approved to offer to Selected Community Consumers Only' as CodeShort, 'Approved to offer to Selected Community Consumers Only' as CodeLong, '002' as SortOrder, 1 as Available
	
	UNION
	
	select 'CommunityOfferApproval' as Category, 99 as CodeId, 'Not Approved' as CodeShort, 'Not Approved' as CodeLong, '099' as SortOrder, 1 as Available
	
	
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

select * from CodeList where Category = 'CommunityOfferApproval' order by SortOrder

------------------------------------- End SecurityAvailability ------------------------------------- 

go

