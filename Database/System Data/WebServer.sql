
-- select * from [WebServer]
insert into [WebServer]
(URL, [Local], Available, CreateDate, LastUpdate)
select a.*, GETDATE(), GETDATE()
from (
	select distinct a.*
	from (
		select 'https://www.weyimobile.com/api/' as URL, 1 as [Local], 1 as Available
	
		UNION
	
		select 'https://api.weyimobile.com/api/' as URL, 1 as [Local], 1 as Available
	) a
	
	
) a left join  [WebServer] z on a.URL = z.URL
where z.Id is null

select * from [WebServer]