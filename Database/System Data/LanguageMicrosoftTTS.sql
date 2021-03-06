--select * from LanguageMicrosoftTTS
--select * from SystemLanguage
--select * from Language where Id in (7, 8, 13)

declare @TblCode as Table
(
	[SystemLanguageId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,

	[LanguageCode] [nvarchar](8) NULL,
	[TTSName] [nvarchar](128) NULL,
	[CultureCode] [nvarchar](8) NULL,
	[ISO639x] [nvarchar](8) NULL,

	[SortOrder] [varchar](8) NULL
)	



------------------------------------- Begin ------------------------------------- 
--delete [LanguageMicrosoftTTS]

delete @TblCode

insert into @TblCode	
(SystemLanguageId,LanguageId,LanguageCode,TTSName,CultureCode,ISO639x, [SortOrder])
select a.*
from (
	-- 7	Chinese Cantonese
	select 2 as SystemLanguageId,7 as LanguageId,'zh-HK' as LanguageCode,'Microsoft Server Speech Text to Speech Voice (zh-HK, HunYee)' as TTSName,'0x0C04' as CultureCode,'ZHH' as ISO639x
		, '0001' as [SortOrder]

	UNION

	-- 8	Chinese Mandarin
	select 2 as SystemLanguageId,8 as LanguageId,'zh-CN' as LanguageCode,'Microsoft Server Speech Text to Speech Voice (zh-CN, HuiHui)' as TTSName,'0x0804' as CultureCode,'CHS' as ISO639x
		, '0001' as [SortOrder]

	UNION

	-- 8	Chinese Mandarin
	select 2 as SystemLanguageId,8 as LanguageId,'zh-TW' as LanguageCode,'Microsoft Server Speech Text to Speech Voice (zh-TW, HanHan)' as TTSName,'0x0404' as CultureCode,'CHT' as ISO639x
		, '0002' as [SortOrder]

	UNION
	
	-- 13	English
	select 1 as SystemLanguageId,13 as LanguageId,'en-US' as LanguageCode,'Microsoft Server Speech Text to Speech Voice (en-US, ZiraPro)' as TTSName,'0x0409' as CultureCode,'ENU' as ISO639x
		, '0001' as [SortOrder]

	UNION
	
	-- 13	English
	select 1 as SystemLanguageId,13 as LanguageId,'en-GB' as LanguageCode,'Microsoft Server Speech Text to Speech Voice (en-GB, Hazel)' as TTSName,'0x0809' as CultureCode,'ENG' as ISO639x
		, '0002' as [SortOrder]

	UNION

	-- 44	Spanish
	select 4 as SystemLanguageId,44 as LanguageId,'es-ES' as LanguageCode,'Microsoft Server Speech Text to Speech Voice (es-ES, Helena)' as TTSName,'0x0C0A' as CultureCode,'' as ISO639x
		, '0001' as [SortOrder]	

	UNION

	-- 16	French
	select 5 as SystemLanguageId,16 as LanguageId,'fr-FR' as LanguageCode,'Microsoft Server Speech Text to Speech Voice (fr-FR, Hortense)' as TTSName,'' as CultureCode,'' as ISO639x
		, '0001' as [SortOrder]	

	UNION

	-- 12	Duch
	select 6 as SystemLanguageId,12 as LanguageId,'nl-NL' as LanguageCode,'Microsoft Server Speech Text to Speech Voice (nl-NL, Hanna)' as TTSName,'' as CultureCode,'' as ISO639x
		, '0001' as [SortOrder]	

	UNION

	-- 37	Portuguese		Português
	select 7 as SystemLanguageId,37 as LanguageId,'pt-PT' as LanguageCode,'Microsoft Server Speech Text to Speech Voice (pt-PT, Helia)' as TTSName,'' as CultureCode,'' as ISO639x
		, '0001' as [SortOrder]	

	UNION

	-- 23	Italian		8	Italiano
	select 8 as SystemLanguageId,23 as LanguageId,'it-IT' as LanguageCode,'Microsoft Server Speech Text to Speech Voice (it-IT, Lucia)' as TTSName,'' as CultureCode,'' as ISO639x
		, '0001' as [SortOrder]	

	UNION

	-- 39	Russian		9	Pусский
	select 9 as SystemLanguageId,39 as LanguageId,'ru-RU' as LanguageCode,'Microsoft Server Speech Text to Speech Voice (ru-RU, Elena)' as TTSName,'' as CultureCode,'' as ISO639x
		, '0001' as [SortOrder]	

	UNION

	-- 25	Korean		10	한국의
	select 10 as SystemLanguageId,25 as LanguageId,'ko-KR' as LanguageCode,'Microsoft Server Speech Text to Speech Voice (ko-KR, Heami)' as TTSName,'' as CultureCode,'' as ISO639x
		, '0001' as [SortOrder]	

	UNION

	-- 24	Japanese		12	日本語
	select 12 as SystemLanguageId,24 as LanguageId,'ja-JP' as LanguageCode,'Microsoft Server Speech Text to Speech Voice (ja-JP, Haruka)' as TTSName,'' as CultureCode,'' as ISO639x
		, '0001' as [SortOrder]	

	UNION

	-- 17	German		14	Deutsch
	select 14 as SystemLanguageId,17 as LanguageId,'de-DE' as LanguageCode,'Microsoft Server Speech Text to Speech Voice (de-DE, Hedda)' as TTSName,'' as CultureCode,'' as ISO639x
		, '0001' as [SortOrder]	

	UNION

	-- 11	Danish		19	Danske	da
	select 19 as SystemLanguageId,11 as LanguageId,'da-DK' as LanguageCode,'Microsoft Server Speech Text to Speech Voice (da-DK, Helle)' as TTSName,'' as CultureCode,'' as ISO639x
		, '0001' as [SortOrder]	

	UNION

	-- 34	Norwegian		21	Norsk Språk	nb
	select 21 as SystemLanguageId,34 as LanguageId,'nb-NO' as LanguageCode,'Microsoft Server Speech Text to Speech Voice (nb-NO, Hulda)' as TTSName,'' as CultureCode,'' as ISO639x
		, '0001' as [SortOrder]	

	UNION

	-- 45	Swedish		22	Svenska	sv
	select 22 as SystemLanguageId,45 as LanguageId,'sv-SE' as LanguageCode,'Microsoft Server Speech Text to Speech Voice (sv-SE, Hedvig)' as TTSName,'' as CultureCode,'' as ISO639x
		, '0001' as [SortOrder]	

--select * from SystemLanguage
--select * from Language where EnglishName like 's%'

) a 

insert into [LanguageMicrosoftTTS]
(SystemLanguageId,LanguageId,LanguageCode,TTSName,CultureCode,ISO639x, [SortOrder])
select a.*
from @TblCode a left join  [LanguageMicrosoftTTS] z on a.SystemLanguageId = z.SystemLanguageId and a.LanguageId = z.LanguageId and a.LanguageCode = z.LanguageCode
where z.Id is null

update a
set a.TTSName = b.TTSName,a.CultureCode = b.CultureCode, a.ISO639x = b.ISO639x, a.[SortOrder] = b.[SortOrder]
from [LanguageMicrosoftTTS] a inner join  @TblCode b on a.LanguageId = b.SystemLanguageId and a.LanguageId = b.LanguageId and a.LanguageCode = b.LanguageCode


delete LanguageMicrosoftTTS where Id in (select a.Id from LanguageMicrosoftTTS a left join @TblCode z on a.SystemLanguageId = z.SystemLanguageId and a.LanguageId = z.LanguageId and a.LanguageCode = z.LanguageCode where z.LanguageId is null)

select * from LanguageMicrosoftTTS


------------------------------------- End ------------------------------------- 
