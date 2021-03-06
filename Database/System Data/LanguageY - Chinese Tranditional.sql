--select * from [Language]
--select * from [LanguageY]
--select * from SystemLanguage


declare @SystemLanguageId int
select @SystemLanguageId = Id
--select *
from SystemLanguage where [Name] = N'繁體中文'


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
		case when [EnglishName] = 'English' then N'英語'
		when [EnglishName] = 'Chinese' then N'中文 (普通話)'
		when [EnglishName] = 'Chinese Mandarin' then N'中文 (普通話)'
		when [EnglishName] = 'Chinese Cantonese' then N'中文 (粵語)'
		when [EnglishName] = 'Spanish' then N'西班牙语'
		when [EnglishName] = 'French' then N'西班牙文'
		when [EnglishName] = 'German' then N'德語'
		when [EnglishName] = 'Portuguese' then N'葡萄牙文'
		when [EnglishName] = 'Italian' then N'義大利文'
		when [EnglishName] = 'Russian' then N'俄語'
		when [EnglishName] = 'Japanese' then N'日語'
		when [EnglishName] = 'Korean' then N'韓語'
		when [EnglishName] = 'Vietnamese' then N'越南文'
		when [EnglishName] = 'Hindi' then N'印度文'
		when [EnglishName] = 'Polish' then N'波蘭文'
		when [EnglishName] = 'Arabic' then N'阿拉伯文'
		when [EnglishName] = 'Bulgarian' then N'保加利亞文'
		when [EnglishName] = 'Danish' then N'丹麥文'
		when [EnglishName] = 'Finnish' then N'芬蘭文'
		when [EnglishName] = 'Dutch' then N'荷蘭文'
		when [EnglishName] = 'Hebrew' then N'希伯來文'
		when [EnglishName] = 'Turkish' then N'土耳其文'
		when [EnglishName] = 'Indonesian' then N'印尼語'
		when [EnglishName] = 'Indonesian Javanese' then N'印尼爪哇語'
		when [EnglishName] = 'Ukrainian' then N'烏克蘭文'
		when [EnglishName] = 'South Africa Zulu' then N'南非祖魯語'
		when [EnglishName] = 'Thai' then N'泰語'
		when [EnglishName] = 'Czech' then N'捷克文'
		when [EnglishName] = 'Malay' then N'馬來文'
		when [EnglishName] = 'Romanian' then N'羅馬尼亞語'
		when [EnglishName] = 'Icelandic' then N'冰島文'
		when [EnglishName] = 'Bosnian' then N'波士尼亞文'
		when [EnglishName] = 'Filipino' then N'菲律賓文'
		when [EnglishName] = 'Norwegian' then N'挪威語'
		when [EnglishName] = 'Latin' then N'拉丁語'
		when [EnglishName] = 'Slovak' then N'斯洛伐克文'
		when [EnglishName] = 'Serbian' then N'塞爾維亞文'
		when [EnglishName] = 'Croatian' then N'克羅地亞語'
		when [EnglishName] = 'Crotian' then N'克羅地亞語'
		when [EnglishName] = 'Latvian' then N'拉脫維亞文'
		when [EnglishName] = 'Lithuanian' then N'立陶宛文'
		when [EnglishName] = 'Maltese' then N'馬爾他文'
		when [EnglishName] = 'Macedonian' then N'馬其頓語'
		when [EnglishName] = 'Mongolian' then N'蒙古文'
		when [EnglishName] = 'Uzbek' then N'烏玆別克文'
		when [EnglishName] = 'Armenian' then N'亞美尼亞文'
		when [EnglishName] = 'Slovenian' then N'斯洛維尼亞文'
		when [EnglishName] = 'Slovenia' then N'斯洛維尼亞文'
		when [EnglishName] = 'Swedish' then N'瑞典文'
		when [EnglishName] = 'Burmese' then N'緬甸文'
		when [EnglishName] = 'Bengali' then N'孟加拉文'
		when [EnglishName] = 'Lao' then N'老撾語'
		when [EnglishName] = 'Persian' then N'波斯文'
		when [EnglishName] = 'Greek' then N'希臘語'
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

