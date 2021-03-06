--select * from [Region]
--select * from [RegionY]
--select * from Region


declare @SystemLanguageId int
select @SystemLanguageId = Id
--select *
from SystemLanguage where [Name] = N'Español'

declare @Tbl_RegionY as Table
(
	[RegionId] [int] NOT NULL,
	[SystemLanguageId] [int] NOT NULL,
	[Name] [nvarchar](256) NOT NULL
)

insert into @Tbl_RegionY
(RegionId, SystemLanguageId, [Name])
select a.RegionId, @SystemLanguageId, a.[Name]
from (
	select a.*
	from (
	select a.Id as RegionId,
		case 
		when [Name] = 'Afghanistan' then N'Afganistán'
		when [Name] = 'Albania' then N'Albania'
		when [Name] = 'Algeria' then N'Argelia'
		when [Name] = 'American Samoa' then N'Samoa Americana'
		when [Name] = 'Andorra' then N'Andorra'
		when [Name] = 'Angola' then N'Angola'
		when [Name] = 'Anguilla' then N'Anguila'
		when [Name] = 'Antarctica' then N'Antártida'
		when [Name] = 'Antigua and Barbuda' then N'Antigua y Barbuda'
		when [Name] = 'Argentina' then N'Argentina'
		when [Name] = 'Armenia' then N'Armenia'
		when [Name] = 'Aruba' then N'Aruba'
		when [Name] = 'Australia' then N'Australia'
		when [Name] = 'Austria' then N'Austria'
		when [Name] = 'Azerbaijan' then N'Azerbaiyán'
		when [Name] = 'Bahamas' then N'Bahamas'
		when [Name] = 'Bahrain' then N'Bahrein'
		when [Name] = 'Bangladesh' then N'Bangladesh'
		when [Name] = 'Barbados' then N'Barbados'
		when [Name] = 'Belarus' then N'Bielorrusia'
		when [Name] = 'Belgium' then N'Bélgica'
		when [Name] = 'Belize' then N'Belice'
		when [Name] = 'Benin' then N'Benin'
		when [Name] = 'Bermuda' then N'Bermuda'
		when [Name] = 'Bhutan' then N'Bután'
		when [Name] = 'Bolivia' then N'Bolivia'
		when [Name] = 'Bosnia and Herzegovina' then N'Bosnia y Herzegovina'
		when [Name] = 'Botswana' then N'Botswana'
		when [Name] = 'Brazil' then N'Brasil'
		when [Name] = 'British Virgin Islands' then N'Islas Vírgenes Británicas'
		when [Name] = 'Brunei' then N'Brunei'
		when [Name] = 'Bulgaria' then N'Bulgaria'
		when [Name] = 'Burkina Faso' then N'Burkina Faso'
		when [Name] = 'Burma (Myanmar)' then N'Birmania (Myanmar)'
		when [Name] = 'Burundi' then N'Burundi'
		when [Name] = 'Cambodia' then N'Camboya'
		when [Name] = 'Cameroon' then N'Camerún'
		when [Name] = 'Canada' then N'Canadá'
		when [Name] = 'Cape Verde' then N'Cabo Verde'
		when [Name] = 'Cayman Islands' then N'Islas Caimán'
		when [Name] = 'Central African Republic' then N'República Centroafricana'
		when [Name] = 'Chad' then N'Chad'
		when [Name] = 'Chile' then N'Chile'
		when [Name] = 'China' then N'China'
		when [Name] = 'Christmas Island' then N'Isla de Navidad'
		when [Name] = 'Cocos (Keeling) Islands' then N'Islas Cocos (Keeling)'
		when [Name] = 'Colombia' then N'Colombia'
		when [Name] = 'Comoros' then N'Comoras'
		when [Name] = 'Cook Islands' then N'Islas Cook'
		when [Name] = 'Costa Rica' then N'Costa Rica'
		when [Name] = 'Croatia' then N'Croacia'
		when [Name] = 'Cuba' then N'Cuba'
		when [Name] = 'Cyprus' then N'Chipre'
		when [Name] = 'Czech Republic' then N'República Checa'
		when [Name] = 'Democratic Republic of the Congo' then N'República Democrática del Congo'
		when [Name] = 'Denmark' then N'Dinamarca'
		when [Name] = 'Djibouti' then N'Djibouti'
		when [Name] = 'Dominica' then N'Dominica'
		when [Name] = 'Dominican Republic' then N'República Dominicana'
		when [Name] = 'Ecuador' then N'Ecuador'
		when [Name] = 'Egypt' then N'Egipto'
		when [Name] = 'El Salvador' then N'El Salvador'
		when [Name] = 'Equatorial Guinea' then N'Guinea Ecuatorial'
		when [Name] = 'Eritrea' then N'Eritrea'
		when [Name] = 'Estonia' then N'Estonia'
		when [Name] = 'Ethiopia' then N'Etiopía'
		when [Name] = 'Falkland Islands' then N'Islas Malvinas'
		when [Name] = 'Faroe Islands' then N'Islas Faroe'
		when [Name] = 'Fiji' then N'Fiji'
		when [Name] = 'Finland' then N'Finlandia'
		when [Name] = 'France' then N'La Francia'
		when [Name] = 'French Polynesia' then N'Polinesia francés'
		when [Name] = 'Gabon' then N'Gabón'
		when [Name] = 'Gambia' then N'Gambia'
		when [Name] = 'Gaza Strip' then N'Franja De Gaza'
		when [Name] = 'Georgia' then N'Georgia'
		when [Name] = 'Germany' then N'Alemania'
		when [Name] = 'Ghana' then N'Ghana'
		when [Name] = 'Gibraltar' then N'Gibraltar'
		when [Name] = 'Greece' then N'Grecia'
		when [Name] = 'Greenland' then N'Groenlandia'
		when [Name] = 'Grenada' then N'Granada'
		when [Name] = 'Guam' then N'Guam'
		when [Name] = 'Guatemala' then N'Guatemala'
		when [Name] = 'Guinea' then N'Guinea'
		when [Name] = 'Guinea-Bissau' then N'Guinea-Bissau'
		when [Name] = 'Guyana' then N'Guayana'
		when [Name] = 'Haiti' then N'Haití'
		when [Name] = 'Holy See (Vatican City)' then N'Santa Sede (Ciudad del Vaticano)'
		when [Name] = 'Honduras' then N'Honduras'
		when [Name] = 'Hong Kong' then N'Hong Kong'
		when [Name] = 'Hungary' then N'Hungría'
		when [Name] = 'Iceland' then N'Islandia'
		when [Name] = 'India' then N'India'
		when [Name] = 'Indonesia' then N'Indonesia'
		when [Name] = 'Iran' then N'Yo Corri'
		when [Name] = 'Iraq' then N'Irak'
		when [Name] = 'Ireland' then N'Irlanda'
		when [Name] = 'Isle of Man' then N'Isla de Man'
		when [Name] = 'Israel' then N'Israel'
		when [Name] = 'Italy' then N'Italia'
		when [Name] = 'Ivory Coast' then N'Costa De Marfil'
		when [Name] = 'Jamaica' then N'Jamaica'
		when [Name] = 'Japan' then N'Japón'
		when [Name] = 'Jordan' then N'Jordania'
		when [Name] = 'Kazakhstan' then N'Kazajstán'
		when [Name] = 'Kenya' then N'Kenia'
		when [Name] = 'Kiribati' then N'Kiribati'
		when [Name] = 'Kosovo' then N'Kosovo'
		when [Name] = 'Kuwait' then N'Kuwait'
		when [Name] = 'Kyrgyzstan' then N'Kirguistán'
		when [Name] = 'Laos' then N'Laos'
		when [Name] = 'Latvia' then N'Letonia'
		when [Name] = 'Lebanon' then N'Líbano'
		when [Name] = 'Lesotho' then N'Lesoto'
		when [Name] = 'Liberia' then N'Liberia'
		when [Name] = 'Libya' then N'Libia'
		when [Name] = 'Liechtenstein' then N'Liechtenstein'
		when [Name] = 'Lithuania' then N'Lituania'
		when [Name] = 'Luxembourg' then N'Luxemburgo'
		when [Name] = 'Macau' then N'Macau'
		when [Name] = 'Macedonia' then N'Macedonia'
		when [Name] = 'Madagascar' then N'Madagascar'
		when [Name] = 'Malawi' then N'Malawi'
		when [Name] = 'Malaysia' then N'Malasia'
		when [Name] = 'Maldives' then N'Maldivas'
		when [Name] = 'Mali' then N'Malí'
		when [Name] = 'Malta' then N'Malta'
		when [Name] = 'Marshall Islands' then N'Islas Marshall'
		when [Name] = 'Mauritania' then N'Mauritania'
		when [Name] = 'Mauritius' then N'Mauricio'
		when [Name] = 'Mayotte' then N'Mayotte'
		when [Name] = 'Mexico' then N'México'
		when [Name] = 'Micronesia' then N'Micronesia'
		when [Name] = 'Moldova' then N'Moldavia'
		when [Name] = 'Monaco' then N'Mónaco'
		when [Name] = 'Mongolia' then N'Mongolia'
		when [Name] = 'Montenegro' then N'Montenegro'
		when [Name] = 'Montserrat' then N'Montserrat'
		when [Name] = 'Morocco' then N'Marruecos'
		when [Name] = 'Mozambique' then N'Mozambique'
		when [Name] = 'Namibia' then N'Namibia'
		when [Name] = 'Nauru' then N'Nauru'
		when [Name] = 'Nepal' then N'Nepal'
		when [Name] = 'Netherlands' then N'Países Bajos'
		when [Name] = 'Netherlands Antilles' then N'Antillas Holandesas'
		when [Name] = 'New Caledonia' then N'Nueva Caledonia'
		when [Name] = 'New Zealand' then N'Nuevo Zelandes'
		when [Name] = 'Nicaragua' then N'Nicaragua'
		when [Name] = 'Niger' then N'Níger'
		when [Name] = 'Nigeria' then N'Nigeria'
		when [Name] = 'Niue' then N'Niue'
		when [Name] = 'Norfolk Island' then N'Isla Norfolk'
		when [Name] = 'North Korea' then N'Corea Del Norte'
		when [Name] = 'Northern Mariana Islands' then N'Islas Marianas del Norte'
		when [Name] = 'Norway' then N'Noruega'
		when [Name] = 'Oman' then N'Omán'
		when [Name] = 'Pakistan' then N'Pakistán'
		when [Name] = 'Palau' then N'Palau'
		when [Name] = 'Panama' then N'Panamá'
		when [Name] = 'Papua New Guinea' then N'Papúa Nueva Guinea'
		when [Name] = 'Paraguay' then N'Paraguay'
		when [Name] = 'Peru' then N'Perú'
		when [Name] = 'Philippines' then N'Filipinas'
		when [Name] = 'Pitcairn Islands' then N'Islas Pitcairn'
		when [Name] = 'Poland' then N'Polonia'
		when [Name] = 'Portugal' then N'Portugal'
		when [Name] = 'Puerto Rico' then N'Puerto Rico'
		when [Name] = 'Qatar' then N'Katar'
		when [Name] = 'Republic of the Congo' then N'República del Congo'
		when [Name] = 'Romania' then N'Rumania'
		when [Name] = 'Russia' then N'Rusia'
		when [Name] = 'Rwanda' then N'Ruanda'
		when [Name] = 'Saint Barthelemy' then N'San Bartolomé'
		when [Name] = 'Saint Helena' then N'Santa Helena'
		when [Name] = 'Saint Kitts and Nevis' then N'San Cristóbal y Nieves'
		when [Name] = 'Saint Lucia' then N'Santa Lucía'
		when [Name] = 'Saint Martin' then N'Saint Martin'
		when [Name] = 'Saint Pierre and Miquelon' then N'San Pedro y Miquelón'
		when [Name] = 'Saint Vincent and the Grenadines' then N'San Vicente y las Granadinas'
		when [Name] = 'Samoa' then N'Samoa'
		when [Name] = 'San Marino' then N'San Marino'
		when [Name] = 'Sao Tome and Principe' then N'Santo Tomé y Príncipe'
		when [Name] = 'Saudi Arabia' then N'Arabia Saudita'
		when [Name] = 'Senegal' then N'Senegal'
		when [Name] = 'Serbia' then N'Serbia'
		when [Name] = 'Seychelles' then N'Seychelles'
		when [Name] = 'Sierra Leone' then N'Sierra Leona'
		when [Name] = 'Singapore' then N'Singapur'
		when [Name] = 'Slovakia' then N'Eslovaquia'
		when [Name] = 'Slovenia' then N'Eslovenia'
		when [Name] = 'Solomon Islands' then N'Islas Salomón'
		when [Name] = 'Somalia' then N'Somalia'
		when [Name] = 'South Africa' then N'Sudáfrica'
		when [Name] = 'South Korea' then N'Corea Del Sur'
		when [Name] = 'Spain' then N'España'
		when [Name] = 'Sri Lanka' then N'Sri Lanka'
		when [Name] = 'Sudan' then N'Sudán'
		when [Name] = 'Suriname' then N'Suriname'
		when [Name] = 'Swaziland' then N'Swazilandia'
		when [Name] = 'Sweden' then N'Suecia'
		when [Name] = 'Switzerland' then N'Suiza'
		when [Name] = 'Syria' then N'Siria'
		when [Name] = 'Taiwan' then N'Taiwán'
		when [Name] = 'Tajikistan' then N'Tayikistán'
		when [Name] = 'Tanzania' then N'Tanzania'
		when [Name] = 'Thailand' then N'Tailandia'
		when [Name] = 'Timor-Leste' then N'Timor-Leste'
		when [Name] = 'Togo' then N'Ir'
		when [Name] = 'Tokelau' then N'Tokelau'
		when [Name] = 'Tonga' then N'Tonga'
		when [Name] = 'Trinidad and Tobago' then N'Trinidad y Tobago'
		when [Name] = 'Tunisia' then N'Túnez'
		when [Name] = 'Turkey' then N'Pavo'
		when [Name] = 'Turkmenistan' then N'Turkmenistán'
		when [Name] = 'Turks and Caicos Islands' then N'Islas Turcas y Caicos'
		when [Name] = 'Tuvalu' then N'Tuvalu'
		when [Name] = 'Uganda' then N'Uganda'
		when [Name] = 'Ukraine' then N'Ucrania'
		when [Name] = 'United Arab Emirates' then N'Emiratos Árabes Unidos'
		when [Name] = 'United Kingdom' then N'Reino Unido'
		when [Name] = 'United States' then N'United States'
		when [Name] = 'Uruguay' then N'Uruguay'
		when [Name] = 'US Virgin Islands' then N'Islas Vírgenes de EE.UU.'
		when [Name] = 'Uzbekistan' then N'Uzbekistán'
		when [Name] = 'Vanuatu' then N'Vanuatu'
		when [Name] = 'Venezuela' then N'Venezuela'
		when [Name] = 'Vietnam' then N'Vietnam'
		when [Name] = 'Wallis and Futuna' then N'Wallis y Futuna'
		when [Name] = 'West Bank' then N'Banco Oeste'
		when [Name] = 'Yemen' then N'Yemen'
		when [Name] = 'Zambia' then N'Zambia'
		when [Name] = 'Zimbabwe' then N'Zimbabue'
		else N''
		end as [Name]
	from [Region] a
	) a where a.[Name] <> ''

	
) a 


