--select * from SpecialRouting

declare @Tbl as Table
(
	[Purpose] nvarchar(128) NOT NULL,				
	[PersonId] int NOT NULL,					
	[ProviderId] int NULL,

	[SpecialRoutingTypeCodeId] int NOT NULL
)	



--select * from Person where Email = 'client@weyimobile.com'

delete @Tbl

insert into @Tbl	
([Purpose], [PersonId], [ProviderId], [SpecialRoutingTypeCodeId])
select a.*
from (
	select 'Apple Review for Provider' as [Purpose], 171 as [PersonId], 336 as [ProviderId], 3 as [SpecialRoutingTypeCodeId]

																-- All calls from WEYI Client (test@test.com) (171) will only be routed to Apple Reviewer (appleTester@weyimobile.com) (336)
																-- Apple Reviewer (appleTester@weyimobile.com) (336) will not get any calls from client other than WEYI Client (test@test.com) (171)
	UNION
	
	select 'Apple Review for Client' as [Purpose], 311 as [PersonId], 96 as [ProviderId], 3 as [SpecialRoutingTypeCodeId]

																-- All calls from AppTester (appleTester@weyimobile.com) (311) will only be routed to Wei Li (wli@hticonsulting.net) (96)
																-- Wei Li (wli@hticonsulting.net) (96) will not get any calls from client other than AppTester (appleTester@weyimobile.com)(311)

	UNION
	
	select 'Xiang Testing' as [Purpose], 346 as [PersonId], 349 as [ProviderId], 3 as [SpecialRoutingTypeCodeId]

																-- All calls from Xiang (xiang@weyimobile.com) (346) will only be routed to XiangProvider (xiang@weyimobile.com) (336)
																-- XiangProvider (xiang@weyimobile.com) (336) will not get any calls from client other than Xiang (xiang@weyimobile.com) (346)


	UNION
	
	select 'George Testing' as [Purpose], 371 as [PersonId], 344 as [ProviderId], 1 as [SpecialRoutingTypeCodeId]

																-- All calls from George (PersonId=371) will only be routed to Wei (provider@weyimobile.com) (344)

	UNION
	
	select 'George Testing' as [Purpose], 372 as [PersonId], 344 as [ProviderId], 1 as [SpecialRoutingTypeCodeId]

																-- All calls from George (PersonId=372) will only be routed to Wei (provider@weyimobile.com) (344)

	UNION
	
	select 'George Testing' as [Purpose], 373 as [PersonId], 344 as [ProviderId], 1 as [SpecialRoutingTypeCodeId]

																-- All calls from George (PersonId=373) will only be routed to Wei (provider@weyimobile.com) (344)

	UNION
	
	select 'George Testing' as [Purpose], 374 as [PersonId], 344 as [ProviderId], 1 as [SpecialRoutingTypeCodeId]

																-- All calls from George (PersonId=374) will only be routed to Wei (provider@weyimobile.com) (344)

) a 

insert into [SpecialRouting]
([Purpose], [PersonId], [ProviderId], [SpecialRoutingTypeCodeId])
select a.*
from @Tbl a left join  [SpecialRouting] z on a.[PersonId] = z.[PersonId] and a.[ProviderId] = z.[ProviderId]
where z.Id is null

update a
set a.[Purpose] = b.[Purpose], a.[SpecialRoutingTypeCodeId] = b.[SpecialRoutingTypeCodeId]
from [SpecialRouting] a inner join  @Tbl b on a.[PersonId] = b.[PersonId] and a.[ProviderId] = b.[ProviderId]

delete
SpecialRouting where Id in (
	select a.Id from SpecialRouting a left join @Tbl z on a.[PersonId] = z.[PersonId] and a.[ProviderId] = z.[ProviderId]
	where z.PersonId is null
) 



select * from SpecialRouting 
