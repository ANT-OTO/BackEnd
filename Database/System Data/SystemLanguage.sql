
declare @Tbl_SystemLanguage as Table
(
	[Id] int NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[LanguageCode] nvarchar(16) NOT NULL,
	[Available] bit NOT NULL
)

insert into @Tbl_SystemLanguage
([Id], [Name], [LanguageCode], Available)
select a.*
from (
	select 1 as Id, N'English' as [Name], 'en' as [LanguageCode], 1 as Available
	
	UNION
	
	select 2 as Id, N'简体中文' as [Name], 'zh-CN' as [LanguageCode], 1 as Available		-- Chinese
	
	UNION
	
	select 3 as Id,  N'繁體中文' as [Name], 'zh-TW' as [LanguageCode], 0 as Available		-- Traditional Chinese
	
	UNION
	
	select 4 as Id,  N'Español' as [Name], 'es' as [LanguageCode], 0 as Available		-- Spanish
	
	UNION
	
	select 5 as Id,  N'Français' as [Name], 'fr' as [LanguageCode], 0 as Available		-- French
	
	UNION
	
	select 6 as Id,  N'Nederlandse' as [Name], 'nl' as [LanguageCode], 0 as Available		-- Dutch
	
	UNION
	
	select 7 as Id,  N'Português' as [Name], 'pt' as [LanguageCode], 0 as Available		-- Portuguess
	
	UNION
	
	select 8 as Id, N'Italiano' as [Name], 'it' as [LanguageCode], 0 as Available		-- Italian

	UNION
	
	select 9 as Id,  N'Pусский' as [Name], 'ru' as [LanguageCode], 0 as Available		-- Russian
	
	UNION
	
	select 10 as Id,  N'한국의' as [Name], 'ko' as [LanguageCode], 0 as Available		-- Korean
		
	UNION
	
	select 11 as Id, N'Tiếng Việt' as [Name], 'vi' as [LanguageCode], 0 as Available		-- Vietnam
	
	UNION
	
	select 12 as Id, N'日本語' as [Name], 'ja' as [LanguageCode], 0 as Available		-- Janpanese
	
	UNION
	
	select 13 as Id, N'български език' as [Name], 'bg' as [LanguageCode], 0 as Available		-- Bulgarian

	UNION

	select 14 as Id, N'Deutsch' as [Name], 'de' as [LanguageCode], 1 as Available		-- German

	UNION

	select 15 as Id, N'العربية' as [Name], 'ar' as [LanguageCode], 0 as Available		-- Arabic
	
	UNION

	select 16 as Id, N'ไทย' as [Name], 'th' as [LanguageCode], 0 as Available			-- Thai

	UNION

	select 17 as Id, N'Melayu' as [Name], 'ms' as [LanguageCode], 0 as Available		-- Malay
	
	UNION

	select 18 as Id, N'Türk' as [Name], 'tr' as [LanguageCode], 0 as Available			-- Turkish
	
	UNION

	select 19 as Id, N'Danske' as [Name], 'da' as [LanguageCode], 0 as Available		-- Danish
	
	UNION

	select 20 as Id, N'Ελληνική' as [Name], 'el' as [LanguageCode], 0 as Available		-- Greek

	UNION

	select 21 as Id, N'Norsk Språk' as [Name], 'nb' as [LanguageCode], 0 as Available		-- Norwegian - Norway

	UNION

	select 22 as Id, N'Svenska' as [Name], 'sv' as [LanguageCode], 0 as Available		-- Swedish - Sweden
	
) a 


insert into SystemLanguage
([Id], [Name], [LanguageCode], Available)
select a.[Id], a.[Name], a.[LanguageCode], a.Available
from @Tbl_SystemLanguage a 
	left join  SystemLanguage z on a.Id = z.Id
where z.Id is null


delete
--select * from
SystemLanguage where Id not in (
	select a.Id
	from @Tbl_SystemLanguage a
)

update a
set a.[Name] = b.[Name], a.[LanguageCode] = b.[LanguageCode], a.Available = b.Available
from SystemLanguage a inner join @Tbl_SystemLanguage b on a.Id = b.Id


select * from SystemLanguage


/*

Afrikaans	af
Albanian	sq
Arabic	ar
Azerbaijani	az
Basque	eu
Bengali	bn
Belarusian	be
Bulgarian	bg
Catalan	ca
Chinese Simplified	zh-CN
Chinese Traditional	zh-TW
Croatian	hr
Czech	cs
Danish	da
Dutch	nl
English	en
Esperanto	eo
Estonian	et
Filipino	tl
Finnish	fi
French	fr
Galician	gl
Georgian	ka
German	de
Greek	el
Gujarati	gu
Haitian Creole	ht
Hebrew	iw
Hindi	hi
Hungarian	hu
Icelandic	is
Indonesian	id
Irish	ga
Italian	it
Japanese	ja
Kannada	kn
Korean	ko
Latin	la
Latvian	lv
Lithuanian	lt
Macedonian	mk
Malay	ms
Maltese	mt
Norwegian	no
Persian	fa
Polish	pl
Portuguese	pt
Romanian	ro
Russian	ru
Serbian	sr
Slovak	sk
Slovenian	sl
Spanish	es
Swahili	sw
Swedish	sv
Tamil	ta
Telugu	te
Thai	th
Turkish	tr
Ukrainian	uk
Urdu	ur
Vietnamese	vi
Welsh	cy
Yiddish	yi

*/