--select * from LanguageSystemLanguage
--select * from SystemLanguage
--select * from Language where [EnglishName] like '%Chi%'


declare @TblCode as Table
(
	[LanguageId] [int] NOT NULL,
	[SystemLanguageId] [int] NOT NULL
)	



------------------------------------- Begin ------------------------------------- 
--delete [LanguageSystemLanguage]

delete @TblCode

insert into @TblCode	
(LanguageId,SystemLanguageId)
select a.*
from (
	-- 13	English
	-- 1	English	en
	select 13 as LanguageId, 1 as SystemLanguageId

	UNION

	-- 7	Chinese Cantonese
	-- 2	简体中文	zh-CN
	select 7 as LanguageId, 2 as SystemLanguageId

	UNION

	-- 8	Chinese Mandarin
	-- 2	简体中文	zh-CN
	select 8 as LanguageId, 2 as SystemLanguageId

	UNION

	-- 44	Spanish
	-- 4	Español	es
	select 44 as LanguageId, 4 as SystemLanguageId

	UNION

	-- 16	French
	-- 5	Français	fr
	select 16 as LanguageId, 5 as SystemLanguageId

	UNION

	-- 12	Dutch
	-- 6	Deutsch	nl
	select 12 as LanguageId, 6 as SystemLanguageId

	UNION

	-- 37	Portuguese
	-- 7	Português	pt
	select 37 as LanguageId, 7 as SystemLanguageId

	UNION

	-- 23	Italian
	-- 8	Italiano	it
	select 23 as LanguageId, 8 as SystemLanguageId

	UNION

	-- 39	Russian
	-- 9	Pусский	ru
	select 39 as LanguageId, 9 as SystemLanguageId

	UNION

	-- 25	Korean
	-- 10	한국의	ko
	select 25 as LanguageId, 10 as SystemLanguageId

	UNION

	-- 50	Vietnamese
	-- 11	Tiếng Việt	vi
	select 50 as LanguageId, 11 as SystemLanguageId

	UNION

	-- 24	Japanese
	-- 12	日本語	ja
	select 24 as LanguageId, 12 as SystemLanguageId

	UNION

	-- 5	Bulgarian
	-- 13	български език	bg
	select 5 as LanguageId, 13 as SystemLanguageId

	UNION

	-- 17	German
	-- 14	Deutsch	de
	select 17 as LanguageId, 14 as SystemLanguageId
	
	UNION

	-- 1	Arabic
	-- 15	العربية	ar
	select 1 as LanguageId, 15 as SystemLanguageId
	
	UNION

	-- 46	Thai
	-- 16	ไทย	th
	select 46 as LanguageId, 16 as SystemLanguageId
	
	UNION

	-- 31	Malay
	-- 17	Melayu	ms
	select 31 as LanguageId, 17 as SystemLanguageId
	
	UNION

	-- 47	Turkish
	-- 18	Türk	tr
	select 47 as LanguageId, 18 as SystemLanguageId
	
	UNION

	-- 11	Danish
	-- 19	Danske	da
	select 11 as LanguageId, 19 as SystemLanguageId
	
	UNION

	-- 51	Greek
	-- 20	Ελληνική	el
	select 51 as LanguageId, 20 as SystemLanguageId
	
	UNION

	-- 34	Norwegian
	-- 21	Norsk Språk	nb
	select 34 as LanguageId, 21 as SystemLanguageId
	
	UNION

	-- 45	Swedish
	-- 22	Svenska	sv
	select 45 as LanguageId, 22 as SystemLanguageId
	

--select * from SystemLanguage
--select * from Language where EnglishName like 'sw%'

) a

insert into [LanguageSystemLanguage]
(LanguageId,SystemLanguageId)
select a.*
from @TblCode a left join [LanguageSystemLanguage] z on a.LanguageId = z.LanguageId and a.SystemLanguageId = z.SystemLanguageId
where z.Id is null


delete LanguageSystemLanguage where Id in (select a.Id from LanguageSystemLanguage a left join @TblCode z on a.LanguageId = z.LanguageId and a.SystemLanguageId = z.SystemLanguageId where z.LanguageId is null)

select * from LanguageSystemLanguage


------------------------------------- End ------------------------------------- 
