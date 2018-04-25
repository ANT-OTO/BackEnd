declare @CountryTable Table
(
	CountryName nvarchar(256),
	CountryYName nvarchar(256),
	Abbr nvarchar(64),
	RegionCode int
)

insert into @CountryTable
(
	CountryName,
	CountryYName,
	Abbr,
	RegionCode
)
select a.CountryName, a.CountryYName, a.Abbr, a.RegionCode
from
(
 Select 'Angola' as CountryName, N'安哥拉' as CountryYName, 'AO' as Abbr, 244 as RegionCode
Union Select 'Afghanistan' as CountryName, N'阿富汗' as CountryYName, 'AF' as Abbr, 93 as RegionCode
Union Select 'Albania' as CountryName, N'阿尔巴尼亚' as CountryYName, 'AL' as Abbr, 355 as RegionCode
Union Select 'Algeria' as CountryName, N'阿尔及利亚' as CountryYName, 'DZ' as Abbr, 213 as RegionCode
Union Select 'Andorra' as CountryName, N'安道尔共和国' as CountryYName, 'AD' as Abbr, 376 as RegionCode
Union Select 'Anguilla' as CountryName, N'安圭拉岛' as CountryYName, 'AI' as Abbr, 1264 as RegionCode
Union Select 'Antigua and Barbuda' as CountryName, N'安提瓜和巴布达' as CountryYName, 'AG' as Abbr, 1268 as RegionCode
Union Select 'Argentina' as CountryName, N'阿根廷' as CountryYName, 'AR' as Abbr, 54 as RegionCode
Union Select 'Armenia' as CountryName, N'亚美尼亚' as CountryYName, 'AM' as Abbr, 374 as RegionCode
Union Select 'Ascension' as CountryName, N'阿森松' as CountryYName, '' as Abbr, 247 as RegionCode
Union Select 'Australia' as CountryName, N'澳大利亚' as CountryYName, 'AU' as Abbr, 61 as RegionCode
Union Select 'Austria' as CountryName, N'奥地利' as CountryYName, 'AT' as Abbr, 43 as RegionCode
Union Select 'Azerbaijan' as CountryName, N'阿塞拜疆' as CountryYName, 'AZ' as Abbr, 994 as RegionCode
Union Select 'Bahamas' as CountryName, N'巴哈马' as CountryYName, 'BS' as Abbr, 1242 as RegionCode
Union Select 'Bahrain' as CountryName, N'巴林' as CountryYName, 'BH' as Abbr, 973 as RegionCode
Union Select 'Bangladesh' as CountryName, N'孟加拉国' as CountryYName, 'BD' as Abbr, 880 as RegionCode
Union Select 'Barbados' as CountryName, N'巴巴多斯' as CountryYName, 'BB' as Abbr, 1246 as RegionCode
Union Select 'Belarus' as CountryName, N'白俄罗斯' as CountryYName, 'BY' as Abbr, 375 as RegionCode
Union Select 'Belgium' as CountryName, N'比利时' as CountryYName, 'BE' as Abbr, 32 as RegionCode
Union Select 'Belize' as CountryName, N'伯利兹' as CountryYName, 'BZ' as Abbr, 501 as RegionCode
Union Select 'Benin' as CountryName, N'贝宁' as CountryYName, 'BJ' as Abbr, 229 as RegionCode
Union Select 'BermudaIs.' as CountryName, N'百慕大群岛' as CountryYName, 'BM' as Abbr, 1441 as RegionCode
Union Select 'Bolivia' as CountryName, N'玻利维亚' as CountryYName, 'BO' as Abbr, 591 as RegionCode
Union Select 'Botswana' as CountryName, N'博茨瓦纳' as CountryYName, 'BW' as Abbr, 267 as RegionCode
Union Select 'Brazil' as CountryName, N'巴西' as CountryYName, 'BR' as Abbr, 55 as RegionCode
Union Select 'Brunei' as CountryName, N'文莱' as CountryYName, 'BN' as Abbr, 673 as RegionCode
Union Select 'Bulgaria' as CountryName, N'保加利亚' as CountryYName, 'BG' as Abbr, 359 as RegionCode
Union Select 'Burkina-faso' as CountryName, N'布基纳法索' as CountryYName, 'BF' as Abbr, 226 as RegionCode
Union Select 'Burma' as CountryName, N'缅甸' as CountryYName, 'MM' as Abbr, 95 as RegionCode
Union Select 'Burundi' as CountryName, N'布隆迪' as CountryYName, 'BI' as Abbr, 257 as RegionCode
Union Select 'Cameroon' as CountryName, N'喀麦隆' as CountryYName, 'CM' as Abbr, 237 as RegionCode
Union Select 'Canada' as CountryName, N'加拿大' as CountryYName, 'CA' as Abbr, 1 as RegionCode
Union Select 'Cayman Is.' as CountryName, N'开曼群岛' as CountryYName, '' as Abbr, 1345 as RegionCode
Union Select 'Central African Republic' as CountryName, N'中非共和国' as CountryYName, 'CF' as Abbr, 236 as RegionCode
Union Select 'Chad' as CountryName, N'乍得' as CountryYName, 'TD' as Abbr, 235 as RegionCode
Union Select 'Chile' as CountryName, N'智利' as CountryYName, 'CL' as Abbr, 56 as RegionCode
Union Select 'China' as CountryName, N'中国' as CountryYName, 'CN' as Abbr, 86 as RegionCode
Union Select 'Colombia' as CountryName, N'哥伦比亚' as CountryYName, 'CO' as Abbr, 57 as RegionCode
Union Select 'Congo' as CountryName, N'刚果' as CountryYName, 'CG' as Abbr, 242 as RegionCode
Union Select 'Cook Is.' as CountryName, N'库克群岛' as CountryYName, 'CK' as Abbr, 682 as RegionCode
Union Select 'Costa Rica' as CountryName, N'哥斯达黎加' as CountryYName, 'CR' as Abbr, 506 as RegionCode
Union Select 'Cuba' as CountryName, N'古巴' as CountryYName, 'CU' as Abbr, 53 as RegionCode
Union Select 'Cyprus' as CountryName, N'塞浦路斯' as CountryYName, 'CY' as Abbr, 357 as RegionCode
Union Select 'Czech Republic' as CountryName, N'捷克' as CountryYName, 'CZ' as Abbr, 420 as RegionCode
Union Select 'Denmark' as CountryName, N'丹麦' as CountryYName, 'DK' as Abbr, 45 as RegionCode
Union Select 'Djibouti' as CountryName, N'吉布提' as CountryYName, 'DJ' as Abbr, 253 as RegionCode
Union Select 'Dominica Rep.' as CountryName, N'多米尼加共和国' as CountryYName, 'DO' as Abbr, 1890 as RegionCode
Union Select 'Ecuador' as CountryName, N'厄瓜多尔' as CountryYName, 'EC' as Abbr, 593 as RegionCode
Union Select 'Egypt' as CountryName, N'埃及' as CountryYName, 'EG' as Abbr, 20 as RegionCode
Union Select 'EISalvador' as CountryName, N'萨尔瓦多' as CountryYName, 'SV' as Abbr, 503 as RegionCode
Union Select 'Estonia' as CountryName, N'爱沙尼亚' as CountryYName, 'EE' as Abbr, 372 as RegionCode
Union Select 'Ethiopia' as CountryName, N'埃塞俄比亚' as CountryYName, 'ET' as Abbr, 251 as RegionCode
Union Select 'Fiji' as CountryName, N'斐济' as CountryYName, 'FJ' as Abbr, 679 as RegionCode
Union Select 'Finland' as CountryName, N'芬兰' as CountryYName, 'FI' as Abbr, 358 as RegionCode
Union Select 'France' as CountryName, N'法国' as CountryYName, 'FR' as Abbr, 33 as RegionCode
Union Select 'French Guiana' as CountryName, N'法属圭亚那' as CountryYName, 'GF' as Abbr, 594 as RegionCode
Union Select 'Gabon' as CountryName, N'加蓬' as CountryYName, 'GA' as Abbr, 241 as RegionCode
Union Select 'Gambia' as CountryName, N'冈比亚' as CountryYName, 'GM' as Abbr, 220 as RegionCode
Union Select 'Georgia' as CountryName, N'格鲁吉亚' as CountryYName, 'GE' as Abbr, 995 as RegionCode
Union Select 'Germany' as CountryName, N'德国' as CountryYName, 'DE' as Abbr, 49 as RegionCode
Union Select 'Ghana' as CountryName, N'加纳' as CountryYName, 'GH' as Abbr, 233 as RegionCode
Union Select 'Gibraltar' as CountryName, N'直布罗陀' as CountryYName, 'GI' as Abbr, 350 as RegionCode
Union Select 'Greece' as CountryName, N'希腊' as CountryYName, 'GR' as Abbr, 30 as RegionCode
Union Select 'Grenada' as CountryName, N'格林纳达' as CountryYName, 'GD' as Abbr, 1809 as RegionCode
Union Select 'Guam' as CountryName, N'关岛' as CountryYName, 'GU' as Abbr, 1671 as RegionCode
Union Select 'Guatemala' as CountryName, N'危地马拉' as CountryYName, 'GT' as Abbr, 502 as RegionCode
Union Select 'Guinea' as CountryName, N'几内亚' as CountryYName, 'GN' as Abbr, 224 as RegionCode
Union Select 'Guyana' as CountryName, N'圭亚那' as CountryYName, 'GY' as Abbr, 592 as RegionCode
Union Select 'Haiti' as CountryName, N'海地' as CountryYName, 'HT' as Abbr, 509 as RegionCode
Union Select 'Honduras' as CountryName, N'洪都拉斯' as CountryYName, 'HN' as Abbr, 504 as RegionCode
Union Select 'Hongkong' as CountryName, N'香港' as CountryYName, 'HK' as Abbr, 852 as RegionCode
Union Select 'Hungary' as CountryName, N'匈牙利' as CountryYName, 'HU' as Abbr, 36 as RegionCode
Union Select 'Iceland' as CountryName, N'冰岛' as CountryYName, 'IS' as Abbr, 354 as RegionCode
Union Select 'India' as CountryName, N'印度' as CountryYName, 'IN' as Abbr, 91 as RegionCode
Union Select 'Indonesia' as CountryName, N'印度尼西亚' as CountryYName, 'ID' as Abbr, 62 as RegionCode
Union Select 'Iran' as CountryName, N'伊朗' as CountryYName, 'IR' as Abbr, 98 as RegionCode
Union Select 'Iraq' as CountryName, N'伊拉克' as CountryYName, 'IQ' as Abbr, 964 as RegionCode
Union Select 'Ireland' as CountryName, N'爱尔兰' as CountryYName, 'IE' as Abbr, 353 as RegionCode
Union Select 'Israel' as CountryName, N'以色列' as CountryYName, 'IL' as Abbr, 972 as RegionCode
Union Select 'Italy' as CountryName, N'意大利' as CountryYName, 'IT' as Abbr, 39 as RegionCode
Union Select 'IvoryCoast' as CountryName, N'科特迪瓦' as CountryYName, '' as Abbr, 225 as RegionCode
Union Select 'Jamaica' as CountryName, N'牙买加' as CountryYName, 'JM' as Abbr, 1876 as RegionCode
Union Select 'Japan' as CountryName, N'日本' as CountryYName, 'JP' as Abbr, 81 as RegionCode
Union Select 'Jordan' as CountryName, N'约旦' as CountryYName, 'JO' as Abbr, 962 as RegionCode
Union Select 'Kampuchea (Cambodia )' as CountryName, N'柬埔寨' as CountryYName, 'KH' as Abbr, 855 as RegionCode
Union Select 'Kazakstan' as CountryName, N'哈萨克斯坦' as CountryYName, 'KZ' as Abbr, 327 as RegionCode
Union Select 'Kenya' as CountryName, N'肯尼亚' as CountryYName, 'KE' as Abbr, 254 as RegionCode
Union Select 'Korea' as CountryName, N'韩国' as CountryYName, 'KR' as Abbr, 82 as RegionCode
Union Select 'Kuwait' as CountryName, N'科威特' as CountryYName, 'KW' as Abbr, 965 as RegionCode
Union Select 'Kyrgyzstan' as CountryName, N'吉尔吉斯坦' as CountryYName, 'KG' as Abbr, 331 as RegionCode
Union Select 'Laos' as CountryName, N'老挝' as CountryYName, 'LA' as Abbr, 856 as RegionCode
Union Select 'Latvia' as CountryName, N'拉脱维亚' as CountryYName, 'LV' as Abbr, 371 as RegionCode
Union Select 'Lebanon' as CountryName, N'黎巴嫩' as CountryYName, 'LB' as Abbr, 961 as RegionCode
Union Select 'Lesotho' as CountryName, N'莱索托' as CountryYName, 'LS' as Abbr, 266 as RegionCode
Union Select 'Liberia' as CountryName, N'利比里亚' as CountryYName, 'LR' as Abbr, 231 as RegionCode
Union Select 'Libya' as CountryName, N'利比亚' as CountryYName, 'LY' as Abbr, 218 as RegionCode
Union Select 'Liechtenstein' as CountryName, N'列支敦士登' as CountryYName, 'LI' as Abbr, 423 as RegionCode
Union Select 'Lithuania' as CountryName, N'立陶宛' as CountryYName, 'LT' as Abbr, 370 as RegionCode
Union Select 'Luxembourg' as CountryName, N'卢森堡' as CountryYName, 'LU' as Abbr, 352 as RegionCode
Union Select 'Macao' as CountryName, N'澳门' as CountryYName, 'MO' as Abbr, 853 as RegionCode
Union Select 'Madagascar' as CountryName, N'马达加斯加' as CountryYName, 'MG' as Abbr, 261 as RegionCode
Union Select 'Malawi' as CountryName, N'马拉维' as CountryYName, 'MW' as Abbr, 265 as RegionCode
Union Select 'Malaysia' as CountryName, N'马来西亚' as CountryYName, 'MY' as Abbr, 60 as RegionCode
Union Select 'Maldives' as CountryName, N'马尔代夫' as CountryYName, 'MV' as Abbr, 960 as RegionCode
Union Select 'Mali' as CountryName, N'马里' as CountryYName, 'ML' as Abbr, 223 as RegionCode
Union Select 'Malta' as CountryName, N'马耳他' as CountryYName, 'MT' as Abbr, 356 as RegionCode
Union Select 'Mariana Is' as CountryName, N'马里亚那群岛' as CountryYName, '' as Abbr, 1670 as RegionCode
Union Select 'Martinique' as CountryName, N'马提尼克' as CountryYName, '' as Abbr, 596 as RegionCode
Union Select 'Mauritius' as CountryName, N'毛里求斯' as CountryYName, 'MU' as Abbr, 230 as RegionCode
Union Select 'Mexico' as CountryName, N'墨西哥' as CountryYName, 'MX' as Abbr, 52 as RegionCode
Union Select 'Moldova, Republic of' as CountryName, N'摩尔多瓦' as CountryYName, 'MD' as Abbr, 373 as RegionCode
Union Select 'Monaco' as CountryName, N'摩纳哥' as CountryYName, 'MC' as Abbr, 377 as RegionCode
Union Select 'Mongolia' as CountryName, N'蒙古' as CountryYName, 'MN' as Abbr, 976 as RegionCode
Union Select 'Montserrat Is' as CountryName, N'蒙特塞拉特岛' as CountryYName, 'MS' as Abbr, 1664 as RegionCode
Union Select 'Morocco' as CountryName, N'摩洛哥' as CountryYName, 'MA' as Abbr, 212 as RegionCode
Union Select 'Mozambique' as CountryName, N'莫桑比克' as CountryYName, 'MZ' as Abbr, 258 as RegionCode
Union Select 'Namibia' as CountryName, N'纳米比亚' as CountryYName, 'NA' as Abbr, 264 as RegionCode
Union Select 'Nauru' as CountryName, N'瑙鲁' as CountryYName, 'NR' as Abbr, 674 as RegionCode
Union Select 'Nepal' as CountryName, N'尼泊尔' as CountryYName, 'NP' as Abbr, 977 as RegionCode
Union Select 'Netheriands Antilles' as CountryName, N'荷属安的列斯' as CountryYName, '' as Abbr, 599 as RegionCode
Union Select 'Netherlands' as CountryName, N'荷兰' as CountryYName, 'NL' as Abbr, 31 as RegionCode
Union Select 'NewZealand' as CountryName, N'新西兰' as CountryYName, 'NZ' as Abbr, 64 as RegionCode
Union Select 'Nicaragua' as CountryName, N'尼加拉瓜' as CountryYName, 'NI' as Abbr, 505 as RegionCode
Union Select 'Niger' as CountryName, N'尼日尔' as CountryYName, 'NE' as Abbr, 227 as RegionCode
Union Select 'Nigeria' as CountryName, N'尼日利亚' as CountryYName, 'NG' as Abbr, 234 as RegionCode
Union Select 'North Korea' as CountryName, N'朝鲜' as CountryYName, 'KP' as Abbr, 850 as RegionCode
Union Select 'Norway' as CountryName, N'挪威' as CountryYName, 'NO' as Abbr, 47 as RegionCode
Union Select 'Oman' as CountryName, N'阿曼' as CountryYName, 'OM' as Abbr, 968 as RegionCode
Union Select 'Pakistan' as CountryName, N'巴基斯坦' as CountryYName, 'PK' as Abbr, 92 as RegionCode
Union Select 'Panama' as CountryName, N'巴拿马' as CountryYName, 'PA' as Abbr, 507 as RegionCode
Union Select 'Papua New Cuinea' as CountryName, N'巴布亚新几内亚' as CountryYName, 'PG' as Abbr, 675 as RegionCode
Union Select 'Paraguay' as CountryName, N'巴拉圭' as CountryYName, 'PY' as Abbr, 595 as RegionCode
Union Select 'Peru' as CountryName, N'秘鲁' as CountryYName, 'PE' as Abbr, 51 as RegionCode
Union Select 'Philippines' as CountryName, N'菲律宾' as CountryYName, 'PH' as Abbr, 63 as RegionCode
Union Select 'Poland' as CountryName, N'波兰' as CountryYName, 'PL' as Abbr, 48 as RegionCode
Union Select 'French Polynesia' as CountryName, N'法属玻利尼西亚' as CountryYName, 'PF' as Abbr, 689 as RegionCode
Union Select 'Portugal' as CountryName, N'葡萄牙' as CountryYName, 'PT' as Abbr, 351 as RegionCode
Union Select 'PuertoRico' as CountryName, N'波多黎各' as CountryYName, 'PR' as Abbr, 1787 as RegionCode
Union Select 'Qatar' as CountryName, N'卡塔尔' as CountryYName, 'QA' as Abbr, 974 as RegionCode
Union Select 'Reunion' as CountryName, N'留尼旺' as CountryYName, '' as Abbr, 262 as RegionCode
Union Select 'Romania' as CountryName, N'罗马尼亚' as CountryYName, 'RO' as Abbr, 40 as RegionCode
Union Select 'Russia' as CountryName, N'俄罗斯' as CountryYName, 'RU' as Abbr, 7 as RegionCode
Union Select 'Saint Lueia' as CountryName, N'圣卢西亚' as CountryYName, 'LC' as Abbr, 1758 as RegionCode
Union Select 'Saint Vincent' as CountryName, N'圣文森特岛' as CountryYName, 'VC' as Abbr, 1784 as RegionCode
Union Select 'Samoa Eastern' as CountryName, N'东萨摩亚(美)' as CountryYName, '' as Abbr, 684 as RegionCode
Union Select 'Samoa Western' as CountryName, N'西萨摩亚' as CountryYName, '' as Abbr, 685 as RegionCode
Union Select 'San Marino' as CountryName, N'圣马力诺' as CountryYName, 'SM' as Abbr, 378 as RegionCode
Union Select 'Sao Tome and Principe' as CountryName, N'圣多美和普林西比' as CountryYName, 'ST' as Abbr, 239 as RegionCode
Union Select 'Saudi Arabia' as CountryName, N'沙特阿拉伯' as CountryYName, 'SA' as Abbr, 966 as RegionCode
Union Select 'Senegal' as CountryName, N'塞内加尔' as CountryYName, 'SN' as Abbr, 221 as RegionCode
Union Select 'Seychelles' as CountryName, N'塞舌尔' as CountryYName, 'SC' as Abbr, 248 as RegionCode
Union Select 'Sierra Leone' as CountryName, N'塞拉利昂' as CountryYName, 'SL' as Abbr, 232 as RegionCode
Union Select 'Singapore' as CountryName, N'新加坡' as CountryYName, 'SG' as Abbr, 65 as RegionCode
Union Select 'Slovakia' as CountryName, N'斯洛伐克' as CountryYName, 'SK' as Abbr, 421 as RegionCode
Union Select 'Slovenia' as CountryName, N'斯洛文尼亚' as CountryYName, 'SI' as Abbr, 386 as RegionCode
Union Select 'Solomon Is' as CountryName, N'所罗门群岛' as CountryYName, 'SB' as Abbr, 677 as RegionCode
Union Select 'Somali' as CountryName, N'索马里' as CountryYName, 'SO' as Abbr, 252 as RegionCode
Union Select 'South Africa' as CountryName, N'南非' as CountryYName, 'ZA' as Abbr, 27 as RegionCode
Union Select 'Spain' as CountryName, N'西班牙' as CountryYName, 'ES' as Abbr, 34 as RegionCode
Union Select 'Sri Lanka' as CountryName, N'斯里兰卡' as CountryYName, 'LK' as Abbr, 94 as RegionCode
Union Select 'St.Lucia' as CountryName, N'圣卢西亚' as CountryYName, 'LC' as Abbr, 1758 as RegionCode
Union Select 'St.Vincent' as CountryName, N'圣文森特' as CountryYName, 'VC' as Abbr, 1784 as RegionCode
Union Select 'Sudan' as CountryName, N'苏丹' as CountryYName, 'SD' as Abbr, 249 as RegionCode
Union Select 'Suriname' as CountryName, N'苏里南' as CountryYName, 'SR' as Abbr, 597 as RegionCode
Union Select 'Swaziland' as CountryName, N'斯威士兰' as CountryYName, 'SZ' as Abbr, 268 as RegionCode
Union Select 'Sweden' as CountryName, N'瑞典' as CountryYName, 'SE' as Abbr, 46 as RegionCode
Union Select 'Switzerland' as CountryName, N'瑞士' as CountryYName, 'CH' as Abbr, 41 as RegionCode
Union Select 'Syria' as CountryName, N'叙利亚' as CountryYName, 'SY' as Abbr, 963 as RegionCode
Union Select 'Taiwan' as CountryName, N'台湾省' as CountryYName, 'TW' as Abbr, 886 as RegionCode
Union Select 'Tajikstan' as CountryName, N'塔吉克斯坦' as CountryYName, 'TJ' as Abbr, 992 as RegionCode
Union Select 'Tanzania' as CountryName, N'坦桑尼亚' as CountryYName, 'TZ' as Abbr, 255 as RegionCode
Union Select 'Thailand' as CountryName, N'泰国' as CountryYName, 'TH' as Abbr, 66 as RegionCode
Union Select 'Togo' as CountryName, N'多哥' as CountryYName, 'TG' as Abbr, 228 as RegionCode
Union Select 'Tonga' as CountryName, N'汤加' as CountryYName, 'TO' as Abbr, 676 as RegionCode
Union Select 'Trinidad and Tobago' as CountryName, N'特立尼达和多巴哥' as CountryYName, 'TT' as Abbr, 1809 as RegionCode
Union Select 'Tunisia' as CountryName, N'突尼斯' as CountryYName, 'TN' as Abbr, 216 as RegionCode
Union Select 'Turkey' as CountryName, N'土耳其' as CountryYName, 'TR' as Abbr, 90 as RegionCode
Union Select 'Turkmenistan' as CountryName, N'土库曼斯坦' as CountryYName, 'TM' as Abbr, 993 as RegionCode
Union Select 'Uganda' as CountryName, N'乌干达' as CountryYName, 'UG' as Abbr, 256 as RegionCode
Union Select 'Ukraine' as CountryName, N'乌克兰' as CountryYName, 'UA' as Abbr, 380 as RegionCode
Union Select 'United Arab Emirates' as CountryName, N'阿拉伯联合酋长国' as CountryYName, 'AE' as Abbr, 971 as RegionCode
Union Select 'United Kiongdom' as CountryName, N'英国' as CountryYName, 'GB' as Abbr, 44 as RegionCode
Union Select 'United States of America' as CountryName, N'美国' as CountryYName, 'US' as Abbr, 1 as RegionCode
Union Select 'Uruguay' as CountryName, N'乌拉圭' as CountryYName, 'UY' as Abbr, 598 as RegionCode
Union Select 'Uzbekistan' as CountryName, N'乌兹别克斯坦' as CountryYName, 'UZ' as Abbr, 233 as RegionCode
Union Select 'Venezuela' as CountryName, N'委内瑞拉' as CountryYName, 'VE' as Abbr, 58 as RegionCode
Union Select 'Vietnam' as CountryName, N'越南' as CountryYName, 'VN' as Abbr, 84 as RegionCode
Union Select 'Yemen' as CountryName, N'也门' as CountryYName, 'YE' as Abbr, 967 as RegionCode
Union Select 'Yugoslavia' as CountryName, N'南斯拉夫' as CountryYName, 'YU' as Abbr, 381 as RegionCode
Union Select 'Zimbabwe' as CountryName, N'津巴布韦' as CountryYName, 'ZW' as Abbr, 263 as RegionCode
Union Select 'Zaire' as CountryName, N'扎伊尔' as CountryYName, 'ZR' as Abbr, 243 as RegionCode
Union Select 'Zambia' as CountryName, N'赞比亚' as CountryYName, 'ZM' as Abbr, 260 as RegionCode
) a

