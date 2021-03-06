--select * from LanguageAbbyyIR
--select * from Language
--select * from SystemLanguage
--select * from Language where Id in (7, 8, 13)

declare @TblCode as Table
(
	[InputLanguageId] [int] NULL,						-- Language displayed to the user
	[LanguageCode] [nvarchar](32) NULL,
	[OutputSystemLanguageId] [int] NULL,
	[SortOrder] [varchar](8) NULL
)	



------------------------------------- Begin ------------------------------------- 
--delete [LanguageAbbyyIR]

delete @TblCode

insert into @TblCode	
(InputLanguageId,LanguageCode,OutputSystemLanguageId, [SortOrder])
select a.*
from (
	-- 13	English, 1	English	en
	select 13 as InputLanguageId,'English' as LanguageCode, 1 as OutputSystemLanguageId
		, '0001' as [SortOrder]

	UNION

	-- 7	Chinese Cantonese, 2	简体中文	zh-CN
	select 7 as InputLanguageId,'ChinesePRC' as LanguageCode, 2 as OutputSystemLanguageId
		, '0001' as [SortOrder]

	UNION

	-- 7	Chinese Cantonese, 3	繁體中文	zh-TW
	select 7 as InputLanguageId,'ChineseTaiwan' as LanguageCode, 2 as OutputSystemLanguageId
		, '0002' as [SortOrder]

	UNION

	-- 8	Chinese Mandarin, 2	简体中文	zh-CN
	select 8 as InputLanguageId,'ChinesePRC' as LanguageCode, 2 as OutputSystemLanguageId
		, '0001' as [SortOrder]

	UNION

	-- 8	Chinese Mandarin, 3	繁體中文	zh-TW
	select 8 as InputLanguageId,'ChineseTaiwan' as LanguageCode, 2 as OutputSystemLanguageId
		, '0002' as [SortOrder]
		
	UNION

	-- 44	Spanish, 4	Español	es
	select 44 as InputLanguageId,'Spanish' as LanguageCode, 4 as OutputSystemLanguageId
		, '0001' as [SortOrder]

	UNION

	-- 16	French, 5	Français	fr
	select 16 as InputLanguageId,'French' as LanguageCode, 5 as OutputSystemLanguageId
		, '0001' as [SortOrder]

	UNION

	-- 12	Dutch, 6	Nederlandse	nl
	select 12 as InputLanguageId,'Dutch' as LanguageCode, 6 as OutputSystemLanguageId
		, '0001' as [SortOrder]

	UNION

	-- 37	Portuguese, 7	Português	pt
	select 37 as InputLanguageId,'French' as LanguageCode, 7 as OutputSystemLanguageId
		, '0001' as [SortOrder]

	UNION

	-- 23	Italian, 8	Italiano	it
	select 23 as InputLanguageId,'Italian' as LanguageCode, 8 as OutputSystemLanguageId
		, '0001' as [SortOrder]

	UNION

	-- 39	Russian, 9	Pусский	ru
	select 39 as InputLanguageId,'Russian' as LanguageCode, 9 as OutputSystemLanguageId
		, '0001' as [SortOrder]		

	UNION

	-- 25	Korean, 10	한국의	ko
	select 25 as InputLanguageId,'Korean' as LanguageCode, 10 as OutputSystemLanguageId
		, '0001' as [SortOrder]		

	UNION

	-- 50	Vietnamese, 11	Tiếng Việt	vi
	select 50 as InputLanguageId,'Vietnamese' as LanguageCode, 11 as OutputSystemLanguageId
		, '0001' as [SortOrder]	

	UNION

	-- 24	Japanese, 12	日本語	ja
	select 24 as InputLanguageId,'Japanese' as LanguageCode, 12 as OutputSystemLanguageId
		, '0001' as [SortOrder]	

	UNION

	-- 5	Bulgarian, 13	български език	bg
	select 5 as InputLanguageId,'Bulgarian' as LanguageCode, 13 as OutputSystemLanguageId
		, '0001' as [SortOrder]	

	UNION

	-- 17	German, 14	Deutsch	de
	select 17 as InputLanguageId,'German' as LanguageCode, 14 as OutputSystemLanguageId
		, '0001' as [SortOrder]			

	UNION

	-- 1	Arabic, 15	العربية	ar
	select 1 as InputLanguageId,'Arabic' as LanguageCode, 15 as OutputSystemLanguageId
		, '0001' as [SortOrder]			

	UNION

	-- 46	Thai, 16	ไทย	th
	select 46 as InputLanguageId,'Thai' as LanguageCode, 16 as OutputSystemLanguageId
		, '0001' as [SortOrder]

	UNION

	-- 31	Malay, 17	Melayu	ms
	select 31 as InputLanguageId,'Malay' as LanguageCode, 17 as OutputSystemLanguageId
		, '0001' as [SortOrder]

	UNION

	-- 47	Turkish, 18	Türk	tr
	select 47 as InputLanguageId,'Turkish' as LanguageCode, 18 as OutputSystemLanguageId
		, '0001' as [SortOrder]

	UNION

	-- 11	Danish, 19	Danske	da
	select 11 as InputLanguageId,'Danish' as LanguageCode, 19 as OutputSystemLanguageId
		, '0001' as [SortOrder]

	UNION

	-- 51	Greek, 20	Ελληνική	el
	select 51 as InputLanguageId,'Danish' as LanguageCode, 20 as OutputSystemLanguageId
		, '0001' as [SortOrder]

	UNION

	-- 34	Norwegian, 21	Norsk Språk	nb
	select 34 as InputLanguageId,'Norwegian' as LanguageCode, 21 as OutputSystemLanguageId
		, '0001' as [SortOrder]

	UNION

	-- 45	Swedish, 22	Svenska	sv
	select 45 as InputLanguageId,'Swedish' as LanguageCode, 22 as OutputSystemLanguageId
		, '0001' as [SortOrder]
																													
--select * from SystemLanguage
--select * from Language where EnglishName like 's%'

) a 

insert into [LanguageAbbyyIR]
(InputLanguageId,LanguageCode,OutputSystemLanguageId, [SortOrder])
select a.*
from @TblCode a left join  [LanguageAbbyyIR] z on a.InputLanguageId = z.InputLanguageId and a.LanguageCode = z.LanguageCode
where z.Id is null

update a
set a.LanguageCode = b.LanguageCode, a.[SortOrder] = b.[SortOrder]
from [LanguageAbbyyIR] a inner join  @TblCode b on a.InputLanguageId = b.InputLanguageId and a.LanguageCode = b.LanguageCode


delete LanguageAbbyyIR where Id in (select a.Id from [LanguageAbbyyIR] a left join @TblCode z on a.InputLanguageId = z.InputLanguageId and a.LanguageCode = z.LanguageCode where z.InputLanguageId is null)

select * from LanguageAbbyyIR order by InputLanguageId, SortOrder


------------------------------------- End ------------------------------------- 
