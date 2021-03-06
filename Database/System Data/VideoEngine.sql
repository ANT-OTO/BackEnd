--select * from [VideoEngine]


declare @TblContent as Table
(
	[Id] int NOT NULL,
	[EngineName] [nvarchar](64) NOT NULL
)	


insert into @TblContent
([Id], [EngineName])
select a.*
from (
	select 1 as Id, N'Twilio' as [Name]
	
) a 


insert into [VideoEngine]
([Id], [EngineName], CreateDate, LastUpdate)
select a.*, GETDATE(), GETDATE()
from @TblContent a left join  [VideoEngine] z on a.Id = z.Id
where z.Id is null

update a
set a.[EngineName] = b.[EngineName]
	,a.LastUpdate = GETDATE()
from [VideoEngine] a inner join  @TblContent b on a.Id = b.Id
where Not ( a.[EngineName] = b.[EngineName])

select * from VideoEngine