insert into [RegionY]
(RegionId, SystemLanguageId, [Name], CreateDate)
select a.RegionId, @SystemLanguageId, a.[Name], GETUTCDATE()
from @Tbl_RegionY a 
	left join  [RegionY] z on a.RegionId = z.RegionId and z.SystemLanguageId = @SystemLanguageId 
where z.Id is null


delete
--select * from
RegionY where SystemLanguageId = @SystemLanguageId and Id not in (
	select a.Id
	from RegionY a inner join Region b on a.RegionId = b.Id and a.SystemLanguageId = @SystemLanguageId
)

update a
set a.[Name] = b.[Name]
from RegionY a inner join @Tbl_RegionY b on a.SystemLanguageId = b.SystemLanguageId and a.RegionId = b.RegionId and a.[Name] <> b.[Name]

select * from [RegionY] where SystemLanguageId = @SystemLanguageId
order by [Name]

/*
select * from Region a left join RegionY b on b.SystemLanguageId = 4 and a.Id = b.RegionId
where b.Id is null

select * from SystemLanguage

select '		when [Name] = ''' + a.[Name] + ''' then N''' + c.TranslatedRegionName + ''''
--select *
from Region a left join RegionY b on b.SystemLanguageId = 4 and a.Id = b.RegionId
	left join [UtilityDB].[dbo].[TranslatedRegionNameTbl] c on a.Id = c.RegionId and c.SystemLanguageId = 4
where b.Id is null
order by a.[Name]


*/


