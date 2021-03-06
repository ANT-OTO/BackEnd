--select * from LanguageNuanceASR
--select * from Language
--select * from SystemLanguage
--select * from Language where Id in (7, 8, 13)

declare @TblCode as Table
(
	[InputLanguageId] [int] NULL,						-- Language displayed to the user
	[InputLanguageCode] [nvarchar](8) NULL,
	[OutputSystemLanguageId] [int] NULL,
	[OutputLanguageCode] [nvarchar](8) NULL,
	[SortOrder] [varchar](8) NULL
)	



------------------------------------- Begin ------------------------------------- 
--delete [LanguageNuanceASR]

delete @TblCode

insert into @TblCode	
(InputLanguageId,InputLanguageCode,OutputSystemLanguageId,OutputLanguageCode, SortOrder)
select a.*
from (
	-- 12	Dutch,  6	Nederlandse	nl
	select 12 as InputLanguageId,'nld-NLD' as InputLanguageCode, 6 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0001' as [SortOrder]
		
	UNION

	-- 16	French, 5	Français	fr
	select 16 as InputLanguageId,'fra-FRA' as InputLanguageCode, 5 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0001' as [SortOrder]

	UNION
	
	-- 17	German, 14	Deutsch	de
	select 17 as InputLanguageId,'deu-DEU' as LanguageCode, 14 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0001' as [SortOrder]

	UNION
	
	-- 23	Italian, 8	Italiano	it
	select 23 as InputLanguageId,'ita-ITA' as LanguageCode, 8 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0001' as [SortOrder]

	UNION
	
	-- 24	Japanese, 12	日本語	ja
	select 24 as InputLanguageId,'jpn-JPN' as LanguageCode, 12 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0001' as [SortOrder]

	UNION
	
	-- 25	Korean, 10	한국의	ko
	select 25 as InputLanguageId,'kor-KOR' as LanguageCode, 10 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0001' as [SortOrder]

	UNION
	
	-- 37	Portuguese, 7	Português	pt
	select 37 as InputLanguageId,'por-PRT' as LanguageCode, 7 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0001' as [SortOrder]
	
	UNION

	-- 39	Russian, 9	Pусский	ru
	select 39 as InputLanguageId,'rus-RUS' as LanguageCode, 9 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0001' as [SortOrder]
	
	UNION

	-- 44	Spanish, 4	Español	es
	select 44 as InputLanguageId,'spa-ESP' as LanguageCode, 4 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0001' as [SortOrder]

	UNION

	-- 44	Spanish, 4	Español	es
	select 44 as InputLanguageId,'spa-XLA' as LanguageCode, 4 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0002' as [SortOrder]
	
	UNION

	-- 50	Vietnamese, 11	Tiếng Việt	vi
	select 50 as InputLanguageId,'vie-VNM' as LanguageCode, 11 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0001' as [SortOrder]
	
	UNION

	-- 1	Arabic, 15	العربية	ar
	select 1 as InputLanguageId,'ara-EGY' as LanguageCode, 15 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0001' as [SortOrder]
	
	UNION

	-- 46	Thai, 16	ไทย	th
	select 46 as InputLanguageId,'tha-THA' as LanguageCode, 16 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0001' as [SortOrder]

	UNION

	-- 31	Malay, 17	Melayu	ms
	select 31 as InputLanguageId,'zlm-MYS' as LanguageCode, 17 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0001' as [SortOrder]
	
	UNION

	-- 47	Turkish, 18	Türk	tr
	select 47 as InputLanguageId,'tur-TUR' as LanguageCode, 18 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0001' as [SortOrder]
	
	UNION

	-- 11	Danish, 19	Danske	da
	select 11 as InputLanguageId,'dan-DNK' as LanguageCode, 19 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0001' as [SortOrder]
	
	UNION

	-- 51	Greek, 20	Ελληνική	el
	select 51 as InputLanguageId,'ell-GRC' as LanguageCode, 20 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0001' as [SortOrder]
	
	UNION

	-- 34	Norwegian, 21	Norsk Språk	nb
	select 34 as InputLanguageId,'swe-SWE' as LanguageCode, 21 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0001' as [SortOrder]

	UNION

	-- 45	Swedish, 22	Svenska	sv
	select 45 as InputLanguageId,'swe-SWE' as LanguageCode, 22 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0001' as [SortOrder]

	UNION

	-- 7	Chinese Cantonese, 2	简体中文	zh-CN
	select 7 as InputLanguageId,'yue-CHN' as LanguageCode, 2 as OutputSystemLanguageId, NULL as OutputLanguageCode, '0001' as [SortOrder]

/*

select * from SystemLanguage
select a.*, c.* from Language a inner join LanguageSystemLanguage b on a.Id = b.LanguageId inner join SystemLanguage c on b.SystemLanguageId = c.Id
where a.EnglishName like 'n%'
order by a.Id
*/


) a 

insert into [LanguageNuanceASR]
(InputLanguageId,InputLanguageCode,OutputSystemLanguageId,OutputLanguageCode, SortOrder)
select a.*
from @TblCode a left join  [LanguageNuanceASR] z on a.InputLanguageId = z.InputLanguageId and a.[InputLanguageCode] = z.[InputLanguageCode]
where z.Id is null

update a
set a.OutputSystemLanguageId = b.OutputSystemLanguageId, a.OutputLanguageCode = b.OutputLanguageCode, a.SortOrder = b.SortOrder
from [LanguageNuanceASR] a inner join  @TblCode b on a.InputLanguageId = b.InputLanguageId and a.[InputLanguageCode] = b.[InputLanguageCode]


delete LanguageNuanceASR where Id in (select a.Id from [LanguageNuanceASR] a left join @TblCode z on a.InputLanguageId = z.InputLanguageId and a.[InputLanguageCode] = z.[InputLanguageCode] where z.InputLanguageId is null)

select * from LanguageNuanceASR


------------------------------------- End ------------------------------------- 