declare @pTime datetime = getutcdate()
insert into Country
(
	[CountryName],
	[ISOCode],
	[Abbreviation],
	[RegionCode], --Country Phone Number Prefix
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select	a.CountryName,
		'',
		a.Abbr,
		a.RegionCode,
		1,
		@pTime,
		@pTime,
		1,
		1
from @CountryTable a
	left join Country z (nolock) on a.CountryName = z.CountryName
where z.Id is null

update a
set a.Abbreviation = b.Abbr,
	a.RegionCode = b.RegionCode,
	a.LastUpdate = @pTime
from Country a
	inner join @CountryTable b on a.CountryName = b.CountryName
where a.Abbreviation <> b.Abbr
or a.RegionCode <> b.RegionCode


declare @pChineseSystemLanguageId int = 0
select @pChineseSystemLanguageId = a.Id 
from SystemLanguage a (nolock)
where a.EnglishName = 'Simplified Chinese'

if(@pChineseSystemLanguageId > 0)
begin
	insert into CountryY
	(
		[CountryId],
		[CountryYName],
		[SystemLanguageId],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select a.Id, b.CountryYName, @pChineseSystemLanguageId, 1, @pTime, @pTime, 1, 1
	from Country a 
		inner join @CountryTable b on a.CountryName = b.CountryName
		left join CountryY z (nolock) on a.Id = z.CountryId
	where z.Id is null

	update a
	set a.[CountryYName] = c.CountryYName,
		a.Available = 1
	from CountryY a
		inner join Country b (nolock) on a.CountryId = b.Id
		inner join @CountryTable c on b.CountryName = c.CountryName
	where a.[CountryYName] <> c.CountryYName

end

select * from Country a (nolock) inner join CountryY b (nolock) on a.Id = b.CountryId and b.SystemLanguageId = @pChineseSystemLanguageId







