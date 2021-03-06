
insert into [Region]
([RegionCode], [Name], [Abbreviation], Available)
select a.*
from (
	select distinct l.*
	from (

	select '93' as [RegionCode], 'Afghanistan' as [Name], 'AF' as [Abbreviation], 1 as Available
UNION

select '355' as [RegionCode], 'Albania' as [Name], 'AL' as [Abbreviation], 1 as Available
UNION

select '213' as [RegionCode], 'Algeria' as [Name], 'DZ' as [Abbreviation], 1 as Available
UNION

select '1684' as [RegionCode], 'American Samoa' as [Name], 'AS' as [Abbreviation], 1 as Available
UNION

select '376' as [RegionCode], 'Andorra' as [Name], 'AD' as [Abbreviation], 1 as Available
UNION

select '244' as [RegionCode], 'Angola' as [Name], 'AO' as [Abbreviation], 1 as Available
UNION

select '1264' as [RegionCode], 'Anguilla' as [Name], 'AI' as [Abbreviation], 1 as Available
UNION

select '672' as [RegionCode], 'Antarctica' as [Name], 'AQ' as [Abbreviation], 1 as Available
UNION

select '1268' as [RegionCode], 'Antigua and Barbuda' as [Name], 'AG' as [Abbreviation], 1 as Available
UNION

select '54' as [RegionCode], 'Argentina' as [Name], 'AR' as [Abbreviation], 1 as Available
UNION

select '374' as [RegionCode], 'Armenia' as [Name], 'AM' as [Abbreviation], 1 as Available
UNION

select '297' as [RegionCode], 'Aruba' as [Name], 'AW' as [Abbreviation], 1 as Available
UNION

select '61' as [RegionCode], 'Australia' as [Name], 'AU' as [Abbreviation], 1 as Available
UNION

select '43' as [RegionCode], 'Austria' as [Name], 'AT' as [Abbreviation], 1 as Available
UNION

select '994' as [RegionCode], 'Azerbaijan' as [Name], 'AZ' as [Abbreviation], 1 as Available
UNION

select '1242' as [RegionCode], 'Bahamas' as [Name], 'BS' as [Abbreviation], 1 as Available
UNION

select '973' as [RegionCode], 'Bahrain' as [Name], 'BH' as [Abbreviation], 1 as Available
UNION

select '880' as [RegionCode], 'Bangladesh' as [Name], 'BD' as [Abbreviation], 1 as Available
UNION

select '1246' as [RegionCode], 'Barbados' as [Name], 'BB' as [Abbreviation], 1 as Available
UNION

select '375' as [RegionCode], 'Belarus' as [Name], 'BY' as [Abbreviation], 1 as Available
UNION

select '32' as [RegionCode], 'Belgium' as [Name], 'BE' as [Abbreviation], 1 as Available
UNION

select '501' as [RegionCode], 'Belize' as [Name], 'BZ' as [Abbreviation], 1 as Available
UNION

select '229' as [RegionCode], 'Benin' as [Name], 'BJ' as [Abbreviation], 1 as Available
UNION

select '1441' as [RegionCode], 'Bermuda' as [Name], 'BM' as [Abbreviation], 1 as Available
UNION

select '975' as [RegionCode], 'Bhutan' as [Name], 'BT' as [Abbreviation], 1 as Available
UNION

select '591' as [RegionCode], 'Bolivia' as [Name], 'BO' as [Abbreviation], 1 as Available
UNION

select '387' as [RegionCode], 'Bosnia and Herzegovina' as [Name], 'BA' as [Abbreviation], 1 as Available
UNION

select '267' as [RegionCode], 'Botswana' as [Name], 'BW' as [Abbreviation], 1 as Available
UNION

select '55' as [RegionCode], 'Brazil' as [Name], 'BR' as [Abbreviation], 1 as Available
UNION

select '1284' as [RegionCode], 'British Virgin Islands' as [Name], 'VG' as [Abbreviation], 1 as Available
UNION

select '673' as [RegionCode], 'Brunei' as [Name], 'BN' as [Abbreviation], 1 as Available
UNION

select '359' as [RegionCode], 'Bulgaria' as [Name], 'BG' as [Abbreviation], 1 as Available
UNION

select '226' as [RegionCode], 'Burkina Faso' as [Name], 'BF' as [Abbreviation], 1 as Available
UNION

select '95' as [RegionCode], 'Burma (Myanmar)' as [Name], 'MM' as [Abbreviation], 1 as Available
UNION

select '257' as [RegionCode], 'Burundi' as [Name], 'BI' as [Abbreviation], 1 as Available
UNION

select '855' as [RegionCode], 'Cambodia' as [Name], 'KH' as [Abbreviation], 1 as Available
UNION

select '237' as [RegionCode], 'Cameroon' as [Name], 'CM' as [Abbreviation], 1 as Available
UNION

select '1' as [RegionCode], 'Canada' as [Name], 'CA' as [Abbreviation], 1 as Available
UNION

select '238' as [RegionCode], 'Cape Verde' as [Name], 'CV' as [Abbreviation], 1 as Available
UNION

select '1345' as [RegionCode], 'Cayman Islands' as [Name], 'KY' as [Abbreviation], 1 as Available
UNION

select '236' as [RegionCode], 'Central African Republic' as [Name], 'CF' as [Abbreviation], 1 as Available
UNION

select '235' as [RegionCode], 'Chad' as [Name], 'TD' as [Abbreviation], 1 as Available
UNION

select '56' as [RegionCode], 'Chile' as [Name], 'CL' as [Abbreviation], 1 as Available
UNION

select '86' as [RegionCode], 'China' as [Name], 'CN' as [Abbreviation], 1 as Available
UNION

select '61' as [RegionCode], 'Christmas Island' as [Name], 'CX' as [Abbreviation], 1 as Available
UNION

select '61' as [RegionCode], 'Cocos (Keeling) Islands' as [Name], 'CC' as [Abbreviation], 1 as Available
UNION

select '57' as [RegionCode], 'Colombia' as [Name], 'CO' as [Abbreviation], 1 as Available
UNION

select '269' as [RegionCode], 'Comoros' as [Name], 'KM' as [Abbreviation], 1 as Available
UNION

select '682' as [RegionCode], 'Cook Islands' as [Name], 'CK' as [Abbreviation], 1 as Available
UNION

select '506' as [RegionCode], 'Costa Rica' as [Name], 'CR' as [Abbreviation], 1 as Available
UNION

select '385' as [RegionCode], 'Croatia' as [Name], 'HR' as [Abbreviation], 1 as Available
UNION

select '53' as [RegionCode], 'Cuba' as [Name], 'CU' as [Abbreviation], 1 as Available
UNION

select '357' as [RegionCode], 'Cyprus' as [Name], 'CY' as [Abbreviation], 1 as Available
UNION

select '420' as [RegionCode], 'Czech Republic' as [Name], 'CZ' as [Abbreviation], 1 as Available
UNION

select '243' as [RegionCode], 'Democratic Republic of the Congo' as [Name], 'CD' as [Abbreviation], 1 as Available
UNION

select '45' as [RegionCode], 'Denmark' as [Name], 'DK' as [Abbreviation], 1 as Available
UNION

select '253' as [RegionCode], 'Djibouti' as [Name], 'DJ' as [Abbreviation], 1 as Available
UNION

select '1767' as [RegionCode], 'Dominica' as [Name], 'DM' as [Abbreviation], 1 as Available
UNION

select '1809' as [RegionCode], 'Dominican Republic' as [Name], 'DO' as [Abbreviation], 1 as Available
UNION

select '593' as [RegionCode], 'Ecuador' as [Name], 'EC' as [Abbreviation], 1 as Available
UNION

select '20' as [RegionCode], 'Egypt' as [Name], 'EG' as [Abbreviation], 1 as Available
UNION

select '503' as [RegionCode], 'El Salvador' as [Name], 'SV' as [Abbreviation], 1 as Available
UNION

select '240' as [RegionCode], 'Equatorial Guinea' as [Name], 'GQ' as [Abbreviation], 1 as Available
UNION

select '291' as [RegionCode], 'Eritrea' as [Name], 'ER' as [Abbreviation], 1 as Available
UNION

select '372' as [RegionCode], 'Estonia' as [Name], 'EE' as [Abbreviation], 1 as Available
UNION

select '251' as [RegionCode], 'Ethiopia' as [Name], 'ET' as [Abbreviation], 1 as Available
UNION

select '500' as [RegionCode], 'Falkland Islands' as [Name], 'FK' as [Abbreviation], 1 as Available
UNION

select '298' as [RegionCode], 'Faroe Islands' as [Name], 'FO' as [Abbreviation], 1 as Available
UNION

select '679' as [RegionCode], 'Fiji' as [Name], 'FJ' as [Abbreviation], 1 as Available
UNION

select '358' as [RegionCode], 'Finland' as [Name], 'FI' as [Abbreviation], 1 as Available
UNION

select '33' as [RegionCode], 'France' as [Name], 'FR' as [Abbreviation], 1 as Available
UNION

select '689' as [RegionCode], 'French Polynesia' as [Name], 'PF' as [Abbreviation], 1 as Available
UNION

select '241' as [RegionCode], 'Gabon' as [Name], 'GA' as [Abbreviation], 1 as Available
UNION

select '220' as [RegionCode], 'Gambia' as [Name], 'GM' as [Abbreviation], 1 as Available
UNION

select '970' as [RegionCode], 'Gaza Strip' as [Name], 'GZ' as [Abbreviation], 1 as Available
UNION

select '995' as [RegionCode], 'Georgia' as [Name], 'GE' as [Abbreviation], 1 as Available
UNION

select '49' as [RegionCode], 'Germany' as [Name], 'DE' as [Abbreviation], 1 as Available
UNION

select '233' as [RegionCode], 'Ghana' as [Name], 'GH' as [Abbreviation], 1 as Available
UNION

select '350' as [RegionCode], 'Gibraltar' as [Name], 'GI' as [Abbreviation], 1 as Available
UNION

select '30' as [RegionCode], 'Greece' as [Name], 'GR' as [Abbreviation], 1 as Available
UNION

select '299' as [RegionCode], 'Greenland' as [Name], 'GL' as [Abbreviation], 1 as Available
UNION

select '1473' as [RegionCode], 'Grenada' as [Name], 'GD' as [Abbreviation], 1 as Available
UNION

select '1671' as [RegionCode], 'Guam' as [Name], 'GU' as [Abbreviation], 1 as Available
UNION

select '502' as [RegionCode], 'Guatemala' as [Name], 'GT' as [Abbreviation], 1 as Available
UNION

select '224' as [RegionCode], 'Guinea' as [Name], 'GN' as [Abbreviation], 1 as Available
UNION

select '245' as [RegionCode], 'Guinea-Bissau' as [Name], 'GW' as [Abbreviation], 1 as Available
UNION

select '592' as [RegionCode], 'Guyana' as [Name], 'GY' as [Abbreviation], 1 as Available
UNION

select '509' as [RegionCode], 'Haiti' as [Name], 'HT' as [Abbreviation], 1 as Available
UNION

select '39' as [RegionCode], 'Holy See (Vatican City)' as [Name], 'VA' as [Abbreviation], 1 as Available
UNION

select '504' as [RegionCode], 'Honduras' as [Name], 'HN' as [Abbreviation], 1 as Available
UNION

select '852' as [RegionCode], 'Hong Kong' as [Name], 'HK' as [Abbreviation], 1 as Available
UNION

select '36' as [RegionCode], 'Hungary' as [Name], 'HU' as [Abbreviation], 1 as Available
UNION

select '354' as [RegionCode], 'Iceland' as [Name], 'IS' as [Abbreviation], 1 as Available
UNION

select '91' as [RegionCode], 'India' as [Name], 'IN' as [Abbreviation], 1 as Available
UNION

select '62' as [RegionCode], 'Indonesia' as [Name], 'ID' as [Abbreviation], 1 as Available
UNION

select '98' as [RegionCode], 'Iran' as [Name], 'IR' as [Abbreviation], 1 as Available
UNION

select '964' as [RegionCode], 'Iraq' as [Name], 'IQ' as [Abbreviation], 1 as Available
UNION

select '353' as [RegionCode], 'Ireland' as [Name], 'IE' as [Abbreviation], 1 as Available
UNION

select '44' as [RegionCode], 'Isle of Man' as [Name], 'IM' as [Abbreviation], 1 as Available
UNION

select '972' as [RegionCode], 'Israel' as [Name], 'IL' as [Abbreviation], 1 as Available
UNION

select '39' as [RegionCode], 'Italy' as [Name], 'IT' as [Abbreviation], 1 as Available
UNION

select '225' as [RegionCode], 'Ivory Coast' as [Name], 'CI' as [Abbreviation], 1 as Available
UNION

select '1876' as [RegionCode], 'Jamaica' as [Name], 'JM' as [Abbreviation], 1 as Available
UNION

select '81' as [RegionCode], 'Japan' as [Name], 'JP' as [Abbreviation], 1 as Available
UNION

select '962' as [RegionCode], 'Jordan' as [Name], 'JO' as [Abbreviation], 1 as Available
UNION

select '7' as [RegionCode], 'Kazakhstan' as [Name], 'KZ' as [Abbreviation], 1 as Available
UNION

select '254' as [RegionCode], 'Kenya' as [Name], 'KE' as [Abbreviation], 1 as Available
UNION

select '686' as [RegionCode], 'Kiribati' as [Name], 'KI' as [Abbreviation], 1 as Available
UNION

select '381' as [RegionCode], 'Kosovo' as [Name], 'KV' as [Abbreviation], 1 as Available
UNION

select '965' as [RegionCode], 'Kuwait' as [Name], 'KW' as [Abbreviation], 1 as Available
UNION

select '996' as [RegionCode], 'Kyrgyzstan' as [Name], 'KG' as [Abbreviation], 1 as Available
UNION

select '856' as [RegionCode], 'Laos' as [Name], 'LA' as [Abbreviation], 1 as Available
UNION

select '371' as [RegionCode], 'Latvia' as [Name], 'LV' as [Abbreviation], 1 as Available
UNION

select '961' as [RegionCode], 'Lebanon' as [Name], 'LB' as [Abbreviation], 1 as Available
UNION

select '266' as [RegionCode], 'Lesotho' as [Name], 'LS' as [Abbreviation], 1 as Available
UNION

select '231' as [RegionCode], 'Liberia' as [Name], 'LR' as [Abbreviation], 1 as Available
UNION

select '218' as [RegionCode], 'Libya' as [Name], 'LY' as [Abbreviation], 1 as Available
UNION

select '423' as [RegionCode], 'Liechtenstein' as [Name], 'LI' as [Abbreviation], 1 as Available
UNION

select '370' as [RegionCode], 'Lithuania' as [Name], 'LT' as [Abbreviation], 1 as Available
UNION

select '352' as [RegionCode], 'Luxembourg' as [Name], 'LU' as [Abbreviation], 1 as Available
UNION

select '853' as [RegionCode], 'Macau' as [Name], 'MO' as [Abbreviation], 1 as Available
UNION

select '389' as [RegionCode], 'Macedonia' as [Name], 'MK' as [Abbreviation], 1 as Available
UNION

select '261' as [RegionCode], 'Madagascar' as [Name], 'MG' as [Abbreviation], 1 as Available
UNION

select '265' as [RegionCode], 'Malawi' as [Name], 'MW' as [Abbreviation], 1 as Available
UNION

select '60' as [RegionCode], 'Malaysia' as [Name], 'MY' as [Abbreviation], 1 as Available
UNION

select '960' as [RegionCode], 'Maldives' as [Name], 'MV' as [Abbreviation], 1 as Available
UNION

select '223' as [RegionCode], 'Mali' as [Name], 'ML' as [Abbreviation], 1 as Available
UNION

select '356' as [RegionCode], 'Malta' as [Name], 'MT' as [Abbreviation], 1 as Available
UNION

select '692' as [RegionCode], 'Marshall Islands' as [Name], 'MH' as [Abbreviation], 1 as Available
UNION

select '222' as [RegionCode], 'Mauritania' as [Name], 'MR' as [Abbreviation], 1 as Available
UNION

select '230' as [RegionCode], 'Mauritius' as [Name], 'MU' as [Abbreviation], 1 as Available
UNION

select '262' as [RegionCode], 'Mayotte' as [Name], 'YT' as [Abbreviation], 1 as Available
UNION

select '52' as [RegionCode], 'Mexico' as [Name], 'MX' as [Abbreviation], 1 as Available
UNION

select '691' as [RegionCode], 'Micronesia' as [Name], 'FM' as [Abbreviation], 1 as Available
UNION

select '373' as [RegionCode], 'Moldova' as [Name], 'MD' as [Abbreviation], 1 as Available
UNION

select '377' as [RegionCode], 'Monaco' as [Name], 'MC' as [Abbreviation], 1 as Available
UNION

select '976' as [RegionCode], 'Mongolia' as [Name], 'MN' as [Abbreviation], 1 as Available
UNION

select '382' as [RegionCode], 'Montenegro' as [Name], 'ME' as [Abbreviation], 1 as Available
UNION

select '1664' as [RegionCode], 'Montserrat' as [Name], 'MS' as [Abbreviation], 1 as Available
UNION

select '212' as [RegionCode], 'Morocco' as [Name], 'MA' as [Abbreviation], 1 as Available
UNION

select '258' as [RegionCode], 'Mozambique' as [Name], 'MZ' as [Abbreviation], 1 as Available
UNION

select '264' as [RegionCode], 'Namibia' as [Name], 'NA' as [Abbreviation], 1 as Available
UNION

select '674' as [RegionCode], 'Nauru' as [Name], 'NR' as [Abbreviation], 1 as Available
UNION

select '977' as [RegionCode], 'Nepal' as [Name], 'NP' as [Abbreviation], 1 as Available
UNION

select '31' as [RegionCode], 'Netherlands' as [Name], 'NL' as [Abbreviation], 1 as Available
UNION

select '599' as [RegionCode], 'Netherlands Antilles' as [Name], 'AN' as [Abbreviation], 1 as Available
UNION

select '687' as [RegionCode], 'New Caledonia' as [Name], 'NC' as [Abbreviation], 1 as Available
UNION

select '64' as [RegionCode], 'New Zealand' as [Name], 'NZ' as [Abbreviation], 1 as Available
UNION

select '505' as [RegionCode], 'Nicaragua' as [Name], 'NI' as [Abbreviation], 1 as Available
UNION

select '227' as [RegionCode], 'Niger' as [Name], 'NE' as [Abbreviation], 1 as Available
UNION

select '234' as [RegionCode], 'Nigeria' as [Name], 'NG' as [Abbreviation], 1 as Available
UNION

select '683' as [RegionCode], 'Niue' as [Name], 'NU' as [Abbreviation], 1 as Available
UNION

select '672' as [RegionCode], 'Norfolk Island' as [Name], 'NF' as [Abbreviation], 1 as Available
UNION

select '850' as [RegionCode], 'North Korea' as [Name], 'KP' as [Abbreviation], 1 as Available
UNION

select '1670' as [RegionCode], 'Northern Mariana Islands' as [Name], 'MP' as [Abbreviation], 1 as Available
UNION

select '47' as [RegionCode], 'Norway' as [Name], 'NO' as [Abbreviation], 1 as Available
UNION

select '968' as [RegionCode], 'Oman' as [Name], 'OM' as [Abbreviation], 1 as Available
UNION

select '92' as [RegionCode], 'Pakistan' as [Name], 'PK' as [Abbreviation], 1 as Available
UNION

select '680' as [RegionCode], 'Palau' as [Name], 'PW' as [Abbreviation], 1 as Available
UNION

select '507' as [RegionCode], 'Panama' as [Name], 'PA' as [Abbreviation], 1 as Available
UNION

select '675' as [RegionCode], 'Papua New Guinea' as [Name], 'PG' as [Abbreviation], 1 as Available
UNION

select '595' as [RegionCode], 'Paraguay' as [Name], 'PY' as [Abbreviation], 1 as Available
UNION

select '51' as [RegionCode], 'Peru' as [Name], 'PE' as [Abbreviation], 1 as Available
UNION

select '63' as [RegionCode], 'Philippines' as [Name], 'PH' as [Abbreviation], 1 as Available
UNION

select '870' as [RegionCode], 'Pitcairn Islands' as [Name], 'PN' as [Abbreviation], 1 as Available
UNION

select '48' as [RegionCode], 'Poland' as [Name], 'PL' as [Abbreviation], 1 as Available
UNION

select '351' as [RegionCode], 'Portugal' as [Name], 'PT' as [Abbreviation], 1 as Available
UNION

select '1' as [RegionCode], 'Puerto Rico' as [Name], 'PR' as [Abbreviation], 1 as Available
UNION

select '974' as [RegionCode], 'Qatar' as [Name], 'QA' as [Abbreviation], 1 as Available
UNION

select '242' as [RegionCode], 'Republic of the Congo' as [Name], 'CG' as [Abbreviation], 1 as Available
UNION

select '40' as [RegionCode], 'Romania' as [Name], 'RO' as [Abbreviation], 1 as Available
UNION

select '7' as [RegionCode], 'Russia' as [Name], 'RU' as [Abbreviation], 1 as Available
UNION

select '250' as [RegionCode], 'Rwanda' as [Name], 'RW' as [Abbreviation], 1 as Available
UNION

select '590' as [RegionCode], 'Saint Barthelemy' as [Name], 'BL' as [Abbreviation], 1 as Available
UNION

select '290' as [RegionCode], 'Saint Helena' as [Name], 'SH' as [Abbreviation], 1 as Available
UNION

select '1869' as [RegionCode], 'Saint Kitts and Nevis' as [Name], 'KN' as [Abbreviation], 1 as Available
UNION

select '1758' as [RegionCode], 'Saint Lucia' as [Name], 'LC' as [Abbreviation], 1 as Available
UNION

select '1599' as [RegionCode], 'Saint Martin' as [Name], 'MF' as [Abbreviation], 1 as Available
UNION

select '508' as [RegionCode], 'Saint Pierre and Miquelon' as [Name], 'PM' as [Abbreviation], 1 as Available
UNION

select '1784' as [RegionCode], 'Saint Vincent and the Grenadines' as [Name], 'VC' as [Abbreviation], 1 as Available
UNION

select '685' as [RegionCode], 'Samoa' as [Name], 'WS' as [Abbreviation], 1 as Available
UNION

select '378' as [RegionCode], 'San Marino' as [Name], 'SM' as [Abbreviation], 1 as Available
UNION

select '239' as [RegionCode], 'Sao Tome and Principe' as [Name], 'ST' as [Abbreviation], 1 as Available
UNION

select '966' as [RegionCode], 'Saudi Arabia' as [Name], 'SA' as [Abbreviation], 1 as Available
UNION

select '221' as [RegionCode], 'Senegal' as [Name], 'SN' as [Abbreviation], 1 as Available
UNION

select '381' as [RegionCode], 'Serbia' as [Name], 'RS' as [Abbreviation], 1 as Available
UNION

select '248' as [RegionCode], 'Seychelles' as [Name], 'SC' as [Abbreviation], 1 as Available
UNION

select '232' as [RegionCode], 'Sierra Leone' as [Name], 'SL' as [Abbreviation], 1 as Available
UNION

select '65' as [RegionCode], 'Singapore' as [Name], 'SG' as [Abbreviation], 1 as Available
UNION

select '421' as [RegionCode], 'Slovakia' as [Name], 'SK' as [Abbreviation], 1 as Available
UNION

select '386' as [RegionCode], 'Slovenia' as [Name], 'SI' as [Abbreviation], 1 as Available
UNION

select '677' as [RegionCode], 'Solomon Islands' as [Name], 'SB' as [Abbreviation], 1 as Available
UNION

select '252' as [RegionCode], 'Somalia' as [Name], 'SO' as [Abbreviation], 1 as Available
UNION

select '27' as [RegionCode], 'South Africa' as [Name], 'ZA' as [Abbreviation], 1 as Available
UNION

select '82' as [RegionCode], 'South Korea' as [Name], 'KR' as [Abbreviation], 1 as Available
UNION

select '34' as [RegionCode], 'Spain' as [Name], 'ES' as [Abbreviation], 1 as Available
UNION

select '94' as [RegionCode], 'Sri Lanka' as [Name], 'LK' as [Abbreviation], 1 as Available
UNION

select '249' as [RegionCode], 'Sudan' as [Name], 'SD' as [Abbreviation], 1 as Available
UNION

select '597' as [RegionCode], 'Suriname' as [Name], 'SR' as [Abbreviation], 1 as Available
UNION

select '268' as [RegionCode], 'Swaziland' as [Name], 'SZ' as [Abbreviation], 1 as Available
UNION

select '46' as [RegionCode], 'Sweden' as [Name], 'SE' as [Abbreviation], 1 as Available
UNION

select '41' as [RegionCode], 'Switzerland' as [Name], 'CH' as [Abbreviation], 1 as Available
UNION

select '963' as [RegionCode], 'Syria' as [Name], 'SY' as [Abbreviation], 1 as Available
UNION

select '886' as [RegionCode], 'Taiwan' as [Name], 'TW' as [Abbreviation], 1 as Available
UNION

select '992' as [RegionCode], 'Tajikistan' as [Name], 'TJ' as [Abbreviation], 1 as Available
UNION

select '255' as [RegionCode], 'Tanzania' as [Name], 'TZ' as [Abbreviation], 1 as Available
UNION

select '66' as [RegionCode], 'Thailand' as [Name], 'TH' as [Abbreviation], 1 as Available
UNION

select '670' as [RegionCode], 'Timor-Leste' as [Name], 'TL' as [Abbreviation], 1 as Available
UNION

select '228' as [RegionCode], 'Togo' as [Name], 'TG' as [Abbreviation], 1 as Available
UNION

select '690' as [RegionCode], 'Tokelau' as [Name], 'TK' as [Abbreviation], 1 as Available
UNION

select '676' as [RegionCode], 'Tonga' as [Name], 'TO' as [Abbreviation], 1 as Available
UNION

select '1868' as [RegionCode], 'Trinidad and Tobago' as [Name], 'TT' as [Abbreviation], 1 as Available
UNION

select '216' as [RegionCode], 'Tunisia' as [Name], 'TN' as [Abbreviation], 1 as Available
UNION

select '90' as [RegionCode], 'Turkey' as [Name], 'TR' as [Abbreviation], 1 as Available
UNION

select '993' as [RegionCode], 'Turkmenistan' as [Name], 'TM' as [Abbreviation], 1 as Available
UNION

select '1649' as [RegionCode], 'Turks and Caicos Islands' as [Name], 'TC' as [Abbreviation], 1 as Available
UNION

select '688' as [RegionCode], 'Tuvalu' as [Name], 'TV' as [Abbreviation], 1 as Available
UNION

select '256' as [RegionCode], 'Uganda' as [Name], 'UG' as [Abbreviation], 1 as Available
UNION

select '380' as [RegionCode], 'Ukraine' as [Name], 'UA' as [Abbreviation], 1 as Available
UNION

select '971' as [RegionCode], 'United Arab Emirates' as [Name], 'AE' as [Abbreviation], 1 as Available
UNION

select '44' as [RegionCode], 'United Kingdom' as [Name], 'GB' as [Abbreviation], 1 as Available
UNION

select '1' as [RegionCode], 'United States' as [Name], 'US' as [Abbreviation], 1 as Available
UNION

select '598' as [RegionCode], 'Uruguay' as [Name], 'UY' as [Abbreviation], 1 as Available
UNION

select '1340' as [RegionCode], 'US Virgin Islands' as [Name], 'VI' as [Abbreviation], 1 as Available
UNION

select '998' as [RegionCode], 'Uzbekistan' as [Name], 'UZ' as [Abbreviation], 1 as Available
UNION

select '678' as [RegionCode], 'Vanuatu' as [Name], 'VU' as [Abbreviation], 1 as Available
UNION

select '58' as [RegionCode], 'Venezuela' as [Name], 'VE' as [Abbreviation], 1 as Available
UNION

select '84' as [RegionCode], 'Vietnam' as [Name], 'VN' as [Abbreviation], 1 as Available
UNION

select '681' as [RegionCode], 'Wallis and Futuna' as [Name], 'WF' as [Abbreviation], 1 as Available
UNION

select '970' as [RegionCode], 'West Bank' as [Name], 'WE' as [Abbreviation], 1 as Available
UNION

select '967' as [RegionCode], 'Yemen' as [Name], 'YE' as [Abbreviation], 1 as Available
UNION

select '260' as [RegionCode], 'Zambia' as [Name], 'ZM' as [Abbreviation], 1 as Available
UNION

select '263' as [RegionCode], 'Zimbabwe' as [Name], 'ZW' as [Abbreviation], 1 as Available

	) l
	
) a left join  [Region] z on a.[Name] = z.[Name] or a.RegionCode = z.RegionCode
where z.Id is null
order by a.[Name]


select * from [Region]
