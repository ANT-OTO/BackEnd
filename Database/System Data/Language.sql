

use weyi

declare @Tbl_Language Table
(
	Id int NOT NULL,
	EnglishName nvarchar(256) NOT NULL,
	Available bit NOT NULL
)

insert into @Tbl_Language
(Id, [EnglishName], Available)
select a.*
from (
	
select 1 as Id, N'Arabic' as [EnglishName], 1 as Available
UNION
select 2 as Id, N'Armenian' as [EnglishName], 1 as Available
UNION
select 3 as Id, N'Bengali' as [EnglishName], 1 as Available
UNION
select 4 as Id, N'Bosnian' as [EnglishName], 1 as Available
UNION
select 5 as Id, N'Bulgarian' as [EnglishName], 1 as Available
UNION
select 6 as Id, N'Burmese' as [EnglishName], 1 as Available
UNION
select 7 as Id, N'Chinese Cantonese' as [EnglishName], 1 as Available
UNION
select 8 as Id, N'Chinese Mandarin' as [EnglishName], 1 as Available
UNION
select 9 as Id, N'Croatian' as [EnglishName], 1 as Available
UNION
select 10 as Id, N'Czech' as [EnglishName], 1 as Available
UNION
select 11 as Id, N'Danish' as [EnglishName], 1 as Available
UNION
select 12 as Id, N'Dutch' as [EnglishName], 1 as Available
UNION
select 13 as Id, N'English' as [EnglishName], 1 as Available
UNION
select 14 as Id, N'Filipino' as [EnglishName], 1 as Available
UNION
select 15 as Id, N'Finnish' as [EnglishName], 1 as Available
UNION
select 16 as Id, N'French' as [EnglishName], 1 as Available
UNION
select 17 as Id, N'German' as [EnglishName], 1 as Available
UNION
select 18 as Id, N'Hebrew' as [EnglishName], 1 as Available
UNION
select 19 as Id, N'Hindi' as [EnglishName], 1 as Available
UNION
select 20 as Id, N'Icelandic' as [EnglishName], 1 as Available
UNION
select 21 as Id, N'Indonesian' as [EnglishName], 1 as Available
UNION
select 22 as Id, N'Indonesian Javanese' as [EnglishName], 1 as Available
UNION
select 23 as Id, N'Italian' as [EnglishName], 1 as Available
UNION
select 24 as Id, N'Japanese' as [EnglishName], 1 as Available
UNION
select 25 as Id, N'Korean' as [EnglishName], 1 as Available
UNION
select 26 as Id, N'Lao' as [EnglishName], 1 as Available
UNION
select 27 as Id, N'Latin' as [EnglishName], 1 as Available
UNION
select 28 as Id, N'Latvian' as [EnglishName], 1 as Available
UNION
select 29 as Id, N'Lithuanian' as [EnglishName], 1 as Available
UNION
select 30 as Id, N'Macedonian' as [EnglishName], 1 as Available
UNION
select 31 as Id, N'Malay' as [EnglishName], 1 as Available
UNION
select 32 as Id, N'Maltese' as [EnglishName], 1 as Available
UNION
select 33 as Id, N'Mongolian' as [EnglishName], 1 as Available
UNION
select 34 as Id, N'Norwegian' as [EnglishName], 1 as Available
UNION
select 35 as Id, N'Persian' as [EnglishName], 1 as Available
UNION
select 36 as Id, N'Polish' as [EnglishName], 1 as Available
UNION
select 37 as Id, N'Portuguese' as [EnglishName], 1 as Available
UNION
select 38 as Id, N'Romanian' as [EnglishName], 1 as Available
UNION
select 39 as Id, N'Russian' as [EnglishName], 1 as Available
UNION
select 40 as Id, N'Serbian' as [EnglishName], 1 as Available
UNION
select 41 as Id, N'Slovak' as [EnglishName], 1 as Available
UNION
select 42 as Id, N'Slovenian' as [EnglishName], 1 as Available
UNION
select 43 as Id, N'South Africa Zulu' as [EnglishName], 1 as Available
UNION
select 44 as Id, N'Spanish' as [EnglishName], 1 as Available
UNION
select 45 as Id, N'Swedish' as [EnglishName], 1 as Available
UNION
select 46 as Id, N'Thai' as [EnglishName], 1 as Available
UNION
select 47 as Id, N'Turkish' as [EnglishName], 1 as Available
UNION
select 48 as Id, N'Ukrainian' as [EnglishName], 1 as Available
UNION
select 49 as Id, N'Uzbek' as [EnglishName], 1 as Available
UNION
select 50 as Id, N'Vietnamese' as [EnglishName], 1 as Available
UNION
select 51 as Id, N'Greek' as [EnglishName], 1 as Available
UNION
select 52 as Id, N'Amharic' as [EnglishName], 1 as Available
UNION
select 53 as Id, N'Cambodian' as [EnglishName], 0 as Available
UNION
select 54 as Id, N'Haitian Creole' as [EnglishName], 1 as Available
UNION
select 55 as Id, N'Swahili' as [EnglishName], 1 as Available
UNION
select 56 as Id, N'Kinyarwanda' as [EnglishName], 1 as Available
UNION
select 57 as Id, N'Nepali' as [EnglishName], 1 as Available
UNION
select 58 as Id, N'Somali' as [EnglishName], 1 as Available
UNION
select 59 as Id, N'Tongan' as [EnglishName], 1 as Available
UNION
select 60 as Id, N'American Sign Language' as [EnglishName], 1 as Available
UNION
select 61 as Id, N'Hungarian' as [EnglishName], 1 as Available
UNION
select 62 as Id, N'Albanian' as [EnglishName], 1 as Available
UNION
select 63 as Id, N'Tagalog' as [EnglishName], 1 as Available
UNION
select 64 as Id, N'Urdu' as [EnglishName], 1 as Available
UNION
select 65 as Id, N'Acehnese' as [EnglishName], 1 as Available
UNION
select 66 as Id, N'Acholi' as [EnglishName], 1 as Available
UNION
select 67 as Id, N'Afghani' as [EnglishName], 1 as Available
UNION
select 68 as Id, N'Afrikaans' as [EnglishName], 1 as Available
UNION
select 69 as Id, N'Akan' as [EnglishName], 1 as Available
UNION
select 70 as Id, N'Akateco' as [EnglishName], 1 as Available
UNION
select 71 as Id, N'Anuak' as [EnglishName], 1 as Available
UNION
select 72 as Id, N'Arabic (Egyptian)' as [EnglishName], 1 as Available
UNION
select 73 as Id, N'Arabic (Iraqi)' as [EnglishName], 1 as Available
UNION
select 74 as Id, N'Arabic (Moroccan)' as [EnglishName], 1 as Available
UNION
select 75 as Id, N'Arabic (Sudanese)' as [EnglishName], 1 as Available
UNION
select 76 as Id, N'Arabic (Yemeni)' as [EnglishName], 1 as Available
UNION
select 77 as Id, N'Ashanti' as [EnglishName], 1 as Available
UNION
select 78 as Id, N'Assyrian' as [EnglishName], 1 as Available
UNION
select 79 as Id, N'Azeri' as [EnglishName], 1 as Available
UNION
select 80 as Id, N'Bahasa (Malaysian)' as [EnglishName], 1 as Available
UNION
select 81 as Id, N'Bambara' as [EnglishName], 1 as Available
UNION
select 82 as Id, N'Bashkir' as [EnglishName], 1 as Available
UNION
select 83 as Id, N'Basque' as [EnglishName], 1 as Available
UNION
select 84 as Id, N'Bassa' as [EnglishName], 1 as Available
UNION
select 85 as Id, N'Belarusian' as [EnglishName], 1 as Available
UNION
select 86 as Id, N'Cape Verde Creole' as [EnglishName], 1 as Available
UNION
select 87 as Id, N'Carolinian' as [EnglishName], 1 as Available
UNION
select 88 as Id, N'Catalan' as [EnglishName], 1 as Available
UNION
select 89 as Id, N'Cebuano' as [EnglishName], 1 as Available
UNION
select 90 as Id, N'Chaldean' as [EnglishName], 1 as Available
UNION
select 91 as Id, N'Chamorro' as [EnglishName], 1 as Available
UNION
select 92 as Id, N'Chao-Chow' as [EnglishName], 1 as Available
UNION
select 93 as Id, N'Cherokee' as [EnglishName], 1 as Available
UNION
select 94 as Id, N'Chin' as [EnglishName], 1 as Available
UNION
select 95 as Id, N'Chin (Falam)' as [EnglishName], 1 as Available
UNION
select 96 as Id, N'Chin (Hakha)' as [EnglishName], 1 as Available
UNION
select 97 as Id, N'Chin (Lai)' as [EnglishName], 1 as Available
UNION
select 98 as Id, N'Chin (Mizo)' as [EnglishName], 1 as Available
UNION
select 99 as Id, N'Chin (Tedim)' as [EnglishName], 1 as Available
UNION
select 100 as Id, N'Chin (Zo, Zomi)' as [EnglishName], 1 as Available
UNION
select 101 as Id, N'Chin (Zophei)' as [EnglishName], 1 as Available
UNION
select 102 as Id, N'Choujo' as [EnglishName], 1 as Available
UNION
select 103 as Id, N'Chuukese' as [EnglishName], 1 as Available
UNION
select 104 as Id, N'Cotocoli (Tem)' as [EnglishName], 1 as Available
UNION
select 105 as Id, N'Dari' as [EnglishName], 1 as Available
UNION
select 106 as Id, N'Dinka' as [EnglishName], 1 as Available
UNION
select 107 as Id, N'Dioula' as [EnglishName], 1 as Available
UNION
select 108 as Id, N'Edo' as [EnglishName], 1 as Available
UNION
select 109 as Id, N'Estonian' as [EnglishName], 1 as Available
UNION
select 110 as Id, N'Ewe' as [EnglishName], 1 as Available
UNION
select 111 as Id, N'Farsi' as [EnglishName], 1 as Available
UNION
select 112 as Id, N'Flemish' as [EnglishName], 1 as Available
UNION
select 113 as Id, N'Foochow (Fuzhou)' as [EnglishName], 1 as Available
UNION
select 114 as Id, N'French Canadian' as [EnglishName], 1 as Available
UNION
select 115 as Id, N'French Creole' as [EnglishName], 1 as Available
UNION
select 116 as Id, N'Fukienese' as [EnglishName], 1 as Available
UNION
select 117 as Id, N'Fulani' as [EnglishName], 1 as Available
UNION
select 118 as Id, N'Fulde' as [EnglishName], 1 as Available
UNION
select 119 as Id, N'Ga' as [EnglishName], 1 as Available
UNION
select 120 as Id, N'Garre' as [EnglishName], 1 as Available
UNION
select 121 as Id, N'Georgian' as [EnglishName], 1 as Available
UNION
select 122 as Id, N'Guarani' as [EnglishName], 1 as Available
UNION
select 123 as Id, N'Gujarati' as [EnglishName], 1 as Available
UNION
select 124 as Id, N'Hainanese' as [EnglishName], 1 as Available
UNION
select 125 as Id, N'Hakka (Chinese)' as [EnglishName], 1 as Available
UNION
select 126 as Id, N'Harar' as [EnglishName], 1 as Available
UNION
select 127 as Id, N'Hassaniya' as [EnglishName], 1 as Available
UNION
select 128 as Id, N'Hausa' as [EnglishName], 1 as Available
UNION
select 129 as Id, N'Hmong' as [EnglishName], 1 as Available
UNION
select 130 as Id, N'Hokkien' as [EnglishName], 1 as Available
UNION
select 131 as Id, N'Igbo' as [EnglishName], 1 as Available
UNION
select 132 as Id, N'Ilocano' as [EnglishName], 1 as Available
UNION
select 133 as Id, N'Jarai' as [EnglishName], 1 as Available
UNION
select 134 as Id, N'Jiangsu' as [EnglishName], 1 as Available
UNION
select 135 as Id, N'K’iche’ (Quiché)' as [EnglishName], 1 as Available
UNION
select 136 as Id, N'Kannada' as [EnglishName], 1 as Available
UNION
select 137 as Id, N'Karen' as [EnglishName], 1 as Available
UNION
select 138 as Id, N'Karen (Pwo)' as [EnglishName], 1 as Available
UNION
select 139 as Id, N'Karenni (Kayah)' as [EnglishName], 1 as Available
UNION
select 140 as Id, N'Kazakh' as [EnglishName], 1 as Available
UNION
select 141 as Id, N'Cambodian (Khmer)' as [EnglishName], 1 as Available
UNION
select 142 as Id, N'Kikongo' as [EnglishName], 1 as Available
UNION
select 143 as Id, N'Kikuyu' as [EnglishName], 1 as Available
UNION
select 144 as Id, N'Kinyamulenge' as [EnglishName], 1 as Available
UNION
select 145 as Id, N'Kirundi' as [EnglishName], 1 as Available
UNION
select 146 as Id, N'Kituba' as [EnglishName], 1 as Available
UNION
select 147 as Id, N'Kizigua (Kizigula)' as [EnglishName], 1 as Available
UNION
select 148 as Id, N'Kosraean' as [EnglishName], 1 as Available
UNION
select 149 as Id, N'Krahn' as [EnglishName], 1 as Available
UNION
select 150 as Id, N'Krio' as [EnglishName], 1 as Available
UNION
select 151 as Id, N'Kunama' as [EnglishName], 1 as Available
UNION
select 152 as Id, N'Kurdish' as [EnglishName], 1 as Available
UNION
select 153 as Id, N'Kurdish (Bahdini)' as [EnglishName], 1 as Available
UNION
select 154 as Id, N'Kurdish (Kurmanji)' as [EnglishName], 1 as Available
UNION
select 155 as Id, N'Kurdish (Sorani)' as [EnglishName], 1 as Available
UNION
select 156 as Id, N'Kyrgyz' as [EnglishName], 1 as Available
UNION
select 157 as Id, N'Lautu' as [EnglishName], 1 as Available
UNION
select 158 as Id, N'Lingala' as [EnglishName], 1 as Available
UNION
select 159 as Id, N'Lorma' as [EnglishName], 1 as Available
UNION
select 160 as Id, N'Luganda' as [EnglishName], 1 as Available
UNION
select 161 as Id, N'Luo' as [EnglishName], 1 as Available
UNION
select 162 as Id, N'Maay-Maay' as [EnglishName], 1 as Available
UNION
select 163 as Id, N'Malayalam' as [EnglishName], 1 as Available
UNION
select 164 as Id, N'Mam' as [EnglishName], 1 as Available
UNION
select 165 as Id, N'Mandinka' as [EnglishName], 1 as Available
UNION
select 166 as Id, N'Mara' as [EnglishName], 1 as Available
UNION
select 167 as Id, N'Marathi' as [EnglishName], 1 as Available
UNION
select 168 as Id, N'Marshallese' as [EnglishName], 1 as Available
UNION
select 169 as Id, N'Matu' as [EnglishName], 1 as Available
UNION
select 170 as Id, N'Mbay' as [EnglishName], 1 as Available
UNION
select 171 as Id, N'Mende' as [EnglishName], 1 as Available
UNION
select 172 as Id, N'Mien' as [EnglishName], 1 as Available
UNION
select 173 as Id, N'Mina' as [EnglishName], 1 as Available
UNION
select 174 as Id, N'Mixteco (Alto)' as [EnglishName], 1 as Available
UNION
select 175 as Id, N'Mixteco (Bajo)' as [EnglishName], 1 as Available
UNION
select 176 as Id, N'Moldovan' as [EnglishName], 1 as Available
UNION
select 177 as Id, N'Montenegrin' as [EnglishName], 1 as Available
UNION
select 178 as Id, N'Mushunguli' as [EnglishName], 1 as Available
UNION
select 179 as Id, N'Navajo' as [EnglishName], 1 as Available
UNION
select 180 as Id, N'Nuer' as [EnglishName], 1 as Available
UNION
select 181 as Id, N'Oromifa' as [EnglishName], 1 as Available
UNION
select 182 as Id, N'Pashto' as [EnglishName], 1 as Available
UNION
select 183 as Id, N'Patois (Jamaican)' as [EnglishName], 1 as Available
UNION
select 184 as Id, N'Pidgin (Cameroonian)' as [EnglishName], 1 as Available
UNION
select 185 as Id, N'Pidgin (Nigerian)' as [EnglishName], 1 as Available
UNION
select 186 as Id, N'Ponapean/Pohnpeian' as [EnglishName], 1 as Available
UNION
select 187 as Id, N'Portuguese (Brazilian)' as [EnglishName], 1 as Available
UNION
select 188 as Id, N'Portuguese (European)' as [EnglishName], 1 as Available
UNION
select 189 as Id, N'Portuguese Creole' as [EnglishName], 1 as Available
UNION
select 190 as Id, N'Pulaar' as [EnglishName], 1 as Available
UNION
select 191 as Id, N'Punjabi' as [EnglishName], 1 as Available
UNION
select 192 as Id, N'Q’anjob’al' as [EnglishName], 1 as Available
UNION
select 193 as Id, N'Rohingya' as [EnglishName], 1 as Available
UNION
select 194 as Id, N'Samoan' as [EnglishName], 1 as Available
UNION
select 195 as Id, N'Sango' as [EnglishName], 1 as Available
UNION
select 196 as Id, N'Senthang' as [EnglishName], 1 as Available
UNION
select 197 as Id, N'Shanghainese' as [EnglishName], 1 as Available
UNION
select 198 as Id, N'Shona' as [EnglishName], 1 as Available
UNION
select 199 as Id, N'Sichuan' as [EnglishName], 1 as Available
UNION
select 200 as Id, N'Sicilian' as [EnglishName], 1 as Available
UNION
select 201 as Id, N'Sinhalese' as [EnglishName], 1 as Available
UNION
select 202 as Id, N'Siyin' as [EnglishName], 1 as Available
UNION
select 203 as Id, N'Slovene' as [EnglishName], 1 as Available
UNION
select 204 as Id, N'Somali Bantu' as [EnglishName], 1 as Available
UNION
select 205 as Id, N'Soninke' as [EnglishName], 1 as Available
UNION
select 206 as Id, N'Soninke (Sarahuli)' as [EnglishName], 1 as Available
UNION
select 207 as Id, N'Soninke (Sarakhole)' as [EnglishName], 1 as Available
UNION
select 208 as Id, N'Soranî (Kurdish)' as [EnglishName], 1 as Available
UNION
select 209 as Id, N'Sousou' as [EnglishName], 1 as Available
UNION
select 210 as Id, N'Sylheti' as [EnglishName], 1 as Available
UNION
select 211 as Id, N'Taiwanese' as [EnglishName], 1 as Available
UNION
select 212 as Id, N'Tajik' as [EnglishName], 1 as Available
UNION
select 213 as Id, N'Tamil' as [EnglishName], 1 as Available
UNION
select 214 as Id, N'Telugu' as [EnglishName], 1 as Available
UNION
select 215 as Id, N'Temne' as [EnglishName], 1 as Available
UNION
select 216 as Id, N'Teochew' as [EnglishName], 1 as Available
UNION
select 217 as Id, N'Tibetan' as [EnglishName], 1 as Available
UNION
select 218 as Id, N'Tigrinya' as [EnglishName], 1 as Available
UNION
select 219 as Id, N'Toisanese' as [EnglishName], 1 as Available
UNION
select 220 as Id, N'Tosk' as [EnglishName], 1 as Available
UNION
select 221 as Id, N'Trukese/Chuukese' as [EnglishName], 1 as Available
UNION
select 222 as Id, N'Twi' as [EnglishName], 1 as Available
UNION
select 223 as Id, N'Visayan' as [EnglishName], 1 as Available
UNION
select 224 as Id, N'Wolof' as [EnglishName], 1 as Available
UNION
select 225 as Id, N'Xhosa' as [EnglishName], 1 as Available
UNION
select 226 as Id, N'Yiddish' as [EnglishName], 1 as Available
UNION
select 227 as Id, N'Yoruba' as [EnglishName], 1 as Available
UNION
select 228 as Id, N'Yup’ik' as [EnglishName], 1 as Available
UNION
select 229 as Id, N'Azerbaijani' as [EnglishName], 1 as Available
UNION
select 230 as Id, N'Operator' as [EnglishName], 1 as Available
UNION
select 231 as Id, N'Mexican Sign Language' as [EnglishName], 1 as Available
UNION
select 232 as Id, N'Fur' as [EnglishName], 1 as Available
UNION
select 233 as Id, N'Masalit' as [EnglishName], 1 as Available
UNION
select 234 as Id, N'Palauan' as [EnglishName], 1 as Available
UNION 
select 235 as Id, N'Language Operator' as [EnglishName], 1 as Available
UNION 
select 236 as Id, N'Afar' as [EnglishName], 0 as Available
UNION 
select 237 as Id, N'Albanian (Kosovo)' as [EnglishName], 0 as Available
UNION 
select 238 as Id, N'Algerian' as [EnglishName], 0 as Available
UNION 
select 239 as Id, N'Arabic (Classical/North African)' as [EnglishName], 0 as Available
UNION 
select 240 as Id, N'Arabic (Modern Standard)' as [EnglishName], 0 as Available
UNION 
select 241 as Id, N'Aramaic' as [EnglishName], 0 as Available
UNION 
select 242 as Id, N'Assamese' as [EnglishName], 0 as Available
UNION 
select 243 as Id, N'Aymara' as [EnglishName], 0 as Available
UNION 
select 244 as Id, N'Azerbaijani (North)' as [EnglishName], 0 as Available
UNION 
select 245 as Id, N'Azerbaijani (Southern)' as [EnglishName], 0 as Available
UNION 
select 246 as Id, N'Bahasa Indonesian' as [EnglishName], 0 as Available
UNION 
select 247 as Id, N'Bahasa Jakarta' as [EnglishName], 0 as Available
UNION 
select 248 as Id, N'Bahnar' as [EnglishName], 0 as Available
UNION 
select 249 as Id, N'Balinese' as [EnglishName], 0 as Available
UNION 
select 250 as Id, N'Balochi - Eastern' as [EnglishName], 0 as Available
UNION 
select 251 as Id, N'Balochi - Southern' as [EnglishName], 0 as Available
UNION 
select 252 as Id, N'Balochi - Western' as [EnglishName], 0 as Available
UNION 
select 253 as Id, N'Bamanankan' as [EnglishName], 0 as Available
UNION 
select 254 as Id, N'Bemba DRC' as [EnglishName], 0 as Available
UNION 
select 255 as Id, N'Bemba Zambia' as [EnglishName], 0 as Available
UNION 
select 256 as Id, N'Berti' as [EnglishName], 0 as Available
UNION 
select 257 as Id, N'Bete' as [EnglishName], 0 as Available
UNION 
select 258 as Id, N'Bilen' as [EnglishName], 0 as Available
UNION 
select 259 as Id, N'Bravanese' as [EnglishName], 0 as Available
UNION 
select 260 as Id, N'Breton' as [EnglishName], 0 as Available
UNION 
select 261 as Id, N'Chaldean - Neo Aramaic' as [EnglishName], 0 as Available
UNION 
select 262 as Id, N'Chavacano' as [EnglishName], 0 as Available
UNION 
select 263 as Id, N'Chechen' as [EnglishName], 0 as Available
UNION 
select 264 as Id, N'Chichewa' as [EnglishName], 0 as Available
UNION 
select 265 as Id, N'English Creole' as [EnglishName], 0 as Available
UNION 
select 266 as Id, N'Jamaican Creole' as [EnglishName], 0 as Available
UNION 
select 267 as Id, N'Spanish Creole' as [EnglishName], 0 as Available
UNION 
select 268 as Id, N'Daju' as [EnglishName], 0 as Available
UNION 
select 269 as Id, N'Dakota' as [EnglishName], 0 as Available
UNION 
select 270 as Id, N'Dari (Afghan)' as [EnglishName], 0 as Available
UNION 
select 271 as Id, N'Dari (Iranian)' as [EnglishName], 0 as Available
UNION 
select 272 as Id, N'Dinka - North Eastern' as [EnglishName], 0 as Available
UNION 
select 273 as Id, N'Dinka - North Western' as [EnglishName], 0 as Available
UNION 
select 274 as Id, N'Dinka - South Eastern' as [EnglishName], 0 as Available
UNION 
select 275 as Id, N'Dinka - South Western' as [EnglishName], 0 as Available
UNION 
select 276 as Id, N'Dinka - Southern Central' as [EnglishName], 0 as Available
UNION
select 277 as Id, N'English (AUS)' as [EnglishName], 0 as Available
UNION 
select 278 as Id, N'English (Pidgin)' as [EnglishName], 0 as Available
UNION 
select 279 as Id, N'Esperanto' as [EnglishName], 0 as Available
UNION 
select 280 as Id, N'Faroese' as [EnglishName], 0 as Available
UNION 
select 281 as Id, N'Fataluku' as [EnglishName], 0 as Available
UNION 
select 282 as Id, N'Fellata/Fulfulde' as [EnglishName], 0 as Available
UNION 
select 283 as Id, N'Fijian' as [EnglishName], 0 as Available
UNION 
select 284 as Id, N'Fon' as [EnglishName], 0 as Available
UNION 
select 285 as Id, N'French (Algerian)' as [EnglishName], 0 as Available
UNION 
select 286 as Id, N'French (Belgium)' as [EnglishName], 0 as Available
UNION 
select 287 as Id, N'French (Congolese)' as [EnglishName], 0 as Available
UNION 
select 288 as Id, N'Frisian - Eastern' as [EnglishName], 0 as Available
UNION 
select 289 as Id, N'Frisian - Northern' as [EnglishName], 0 as Available
UNION 
select 290 as Id, N'Frisian - Western' as [EnglishName], 0 as Available
UNION 
select 291 as Id, N'Friulian' as [EnglishName], 0 as Available
UNION 
select 292 as Id, N'Fula' as [EnglishName], 0 as Available
UNION 
select 293 as Id, N'Gaddang' as [EnglishName], 0 as Available
UNION 
select 294 as Id, N'Gaelic (Irish)' as [EnglishName], 0 as Available
UNION 
select 295 as Id, N'Gaelic (Scottish)' as [EnglishName], 0 as Available
UNION 
select 296 as Id, N'Gaelic Manx (Isle of Man)' as [EnglishName], 0 as Available
UNION 
select 297 as Id, N'Galician' as [EnglishName], 0 as Available
UNION 
select 298 as Id, N'Ganda' as [EnglishName], 0 as Available
UNION
select 299 as Id, N'German (Austrian)' as [EnglishName], 0 as Available
UNION 
select 300 as Id, N'German (Swiss)' as [EnglishName], 0 as Available
UNION 
select 301 as Id, N'Goraani' as [EnglishName], 0 as Available
UNION 
select 302 as Id, N'Greenlandic' as [EnglishName], 0 as Available
UNION 
select 303 as Id, N'Guarani (Ava)' as [EnglishName], 0 as Available
UNION 
select 304 as Id, N'Guarani (Eastern Bolivian)' as [EnglishName], 0 as Available
UNION 
select 305 as Id, N'Guarani (Mbayi)' as [EnglishName], 0 as Available
UNION 
select 306 as Id, N'Guarani (Paraguayan)' as [EnglishName], 0 as Available
UNION 
select 307 as Id, N'Guarani (Western Bolivian)' as [EnglishName], 0 as Available
UNION 
select 308 as Id, N'Gusii' as [EnglishName], 0 as Available
UNION 
select 309 as Id, N'Hawaiian' as [EnglishName], 0 as Available
UNION 
select 310 as Id, N'Herero' as [EnglishName], 0 as Available
UNION 
select 311 as Id, N'Hindko' as [EnglishName], 0 as Available
UNION 
select 312 as Id, N'Hindustani' as [EnglishName], 0 as Available
UNION 
select 313 as Id, N'Hmong Njua' as [EnglishName], 0 as Available
UNION 
select 314 as Id, N'Chinese Hubei Dangyanghua' as [EnglishName], 0 as Available
UNION 
select 315 as Id, N'Ibanag' as [EnglishName], 0 as Available
UNION 
select 316 as Id, N'Ilonggo' as [EnglishName], 0 as Available
UNION 
select 317 as Id, N'Inuit' as [EnglishName], 0 as Available
UNION 
select 318 as Id, N'Jola-Felupe' as [EnglishName], 0 as Available
UNION 
select 319 as Id, N'Jola-Fonyi' as [EnglishName], 0 as Available
UNION 
select 320 as Id, N'Jola-Kasa' as [EnglishName], 0 as Available
UNION 
select 321 as Id, N'Jula' as [EnglishName], 0 as Available
UNION 
select 322 as Id, N'Kalabari' as [EnglishName], 0 as Available
UNION 
select 323 as Id, N'Kalmyk-Oirat' as [EnglishName], 0 as Available
UNION 
select 324 as Id, N'Karen (Thailand)' as [EnglishName], 0 as Available
UNION 
select 325 as Id, N'Kashmiri' as [EnglishName], 0 as Available
UNION 
select 326 as Id, N'Katharevousa' as [EnglishName], 0 as Available 
UNION 
select 327 as Id, N'Kayah (Eastern)' as [EnglishName], 0 as Available
UNION 
select 328 as Id, N'Kayah (Western)' as [EnglishName], 0 as Available
UNION 
select 329 as Id, N'Kibajuni' as [EnglishName], 0 as Available
UNION 
select 330 as Id, N'Kiribati' as [EnglishName], 0 as Available
UNION 
select 331 as Id, N'Kiswahili' as [EnglishName], 0 as Available
UNION 
select 332 as Id, N'Konkani' as [EnglishName], 0 as Available
UNION 
select 333 as Id, N'Kurdish (Kurmanji/Bahdini)' as [EnglishName], 0 as Available
UNION 
select 334 as Id, N'Kutchi' as [EnglishName], 0 as Available
UNION 
select 335 as Id, N'Kyrghiz' as [EnglishName], 0 as Available
UNION 
select 336 as Id, N'Lak' as [EnglishName], 0 as Available
UNION 
select 337 as Id, N'Lakota' as [EnglishName], 0 as Available
UNION 
select 338 as Id, N'Laur' as [EnglishName], 0 as Available
UNION 
select 339 as Id, N'Lozi' as [EnglishName], 0 as Available
UNION 
select 340 as Id, N'Luxembourgish' as [EnglishName], 0 as Available
UNION 
select 341 as Id, N'Macedonian Gorani' as [EnglishName], 0 as Available
UNION 
select 342 as Id, N'Malagasy' as [EnglishName], 0 as Available
UNION 
select 343 as Id, N'Maldivian' as [EnglishName], 0 as Available
UNION 
select 344 as Id, N'Malinke' as [EnglishName], 0 as Available
UNION 
select 345 as Id, N'Mandinka' as [EnglishName], 0 as Available
UNION 
select 346 as Id, N'Maninka' as [EnglishName], 0 as Available
UNION 
select 347 as Id, N'Maori' as [EnglishName], 0 as Available
UNION 
select 348 as Id, N'Mararit' as [EnglishName], 0 as Available
UNION 
select 349 as Id, N'Macedonian Gorani' as [EnglishName], 0 as Available
UNION 
select 350 as Id, N'Malagasy' as [EnglishName], 0 as Available
UNION 
select 351 as Id, N'Maldivian' as [EnglishName], 0 as Available
UNION 
select 352 as Id, N'Malinke' as [EnglishName], 0 as Available
UNION 
select 353 as Id, N'Maninka' as [EnglishName], 0 as Available
UNION 
select 354 as Id, N'Maori' as [EnglishName], 0 as Available
UNION 
select 355 as Id, N'Mararit' as [EnglishName], 0 as Available
UNION 
select 356 as Id, N'Mauritian Creole' as [EnglishName], 0 as Available
UNION 
select 357 as Id, N'Mirpuri' as [EnglishName], 0 as Available
UNION 
select 358 as Id, N'Ndebele - Northern' as [EnglishName], 0 as Available
UNION 
select 359 as Id, N'Ndebele - Southern' as [EnglishName], 0 as Available
UNION 
select 360 as Id, N'Nepalese' as [EnglishName], 0 as Available
UNION 
select 361 as Id, N'Oriya' as [EnglishName], 0 as Available
UNION 
select 362 as Id, N'Oromo (Central)' as [EnglishName], 0 as Available
UNION 
select 363 as Id, N'Pahari - Kullu' as [EnglishName], 0 as Available
UNION 
select 364 as Id, N'Pahari - Mashu' as [EnglishName], 0 as Available
UNION 
select 365 as Id, N'Pashto (Afghanistan)' as [EnglishName], 0 as Available
UNION 
select 366 as Id, N'Pashto (Pakistan)' as [EnglishName], 0 as Available
UNION 
select 367 as Id, N'Potowari (Pahari)' as [EnglishName], 0 as Available
UNION 
select 368 as Id, N'Punjabi, Eastern (India)' as [EnglishName], 0 as Available
UNION 
select 369 as Id, N'Punjabi, Western (Pakistan)' as [EnglishName], 0 as Available
UNION 
select 370 as Id, N'Roma' as [EnglishName], 0 as Available
UNION 
select 371 as Id, N'Romany' as [EnglishName], 0 as Available
UNION 
select 372 as Id, N'Runyankole' as [EnglishName], 0 as Available
UNION 
select 373 as Id, N'Sanskrit' as [EnglishName], 0 as Available
UNION 
select 374 as Id, N'Sardinian (Campidanese)' as [EnglishName], 0 as Available
UNION 
select 375 as Id, N'Sindhi' as [EnglishName], 0 as Available
UNION 
select 376 as Id, N'Sinhala' as [EnglishName], 0 as Available
UNION 
select 377 as Id, N'Susu' as [EnglishName], 0 as Available
UNION 
select 378 as Id, N'Swahili (Coastal)' as [EnglishName], 0 as Available
UNION 
select 379 as Id, N'Swahili (Congo)' as [EnglishName], 0 as Available
UNION 
select 380 as Id, N'Swazi' as [EnglishName], 0 as Available
UNION 
select 381 as Id, N'Tahitian' as [EnglishName], 0 as Available
UNION 
select 382 as Id, N'Tajiki' as [EnglishName], 0 as Available
UNION 
select 383 as Id, N'Tama' as [EnglishName], 0 as Available
UNION 
select 384 as Id, N'Tetum' as [EnglishName], 0 as Available
UNION 
select 385 as Id, N'Tigre' as [EnglishName], 1 as Available
UNION 
select 386 as Id, N'Tswana' as [EnglishName], 0 as Available
UNION 
select 387 as Id, N'Turkmen' as [EnglishName], 0 as Available
UNION 
select 388 as Id, N'Uzbek (Northern)' as [EnglishName], 0 as Available
UNION 
select 389 as Id, N'Venda' as [EnglishName], 0 as Available
UNION 
select 390 as Id, N'Welsh' as [EnglishName], 0 as Available
UNION 
select 391 as Id, N'Xiang (Chinese Hunan)' as [EnglishName], 0 as Available
UNION 
select 392 as Id, N'Zaghawa' as [EnglishName], 0 as Available
UNION
select 393 as Id, N'British Sign Language' as [EnglishName], 0 as Available
UNION 
select 998 as Id, N'Service Assistant' as [EnglishName], 1 as Available
UNION 
select 999 as Id, N'Language Not in the List - For Admin Only' as [EnglishName], 1 as Available

) a 
order by a.Id

