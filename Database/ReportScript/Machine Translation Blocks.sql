select * from TextBlock a inner join TextSession b on a.TextSessionId = b.Id and b.PersonId is not null
where a.CreateDate >= '11/11/2015' and a.CallerEndTime is not null
order by a.Id desc