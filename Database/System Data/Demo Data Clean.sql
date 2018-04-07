--select * from Provider

update a
set a.Email = convert(varchar(64), newid()), a.Available = 0, a.MobilePhone = ''
from Provider a
where a.Email like '%@%' and a.Id in (2, 4, 6, 8)

update a
set a.Expired = 1
--select * 
from ProviderSession a inner join Provider b on a.ProviderId = b.Id where b.Email not like '%@%' and a.Expired = 0


--select * from Person

update a
set a.Email = convert(varchar(64), newid()), a.MobilePhone = ''
--select *
from Person a
where a.Email like '%@%' and a.Id in (10)

update a
set a.Expired = 1
--select * 
from PersonSession a inner join Person b on a.PersonId = b.Id where b.Email not like '%@%' and a.Expired = 0