select a.Id, a.[EnglishName], a.Available
from @Tbl_Language a
	left join  [Language] z on a.Id = z.Id 
where z.Id is null
order by a.Id



select *
from [Language] a inner join @Tbl_Language b on a.Id = b.Id
where NOT (a.EnglishName = b.EnglishName and a.Available = isnull(b.Available, 0) )

/*

select 'select ' + convert(varchar(16), a.Id) + ' as Id, N''' + replace(a.EnglishName, '''', '''''') + ''' as [EnglishName], ' + convert(varchar(16), a.Available) + ' as Available
UNION
' from [Language] a
order by a.Id

*/

SET IDENTITY_INSERT dbo.[Language] ON 

insert into [Language]
(Id, [EnglishName], Available)
select a.Id, a.[EnglishName], a.Available
from @Tbl_Language a
	left join  [Language] z on a.Id = z.Id 
where z.Id is null
order by a.Id

SET IDENTITY_INSERT dbo.[Language] OFF 

update a
set a.EnglishName = b.EnglishName, a.Available = isnull(b.Available, 0)
--select *
from [Language] a inner join @Tbl_Language b on a.Id = b.Id
where NOT (a.EnglishName = b.EnglishName and a.Available = isnull(b.Available, 0) )

--update a
--set a.Available = 0
--from [Language] a
--where a.EnglishName in (
--'Toisanese',
--'Temne',
--'Yup’ik',
--'Sousou',
--'Siyin',
--'Senthang',
--'Q’anjob’al',
--'Mushunguli',
--'Mbay',
--'Mam',
--'Maay-Maay',
--'Lorma',
--'Kizigua (Kizigula)',
--'Kosraean',
--'Krio',
--'Kinyamulenge',
--'K’iche’ (Quiché)',
--'Hassaniya',
--'Fulde',
--'Dioula',
--'Choujo',
--'Cotocoli (Tem)',
--'Akateco'
--)



--delete Language where Id >= 51

select RIGHT('000'+CAST(a.Id AS VARCHAR(3)),3) as LanguageCode, a.EnglishName, * from [Language] a
where Available = 1 and a.Id not in (230, 235) and a.Id < 100000
order by a.EnglishName

Go

