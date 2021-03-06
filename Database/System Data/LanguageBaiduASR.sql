--select * from LanguageBaiduASR
--select * from Language
--select * from SystemLanguage
--select * from Language where Id in (7, 8, 13)

declare @TblCode as Table
(
	[InputLanguageId] [int] NULL,						-- Language displayed to the user
	[InputLanguageCode] [nvarchar](8) NULL,
	[OutputSystemLanguageId] [int] NULL,
	[OutputLanguageCode] [nvarchar](8) NULL
)	



------------------------------------- Begin ------------------------------------- 
--delete [LanguageBaiduASR]

delete @TblCode

insert into @TblCode	
(InputLanguageId,InputLanguageCode,OutputSystemLanguageId,OutputLanguageCode)
select a.*
from (
	-- 7	Chinese Cantonese
	select 7 as InputLanguageId,'ct' as InputLanguageCode, 2 as OutputSystemLanguageId, NULL as OutputLanguageCode
		
	UNION

	-- 8	Chinese Mandarin
	select 8 as InputLanguageId,'zh' as InputLanguageCode, 2 as OutputSystemLanguageId, NULL as OutputLanguageCode

	UNION
	
	-- 13	English
	select 13 as InputLanguageId,'en' as LanguageCode, 1 as OutputSystemLanguageId, NULL as OutputLanguageCode



) a 

insert into [LanguageBaiduASR]
(InputLanguageId,InputLanguageCode,OutputSystemLanguageId,OutputLanguageCode)
select a.*
from @TblCode a left join  [LanguageBaiduASR] z on a.InputLanguageId = z.InputLanguageId and a.OutputSystemLanguageId = z.OutputSystemLanguageId
where z.Id is null

update a
set a.InputLanguageCode = b.InputLanguageCode, a.OutputLanguageCode = b.OutputLanguageCode
from [LanguageBaiduASR] a inner join  @TblCode b on a.InputLanguageId = b.InputLanguageId and a.OutputSystemLanguageId = b.OutputSystemLanguageId


delete LanguageBaiduASR where Id in (select a.Id from [LanguageBaiduASR] a left join @TblCode z on a.InputLanguageId = z.InputLanguageId and a.OutputSystemLanguageId = z.OutputSystemLanguageId where z.InputLanguageId is null)

select * from LanguageBaiduASR


------------------------------------- End ------------------------------------- 
