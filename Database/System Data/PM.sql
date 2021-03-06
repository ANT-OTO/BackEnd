--select * from PM

declare @TblCode as Table
(
	[Name] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](128) NOT NULL,
	[Pwd] [nvarchar](128) NOT NULL,

	[PersonId] int NOT NULL,
	[ProviderId] int NOT NULL,

	[Active] bit NOT NULL
)	



/*
	select * from Person where Email = 'client@weyimobile.com'
	select * from Provider where Email = 'provider@weyimobile.com'

		select * from Person where [Name] like '%tim%'
	select * from Provider where [Name] like '%tim%'
*/


delete @TblCode

insert into @TblCode	
([Name], [Email], [Pwd], [PersonId], [ProviderId], [Active])
select a.*
from (
	select 'Wei Li' as [Name], 'wli@weyimobile.com' as [Email], '******' as [Pwd], 53 as [PersonId], 9 as [ProviderId], 1 as [Active]
	
	UNION
	
	select 'Tim Kudzma' as [Name], 'tkudzma@weyimobile.com' as [Email], '******' as [Pwd], 28 as [PersonId], 120 as [ProviderId], 1 as [Active]


) a 

insert into [PM]
([Name], [Email], [Pwd], [PersonId], [ProviderId], [Active])
select a.*
from @TblCode a left join  [PM] z on a.[Email] = z.[Email]
where z.Id is null

update a
set a.[Name] = b.[Name], a.[PersonId] = b.[PersonId], a.[ProviderId] = b.[ProviderId], a.[Active] = b.[Active]
from [PM] a inner join  @TblCode b on a.[Email] = b.[Email]

delete
PM where Id in (
	select a.Id from PM a left join @TblCode z on a.[Email] = z.[Email]
	where z.PersonId is null
) 



select * from PM 


insert into SpecialRouting
(Purpose, PersonId, ProviderId, SpecialRoutingTypeCodeId, CreateDate)
select 'Training', a.PersonId, a.ProviderId, 3	-- 3	Both
												-- select * from CodeList where Category = 'SpecialRoutingType'
		, getutcdate()
from PM a left join SpecialRouting z on a.PersonId = z.PersonId and a.ProviderId = z.ProviderId
where z.Id is null


select * from SpecialRouting 