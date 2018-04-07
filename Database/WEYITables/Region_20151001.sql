
IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'IsDefault' AND Object_ID = Object_ID(N'Region'))
begin
	ALTER TABLE [Region] ADD [IsDefault] int NULL
end


/*

select RegionCode from Region 
group by RegionCode
having count(1) > 1

1
381
39
44
61
672
7
970

*/

update a 
set a.IsDefault = 1
--select *
from Region a where a.RegionCode = '1' and a.Abbreviation = 'US' and isnull(a.IsDefault, 0) = 0

update a 
set a.IsDefault = 1
--select *
from Region a where a.RegionCode = '381' and a.Abbreviation = 'RS' and isnull(a.IsDefault, 0) = 0

update a 
set a.IsDefault = 1
--select *
from Region a where a.RegionCode = '39' and a.Abbreviation = 'IT' and isnull(a.IsDefault, 0) = 0


update a 
set a.IsDefault = 1
--select *
from Region a where a.RegionCode = '44' and a.Abbreviation = 'GB' and isnull(a.IsDefault, 0) = 0

update a 
set a.IsDefault = 1
--select *
from Region a where a.RegionCode = '61' and a.Abbreviation = 'AU' and isnull(a.IsDefault, 0) = 0

update a 
set a.IsDefault = 1
--select *
from Region a where a.RegionCode = '672' and a.Abbreviation = 'NF' and isnull(a.IsDefault, 0) = 0

update a 
set a.IsDefault = 1
--select *
from Region a where a.RegionCode = '7' and a.Abbreviation = 'RU' and isnull(a.IsDefault, 0) = 0

update a 
set a.IsDefault = 1
--select *
from Region a where a.RegionCode = '970' and a.Abbreviation = 'WE' and isnull(a.IsDefault, 0) = 0

update a
set a.IsDefault = 0
--select *
from Region a inner join Region b on a.RegionCode = b.RegionCode and b.IsDefault = 1
where a.IsDefault is null

update a
set a.IsDefault = 1
--select *
from Region a 
where a.IsDefault is null