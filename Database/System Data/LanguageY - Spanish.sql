--select * from [Language]
--select * from [LanguageY]
--select * from SystemLanguage


declare @SystemLanguageId int
select @SystemLanguageId = Id
--select *
from SystemLanguage where LanguageCode = N'es'


declare @TblY as Table
(
	[LanguageId] [int] NOT NULL,
	[SystemLanguageId] [int] NOT NULL,
	[Name] [nvarchar](256) NOT NULL
)

delete @TblY

insert into @TblY
(LanguageId, SystemLanguageId, [Name])
select a.LanguageId, @SystemLanguageId, a.[Name]
from (
	select a.*
	from (
	select a.Id as LanguageId,
		case when [EnglishName] = 'English' then N'Inglés'
		when [EnglishName] = 'Chinese' then N'Chino ( Mandarín)'
		when [EnglishName] = 'Chinese Mandarin' then N'Chino ( Mandarín)'
		when [EnglishName] = 'Chinese Cantonese' then N'Chino ( Cantonés)'
		when [EnglishName] = 'Spanish' then N'Español'
		when [EnglishName] = 'French' then N'Francés'
		when [EnglishName] = 'German' then N'Alemán'
		when [EnglishName] = 'Portuguese' then N'Portugués'
		when [EnglishName] = 'Italian' then N'Lengua italiana'
		when [EnglishName] = 'Russian' then N'Ruso'
		when [EnglishName] = 'Japanese' then N'Japonés'
		when [EnglishName] = 'Korean' then N'Coreano'
		when [EnglishName] = 'Vietnamese' then N'Idioma vietnamita'
		when [EnglishName] = 'Hindi' then N'Hindi'
		when [EnglishName] = 'Polish' then N'polaco'
		when [EnglishName] = 'Arabic' then N'árabe'
		when [EnglishName] = 'Bulgarian' then N'búlgaro'
		when [EnglishName] = 'Danish' then N'danés'
		when [EnglishName] = 'Finnish' then N'finlandés'
		when [EnglishName] = 'Dutch' then N'holandés'
		when [EnglishName] = 'Hebrew' then N'hebreo'
		when [EnglishName] = 'Turkish' then N'turco'
		when [EnglishName] = 'Indonesian' then N'indonesio'
		when [EnglishName] = 'Indonesian Javanese' then N'Javanesa Indonesia'
		when [EnglishName] = 'Ukrainian' then N'ucranio'
		when [EnglishName] = 'South Africa Zulu' then N'Sudáfrica Zulu'
		when [EnglishName] = 'Thai' then N'tailandés'
		when [EnglishName] = 'Czech' then N'checo'
		when [EnglishName] = 'Malay' then N'malayo'
		when [EnglishName] = 'Romanian' then N'rumano'
		when [EnglishName] = 'Icelandic' then N'islandés'
		when [EnglishName] = 'Bosnian' then N'bosnio'
		when [EnglishName] = 'Filipino' then N'Filipino'
		when [EnglishName] = 'Norwegian' then N'lengua noruega'
		when [EnglishName] = 'Latin' then N'latín'
		when [EnglishName] = 'Slovak' then N'eslovaco'
		when [EnglishName] = 'Serbian' then N'idioma serbio'
		when [EnglishName] = 'Croatian' then N'croata'
		when [EnglishName] = 'Crotian' then N'Crotian'
		when [EnglishName] = 'Latvian' then N'letón'
		when [EnglishName] = 'Lithuanian' then N'lituano'
		when [EnglishName] = 'Maltese' then N'maltés'
		when [EnglishName] = 'Macedonian' then N'macedonio'
		when [EnglishName] = 'Mongolian' then N'mongol'
		when [EnglishName] = 'Uzbek' then N'uzbeco'
		when [EnglishName] = 'Armenian' then N'armenio'
		when [EnglishName] = 'Slovenian' then N'esloveno'
		when [EnglishName] = 'Slovenia' then N'Eslovenia'
		when [EnglishName] = 'Swedish' then N'sueco'
		when [EnglishName] = 'Burmese' then N'birmano'
		when [EnglishName] = 'Bengali' then N'lengua bengalí'
		when [EnglishName] = 'Lao' then N'idioma laosiano'
		when [EnglishName] = 'Persian' then N'persa'
		else N''
		end as [Name]
	from [Language] a
	) a where a.[Name] <> ''

	
) a 


insert into [LanguageY]
(LanguageId, SystemLanguageId, [Name], CreateDate)
select a.*, GETUTCDATE()
from @TblY a left join [LanguageY] z on a.LanguageId = z.LanguageId and z.SystemLanguageId = @SystemLanguageId 
where z.Id is null

update a
set a.[Name] = b.[Name]
from [LanguageY] a inner join @TblY b on a.LanguageId = b.LanguageId and a.SystemLanguageId = b.SystemLanguageId
where a.SystemLanguageId = @SystemLanguageId 

--select * from @TblY
--select * from LanguageY where SystemLanguageId = @SystemLanguageId 


delete [LanguageY] 
where (SystemLanguageId = @SystemLanguageId and LanguageId not in (select LanguageId from @TblY))
  or ( LanguageId in (select LanguageId from @TblY) and SystemLanguageId = 1)


select * 
from [Language] a left join [LanguageY] z on a.Id = z.LanguageId and z.SystemLanguageId = @SystemLanguageId
where z.Id is null
order by SortCode, [Name]



Go

