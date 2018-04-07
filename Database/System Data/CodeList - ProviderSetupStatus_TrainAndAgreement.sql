insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
--New, Accepted, In Process, Finished, Cancelled
	select 'ProviderTrainStatus' as Category, 100 as CodeId, 'Train' as CodeShort, 'Training' as CodeLong, '100' as SortOrder, 1 as Available
	
	UNION
	
	select 'ProviderTrainStatus' as Category, 150 as CodeId, 'Payment Agreement' as CodeShort, 'Payment Agreement' as CodeLong, '150' as SortOrder, 1 as Available
	

	
	
) a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

select * from CodeList where Category = 'ProviderTrainStatus'