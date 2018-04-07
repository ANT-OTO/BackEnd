insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
--New, Accepted, In Process, Finished, Cancelled
	select 'WebKeyType' as Category, 1 as CodeId, 'UrlKey' as CodeShort, 'UrlKey' as CodeLong, '1' as SortOrder, 1 as Available
	
	UNION
	
	select 'WebKeyType' as Category, 2 as CodeId, 'Login' as CodeShort, 'Login' as CodeLong, '2' as SortOrder, 1 as Available

	UNION
	
	select 'WebKeyType' as Category, 3 as CodeId, 'Train' as CodeShort, 'Train' as CodeLong, '3' as SortOrder, 1 as Available	
	
) a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

select * from CodeList where Category = 'WebKeyType'
