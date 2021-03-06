--select * from LanguageMachine
--select * from Language
--select * from Language where Id in (7, 8, 13)

declare @TblCode as Table
(
	[InputLanguageId] [int] NOT NULL,
	[OutputLanguageId] [int] NOT NULL,

	[ASRProvider1] [nvarchar](16) NULL,		-- Baidu, Google, Nuance, Microsoft
	[ASRProvider2] [nvarchar](16) NULL,		-- Baidu, Google, Nuance, Microsoft
	[TranslateProvider1] [nvarchar](16) NULL,		-- Baidu, Google, Microsoft
	[TranslateProvider2] [nvarchar](16) NULL,		-- Baidu, Google, Microsoft
	[TTSProvider1] [nvarchar](16) NULL,		-- Baidu, Google, Microsoft
	[TTSProvider2] [nvarchar](16) NULL,		-- Baidu, Google, Microsoft
	[ImageProvider1] [nvarchar](16) NULL,		-- cloudsight, ?
	[ImageProvider2] [nvarchar](16) NULL
)	

 

------------------------------------- Begin ------------------------------------- 
--delete [LanguageMachine]	--

delete @TblCode

insert into @TblCode	
(InputLanguageId,OutputLanguageId,ASRProvider1,ASRProvider2,TranslateProvider1,TranslateProvider2,TTSProvider1,TTSProvider2,ImageProvider1,ImageProvider2)
select a.InputLanguageId, a.OutputLanguageId, 
	case when BaiduASR > 0 then 'Baidu' else case when NuanceASR > 0 then 'Nuance' else NULL end end as ASRProvider1, NULL as ASRProvider2,
	case when GoogleTranslate > 0 then 'Google' else NULL end as TranslateProvider1, NULL as TranslateProvider2, 
	case when MicrosoftTTS > 0 then 'Microsoft' else NULL end as TTSProvider1, NULL as TTSProvider2,
	case when AbbyyIR > 0 then 'Abbyy' else case when CloudSightIR > 0 then 'CloudSight' else NULL end end as ImageProvider1, 
	case when AbbyyIR > 0 then case when CloudSightIR > 0 then 'CloudSight' else NULL end 
		else NULL
		end as ImageProvider2
from (
select b.LanguageId as InputLanguageId, c.LanguageId as OutputLanguageId,
	sum(case when z.Id is null then 0 else 1 end) as BaiduASR,
	sum(case when z1.Id is null then 0 else 1 end) as NuanceASR,
	1 as GoogleTranslate,
	sum(case when y.Id is null then 0 else 1 end) as MicrosoftTTS,
	sum(case when x.Id is null then 0 else 1 end) as CloudSightIR,
	sum(case when w.Id is null then 0 else 1 end) as AbbyyIR
from LanguageGoogleTranslate a 
	inner join LanguageSystemLanguage b on a.InputSystemLanguageId = b.SystemLanguageId 
	inner join LanguageSystemLanguage c on a.OutputSystemLanguageId = c.SystemLanguageId
	left join LanguageBaiduASR z on z.InputLanguageId = b.LanguageId and z.OutputSystemLanguageId = a.InputSystemLanguageId
	left join LanguageNuanceASR z1 on z1.InputLanguageId = b.LanguageId and z1.OutputSystemLanguageId = a.InputSystemLanguageId
	left join LanguageMicrosoftTTS y on a.OutputSystemLanguageId = y.SystemLanguageId and c.LanguageId = y.LanguageId
	left join LanguageCloudSightIR x on x.InputLanguageId = b.LanguageId and x.OutputSystemLanguageId = a.InputSystemLanguageId
	left join LanguageAbbyyIR w on w.InputLanguageId = b.LanguageId and w.OutputSystemLanguageId = a.InputSystemLanguageId
group by b.LanguageId, c.LanguageId

UNION

select a.LanguageId as InputLanguageId, b.LanguageId  as OutputLanguageId,
	sum(case when z.Id is null then 0 else 1 end) as BaiduASR,
	sum(case when z1.Id is null then 0 else 1 end) as NuanceASR,
	0 as GoogleTranslate,
	sum(case when y.Id is null then 0 else 1 end) as MicrosoftTTS,
	sum(case when x.Id is null then 0 else 1 end) as CloudSightIR,
	sum(case when w.Id is null then 0 else 1 end) as AbbyyIR
from (
	select a.* 
	from LanguageSystemLanguage a 
		inner join (
			select SystemLanguageId
			from LanguageSystemLanguage 
			group by SystemLanguageId
			having count(1) > 1
		) b on a.SystemLanguageId = b.SystemLanguageId
) a inner join (
	select a.* 
	from LanguageSystemLanguage a 
		inner join (
			select SystemLanguageId
			from LanguageSystemLanguage 
			group by SystemLanguageId
			having count(1) > 1
		) b on a.SystemLanguageId = b.SystemLanguageId
) b on a.Id <> b.Id
	left join LanguageBaiduASR z on z.InputLanguageId = a.LanguageId and z.OutputSystemLanguageId = a.SystemLanguageId
	left join LanguageNuanceASR z1 on z1.InputLanguageId = b.LanguageId and z1.OutputSystemLanguageId = a.SystemLanguageId
	left join LanguageMicrosoftTTS y on a.SystemLanguageId = y.SystemLanguageId and b.LanguageId = y.LanguageId
	left join LanguageCloudSightIR x on x.InputLanguageId = b.LanguageId and x.OutputSystemLanguageId = a.SystemLanguageId
	left join LanguageAbbyyIR w on w.InputLanguageId = b.LanguageId and w.OutputSystemLanguageId = a.SystemLanguageId
group by a.LanguageId, b.LanguageId
) a 
order by a.InputLanguageId, a.OutputLanguageId

insert into [LanguageMachine]
(InputLanguageId,OutputLanguageId,ASRProvider1,ASRProvider2,TranslateProvider1,TranslateProvider2,TTSProvider1,TTSProvider2,ImageProvider1,ImageProvider2)
select a.*
from @TblCode a left join  [LanguageMachine] z on a.InputLanguageId = z.InputLanguageId and a.OutputLanguageId = z.OutputLanguageId
where z.Id is null

update a
set a.ASRProvider1 = b.ASRProvider1, a.ASRProvider2 = b.ASRProvider2, a.TranslateProvider1 = b.TranslateProvider1, a.TranslateProvider2 = b.TranslateProvider2,
	a.TTSProvider1 = b.TTSProvider1, a.TTSProvider2 = b.TTSProvider2, a.ImageProvider1 = b.ImageProvider1, a.ImageProvider2 = b.ImageProvider2
from [LanguageMachine] a inner join  @TblCode b on a.InputLanguageId = b.InputLanguageId and a.OutputLanguageId = b.OutputLanguageId


delete LanguageMachine where Id in (select Id from LanguageMachine a left join @TblCode z on a.InputLanguageId = z.InputLanguageId and a.OutputLanguageId = z.OutputLanguageId where z.InputLanguageId is null)

select * from LanguageMachine


------------------------------------- End ------------------------------------- 
