--select * from LanguageCloudSightIR
--select * from Language
--select * from SystemLanguage
--select * from Language where Id in (7, 8, 13)

declare @TblCode as Table
(
	[InputLanguageId] [int] NULL,						-- Language displayed to the user
	[Locale] [nvarchar](8) NULL,
	[OutputSystemLanguageId] [int] NULL,
	[OutputLanguageCode] [nvarchar](8) NULL,
	[SortOrder] [varchar](8) NULL
)	



------------------------------------- Begin ------------------------------------- 
--delete [LanguageCloudSightIR]

delete @TblCode

insert into @TblCode	
(InputLanguageId,Locale,OutputSystemLanguageId,OutputLanguageCode, [SortOrder])
select a.*
from (
	-- 13	English, 1	English	en
	select 13 as InputLanguageId,'en-US' as LanguageCode, 1 as OutputSystemLanguageId, 'en' as OutputLanguageCode
		, '0001' as [SortOrder]

	UNION

	-- 7	Chinese Cantonese, 2	简体中文	zh-CN
	select 7 as InputLanguageId,'zh-CN' as Locale, 2 as OutputSystemLanguageId, 'zh' as OutputLanguageCode
		, '0001' as [SortOrder]

	UNION

	-- 7	Chinese Cantonese, 2	简体中文	zh-CN
	select 7 as InputLanguageId,'zh-TW' as Locale, 2 as OutputSystemLanguageId, 'zh' as OutputLanguageCode
		, '0002' as [SortOrder]

	UNION

	-- 8	Chinese Mandarin, 2	简体中文	zh-CN
	select 8 as InputLanguageId,'zh-CN' as Locale, 2 as OutputSystemLanguageId, 'zh' as OutputLanguageCode
		, '0001' as [SortOrder]

	UNION

	-- 8	Chinese Mandarin, 2	简体中文	zh-CN
	select 8 as InputLanguageId,'zh-TW' as Locale, 2 as OutputSystemLanguageId, 'zh' as OutputLanguageCode
		, '0002' as [SortOrder]
		
	UNION

	-- 44	Spanish, 4	Español	es
	select 44 as InputLanguageId,'es-ES' as Locale, 4 as OutputSystemLanguageId, 'es' as OutputLanguageCode
		, '0001' as [SortOrder]

	UNION

	-- 16	French, 5	Français	fr
	select 16 as InputLanguageId,'fr-FR' as Locale, 5 as OutputSystemLanguageId, 'fr' as OutputLanguageCode
		, '0001' as [SortOrder]
	
--select * from SystemLanguage
--select * from Language where EnglishName like 'fr%'

) a 

insert into [LanguageCloudSightIR]
(InputLanguageId,Locale,OutputSystemLanguageId,OutputLanguageCode, [SortOrder])
select a.*
from @TblCode a left join  [LanguageCloudSightIR] z on a.InputLanguageId = z.InputLanguageId and a.Locale = z.Locale
where z.Id is null

update a
set a.Locale = b.Locale, a.OutputLanguageCode = b.OutputLanguageCode, a.[SortOrder] = b.[SortOrder]
from [LanguageCloudSightIR] a inner join  @TblCode b on a.InputLanguageId = b.InputLanguageId and a.Locale = b.Locale


delete LanguageCloudSightIR where Id in (select a.Id from [LanguageCloudSightIR] a left join @TblCode z on a.InputLanguageId = z.InputLanguageId and a.Locale = z.Locale where z.InputLanguageId is null)

select * from LanguageCloudSightIR order by InputLanguageId, SortOrder


------------------------------------- End ------------------------------------- 
