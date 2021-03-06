--select * from LanguageGoogleTranslate
--select * from SystemLanguage


declare @TblCode as Table
(
	[InputSystemLanguageId] [int] NOT NULL,
	[InputLanguageCode] [nvarchar](8) NOT NULL,

	[OutputSystemLanguageId] [int] NOT NULL,
	[OutputLanguageCode] [nvarchar](8) NOT NULL
)	


 
------------------------------------- Begin ------------------------------------- 
--delete [LanguageGoogleTranslate]	--

delete @TblCode

insert into @TblCode	
(InputSystemLanguageId,InputLanguageCode,OutputSystemLanguageId,OutputLanguageCode)
select a.Id as InputSystemLanguageId, a.LanguageCode as InputLanguageCode, b.Id as OutputSystemLanguageId,b.LanguageCode as OutputLanguageCode
from SystemLanguage a inner join SystemLanguage b on a.Id <> b.Id
order by a.Id, b.Id

insert into [LanguageGoogleTranslate]
(InputSystemLanguageId,InputLanguageCode,OutputSystemLanguageId,OutputLanguageCode)
select a.*
from @TblCode a left join [LanguageGoogleTranslate] z on a.InputSystemLanguageId = z.InputSystemLanguageId and a.OutputSystemLanguageId = z.OutputSystemLanguageId
where z.Id is null

update a
set a.InputLanguageCode = b.InputLanguageCode, a.OutputLanguageCode = b.OutputLanguageCode
from [LanguageGoogleTranslate] a inner join  @TblCode b on a.InputSystemLanguageId = b.InputSystemLanguageId and a.OutputSystemLanguageId = b.OutputSystemLanguageId


delete LanguageGoogleTranslate where Id in (select a.Id from LanguageGoogleTranslate a left join @TblCode z on a.InputSystemLanguageId = z.InputSystemLanguageId and a.OutputSystemLanguageId = z.OutputSystemLanguageId where z.InputLanguageCode is null)

select * from LanguageGoogleTranslate


------------------------------------- End ------------------------------------- 
