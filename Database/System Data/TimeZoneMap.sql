/*
select 'insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select ' + convert(varchar, a.DeviceTypeCodeId) + ', ''' + replace(a.TimeZoneId, '''', '''''') + ''', ''' 
	+ replace(a.TimeZoneName, '''', '''''') + ''', ''' 
	+ replace(a.TimeZoneAbbr, '''', '''''') + ''', ' 
	+ convert(varchar, a.UTCOffset) + ', ' 
	+ convert(varchar, a.SupportDST) + ',''' 
	+ replace(a.NetTimeZoneId, '''', '''''') + ''', GETDATE()
'
from TimeZoneMap a where DeviceTypeCodeId = 0
*/

--truncate table TimeZoneMap
--delete TimeZoneMap where DeviceTypeCodeId = 0
insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Dateline Standard Time', '(UTC-12:00) International Date Line West', 'Dateline Standard Time', -12.000, 0,'Dateline Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'UTC-11', '(UTC-11:00) Coordinated Universal Time-11', 'UTC-11', -11.000, 0,'UTC-11', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Hawaiian Standard Time', '(UTC-10:00) Hawaii', 'Hawaiian Standard Time', -10.000, 0,'Hawaiian Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Alaskan Standard Time', '(UTC-09:00) Alaska', 'Alaskan Standard Time', -9.000, 1,'Alaskan Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Pacific Standard Time (Mexico)', '(UTC-08:00) Baja California', 'Pacific Standard Time (Mexico)', -8.000, 1,'Pacific Standard Time (Mexico)', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Pacific Standard Time', '(UTC-08:00) Pacific Time (US & Canada)', 'Pacific Standard Time', -8.000, 1,'Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'US Mountain Standard Time', '(UTC-07:00) Arizona', 'US Mountain Standard Time', -7.000, 0,'US Mountain Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Mountain Standard Time (Mexico)', '(UTC-07:00) Chihuahua, La Paz, Mazatlan', 'Mountain Standard Time (Mexico)', -7.000, 1,'Mountain Standard Time (Mexico)', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Mountain Standard Time', '(UTC-07:00) Mountain Time (US & Canada)', 'Mountain Standard Time', -7.000, 1,'Mountain Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Central America Standard Time', '(UTC-06:00) Central America', 'Central America Standard Time', -6.000, 0,'Central America Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Central Standard Time', '(UTC-06:00) Central Time (US & Canada)', 'Central Standard Time', -6.000, 1,'Central Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Central Standard Time (Mexico)', '(UTC-06:00) Guadalajara, Mexico City, Monterrey', 'Central Standard Time (Mexico)', -6.000, 1,'Central Standard Time (Mexico)', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Canada Central Standard Time', '(UTC-06:00) Saskatchewan', 'Canada Central Standard Time', -6.000, 0,'Canada Central Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'SA Pacific Standard Time', '(UTC-05:00) Bogota, Lima, Quito', 'SA Pacific Standard Time', -5.000, 0,'SA Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Eastern Standard Time', '(UTC-05:00) Eastern Time (US & Canada)', 'Eastern Standard Time', -5.000, 1,'Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'US Eastern Standard Time', '(UTC-05:00) Indiana (East)', 'US Eastern Standard Time', -5.000, 1,'US Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Venezuela Standard Time', '(UTC-04:30) Caracas', 'Venezuela Standard Time', -4.500, 0,'Venezuela Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Paraguay Standard Time', '(UTC-04:00) Asuncion', 'Paraguay Standard Time', -4.000, 1,'Paraguay Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Atlantic Standard Time', '(UTC-04:00) Atlantic Time (Canada)', 'Atlantic Standard Time', -4.000, 1,'Atlantic Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Central Brazilian Standard Time', '(UTC-04:00) Cuiaba', 'Central Brazilian Standard Time', -4.000, 1,'Central Brazilian Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'SA Western Standard Time', '(UTC-04:00) Georgetown, La Paz, Manaus, San Juan', 'SA Western Standard Time', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Pacific SA Standard Time', '(UTC-04:00) Santiago', 'Pacific SA Standard Time', -4.000, 1,'Pacific SA Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Newfoundland Standard Time', '(UTC-03:30) Newfoundland', 'Newfoundland Standard Time', -3.500, 1,'Newfoundland Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'E. South America Standard Time', '(UTC-03:00) Brasilia', 'E. South America Standard Time', -3.000, 1,'E. South America Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Argentina Standard Time', '(UTC-03:00) Buenos Aires', 'Argentina Standard Time', -3.000, 1,'Argentina Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'SA Eastern Standard Time', '(UTC-03:00) Cayenne, Fortaleza', 'SA Eastern Standard Time', -3.000, 0,'SA Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Greenland Standard Time', '(UTC-03:00) Greenland', 'Greenland Standard Time', -3.000, 1,'Greenland Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Montevideo Standard Time', '(UTC-03:00) Montevideo', 'Montevideo Standard Time', -3.000, 1,'Montevideo Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Bahia Standard Time', '(UTC-03:00) Salvador', 'Bahia Standard Time', -3.000, 1,'Bahia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'UTC-02', '(UTC-02:00) Coordinated Universal Time-02', 'UTC-02', -2.000, 0,'UTC-02', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Mid-Atlantic Standard Time', '(UTC-02:00) Mid-Atlantic - Old', 'Mid-Atlantic Standard Time', -2.000, 1,'Mid-Atlantic Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Azores Standard Time', '(UTC-01:00) Azores', 'Azores Standard Time', -1.000, 1,'Azores Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Cape Verde Standard Time', '(UTC-01:00) Cape Verde Is.', 'Cape Verde Standard Time', -1.000, 0,'Cape Verde Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Morocco Standard Time', '(UTC) Casablanca', 'Morocco Standard Time', 0.000, 1,'Morocco Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'UTC', '(UTC) Coordinated Universal Time', 'Coordinated Universal Time', 0.000, 0,'UTC', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'GMT Standard Time', '(UTC) Dublin, Edinburgh, Lisbon, London', 'GMT Standard Time', 0.000, 1,'GMT Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Greenwich Standard Time', '(UTC) Monrovia, Reykjavik', 'Greenwich Standard Time', 0.000, 0,'Greenwich Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'W. Europe Standard Time', '(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna', 'W. Europe Standard Time', 1.000, 1,'W. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Central Europe Standard Time', '(UTC+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague', 'Central Europe Standard Time', 1.000, 1,'Central Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Romance Standard Time', '(UTC+01:00) Brussels, Copenhagen, Madrid, Paris', 'Romance Standard Time', 1.000, 1,'Romance Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Central European Standard Time', '(UTC+01:00) Sarajevo, Skopje, Warsaw, Zagreb', 'Central European Standard Time', 1.000, 1,'Central European Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'W. Central Africa Standard Time', '(UTC+01:00) West Central Africa', 'W. Central Africa Standard Time', 1.000, 0,'W. Central Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Namibia Standard Time', '(UTC+01:00) Windhoek', 'Namibia Standard Time', 1.000, 1,'Namibia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'GTB Standard Time', '(UTC+02:00) Athens, Bucharest', 'GTB Standard Time', 2.000, 1,'GTB Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Middle East Standard Time', '(UTC+02:00) Beirut', 'Middle East Standard Time', 2.000, 1,'Middle East Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Egypt Standard Time', '(UTC+02:00) Cairo', 'Egypt Standard Time', 2.000, 1,'Egypt Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Syria Standard Time', '(UTC+02:00) Damascus', 'Syria Standard Time', 2.000, 1,'Syria Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'E. Europe Standard Time', '(UTC+02:00) E. Europe', 'E. Europe Standard Time', 2.000, 1,'E. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'South Africa Standard Time', '(UTC+02:00) Harare, Pretoria', 'South Africa Standard Time', 2.000, 0,'South Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'FLE Standard Time', '(UTC+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius', 'FLE Standard Time', 2.000, 1,'FLE Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Turkey Standard Time', '(UTC+02:00) Istanbul', 'Turkey Standard Time', 2.000, 1,'Turkey Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Israel Standard Time', '(UTC+02:00) Jerusalem', 'Jerusalem Standard Time', 2.000, 1,'Israel Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Libya Standard Time', '(UTC+02:00) Tripoli', 'Libya Standard Time', 2.000, 1,'Libya Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Jordan Standard Time', '(UTC+03:00) Amman', 'Jordan Standard Time', 3.000, 1,'Jordan Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Arabic Standard Time', '(UTC+03:00) Baghdad', 'Arabic Standard Time', 3.000, 1,'Arabic Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Kaliningrad Standard Time', '(UTC+03:00) Kaliningrad, Minsk', 'Kaliningrad Standard Time', 3.000, 1,'Kaliningrad Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Arab Standard Time', '(UTC+03:00) Kuwait, Riyadh', 'Arab Standard Time', 3.000, 0,'Arab Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'E. Africa Standard Time', '(UTC+03:00) Nairobi', 'E. Africa Standard Time', 3.000, 0,'E. Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Iran Standard Time', '(UTC+03:30) Tehran', 'Iran Standard Time', 3.500, 1,'Iran Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Arabian Standard Time', '(UTC+04:00) Abu Dhabi, Muscat', 'Arabian Standard Time', 4.000, 0,'Arabian Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Azerbaijan Standard Time', '(UTC+04:00) Baku', 'Azerbaijan Standard Time', 4.000, 1,'Azerbaijan Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Russian Standard Time', '(UTC+04:00) Moscow, St. Petersburg, Volgograd', 'Russian Standard Time', 4.000, 1,'Russian Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Mauritius Standard Time', '(UTC+04:00) Port Louis', 'Mauritius Standard Time', 4.000, 1,'Mauritius Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Georgian Standard Time', '(UTC+04:00) Tbilisi', 'Georgian Standard Time', 4.000, 0,'Georgian Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Caucasus Standard Time', '(UTC+04:00) Yerevan', 'Caucasus Standard Time', 4.000, 1,'Caucasus Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Afghanistan Standard Time', '(UTC+04:30) Kabul', 'Afghanistan Standard Time', 4.500, 0,'Afghanistan Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'West Asia Standard Time', '(UTC+05:00) Ashgabat, Tashkent', 'West Asia Standard Time', 5.000, 0,'West Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Pakistan Standard Time', '(UTC+05:00) Islamabad, Karachi', 'Pakistan Standard Time', 5.000, 1,'Pakistan Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'India Standard Time', '(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi', 'India Standard Time', 5.500, 0,'India Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Sri Lanka Standard Time', '(UTC+05:30) Sri Jayawardenepura', 'Sri Lanka Standard Time', 5.500, 0,'Sri Lanka Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Nepal Standard Time', '(UTC+05:45) Kathmandu', 'Nepal Standard Time', 5.750, 0,'Nepal Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Central Asia Standard Time', '(UTC+06:00) Astana', 'Central Asia Standard Time', 6.000, 0,'Central Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Bangladesh Standard Time', '(UTC+06:00) Dhaka', 'Bangladesh Standard Time', 6.000, 1,'Bangladesh Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Ekaterinburg Standard Time', '(UTC+06:00) Ekaterinburg', 'Ekaterinburg Standard Time', 6.000, 1,'Ekaterinburg Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Myanmar Standard Time', '(UTC+06:30) Yangon (Rangoon)', 'Myanmar Standard Time', 6.500, 0,'Myanmar Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'SE Asia Standard Time', '(UTC+07:00) Bangkok, Hanoi, Jakarta', 'SE Asia Standard Time', 7.000, 0,'SE Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'N. Central Asia Standard Time', '(UTC+07:00) Novosibirsk', 'N. Central Asia Standard Time', 7.000, 1,'N. Central Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'China Standard Time', '(UTC+08:00) Beijing, Chongqing, Hong Kong, Urumqi', 'China Standard Time', 8.000, 0,'China Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'North Asia Standard Time', '(UTC+08:00) Krasnoyarsk', 'North Asia Standard Time', 8.000, 1,'North Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Singapore Standard Time', '(UTC+08:00) Kuala Lumpur, Singapore', 'Malay Peninsula Standard Time', 8.000, 0,'Singapore Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'W. Australia Standard Time', '(UTC+08:00) Perth', 'W. Australia Standard Time', 8.000, 1,'W. Australia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Taipei Standard Time', '(UTC+08:00) Taipei', 'Taipei Standard Time', 8.000, 0,'Taipei Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Ulaanbaatar Standard Time', '(UTC+08:00) Ulaanbaatar', 'Ulaanbaatar Standard Time', 8.000, 0,'Ulaanbaatar Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'North Asia East Standard Time', '(UTC+09:00) Irkutsk', 'North Asia East Standard Time', 9.000, 1,'North Asia East Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Tokyo Standard Time', '(UTC+09:00) Osaka, Sapporo, Tokyo', 'Tokyo Standard Time', 9.000, 0,'Tokyo Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Korea Standard Time', '(UTC+09:00) Seoul', 'Korea Standard Time', 9.000, 0,'Korea Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Cen. Australia Standard Time', '(UTC+09:30) Adelaide', 'Cen. Australia Standard Time', 9.500, 1,'Cen. Australia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'AUS Central Standard Time', '(UTC+09:30) Darwin', 'AUS Central Standard Time', 9.500, 0,'AUS Central Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'E. Australia Standard Time', '(UTC+10:00) Brisbane', 'E. Australia Standard Time', 10.000, 0,'E. Australia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'AUS Eastern Standard Time', '(UTC+10:00) Canberra, Melbourne, Sydney', 'AUS Eastern Standard Time', 10.000, 1,'AUS Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'West Pacific Standard Time', '(UTC+10:00) Guam, Port Moresby', 'West Pacific Standard Time', 10.000, 0,'West Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Tasmania Standard Time', '(UTC+10:00) Hobart', 'Tasmania Standard Time', 10.000, 1,'Tasmania Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Yakutsk Standard Time', '(UTC+10:00) Yakutsk', 'Yakutsk Standard Time', 10.000, 1,'Yakutsk Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Central Pacific Standard Time', '(UTC+11:00) Solomon Is., New Caledonia', 'Central Pacific Standard Time', 11.000, 0,'Central Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Vladivostok Standard Time', '(UTC+11:00) Vladivostok', 'Vladivostok Standard Time', 11.000, 1,'Vladivostok Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'New Zealand Standard Time', '(UTC+12:00) Auckland, Wellington', 'New Zealand Standard Time', 12.000, 1,'New Zealand Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'UTC+12', '(UTC+12:00) Coordinated Universal Time+12', 'UTC+12', 12.000, 0,'UTC+12', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Fiji Standard Time', '(UTC+12:00) Fiji', 'Fiji Standard Time', 12.000, 1,'Fiji Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Magadan Standard Time', '(UTC+12:00) Magadan', 'Magadan Standard Time', 12.000, 1,'Magadan Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Kamchatka Standard Time', '(UTC+12:00) Petropavlovsk-Kamchatsky - Old', 'Kamchatka Standard Time', 12.000, 1,'Kamchatka Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Tonga Standard Time', '(UTC+13:00) Nuku''alofa', 'Tonga Standard Time', 13.000, 0,'Tonga Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 0, 'Samoa Standard Time', '(UTC+13:00) Samoa', 'Samoa Standard Time', 13.000, 1,'Samoa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Abidjan', 'Africa/Abidjan', 'GMT', 0.000, 0,'Greenwich Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Accra', 'Africa/Accra', 'GMT', 0.000, 0,'Greenwich Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Addis_Ababa', 'Africa/Addis_Ababa', 'GMT+3', 3.000, 0,'E. Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Algiers', 'Africa/Algiers', 'GMT+1', 1.000, 0,'W. Central Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Asmara', 'Africa/Asmara', 'GMT+3', 3.000, 0,'E. Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Bamako', 'Africa/Bamako', 'GMT', 0.000, 0,'Greenwich Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Bangui', 'Africa/Bangui', 'GMT+1', 1.000, 0,'W. Central Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Banjul', 'Africa/Banjul', 'GMT', 0.000, 0,'Greenwich Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Bissau', 'Africa/Bissau', 'GMT', 0.000, 0,'Greenwich Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Blantyre', 'Africa/Blantyre', 'GMT+2', 2.000, 0,'South Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Brazzaville', 'Africa/Brazzaville', 'GMT+1', 1.000, 0,'W. Central Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Bujumbura', 'Africa/Bujumbura', 'GMT+2', 2.000, 0,'South Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Cairo', 'Africa/Cairo', 'GMT+2', 2.000, 0,'Egypt Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Casablanca', 'Africa/Casablanca', 'GMT', 0.000, 0,'Morocco Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Ceuta', 'Africa/Ceuta', 'GMT+1', 1.000, 0,'Romance Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Conakry', 'Africa/Conakry', 'GMT', 0.000, 0,'Greenwich Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Dakar', 'Africa/Dakar', 'GMT', 0.000, 0,'Greenwich Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Dar_es_Salaam', 'Africa/Dar_es_Salaam', 'GMT+3', 3.000, 0,'E. Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Djibouti', 'Africa/Djibouti', 'GMT+3', 3.000, 0,'E. Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Douala', 'Africa/Douala', 'GMT+1', 1.000, 0,'W. Central Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/El_Aaiun', 'Africa/El_Aaiun', 'GMT', 0.000, 0,'Greenwich Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Freetown', 'Africa/Freetown', 'GMT', 0.000, 0,'Greenwich Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Gaborone', 'Africa/Gaborone', 'GMT+2', 2.000, 0,'South Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Harare', 'Africa/Harare', 'GMT+2', 2.000, 0,'South Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Johannesburg', 'Africa/Johannesburg', 'GMT+2', 2.000, 0,'South Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Juba', 'Africa/Juba', 'GMT+3', 3.000, 0,'E. Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Kampala', 'Africa/Kampala', 'GMT+3', 3.000, 0,'E. Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Khartoum', 'Africa/Khartoum', 'GMT+3', 3.000, 0,'E. Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Kigali', 'Africa/Kigali', 'GMT+2', 2.000, 0,'South Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Kinshasa', 'Africa/Kinshasa', 'GMT+1', 1.000, 0,'W. Central Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Lagos', 'Africa/Lagos', 'GMT+1', 1.000, 0,'W. Central Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Libreville', 'Africa/Libreville', 'GMT+1', 1.000, 0,'W. Central Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Lome', 'Africa/Lome', 'GMT', 0.000, 0,'Greenwich Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Luanda', 'Africa/Luanda', 'GMT+1', 1.000, 0,'W. Central Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Lubumbashi', 'Africa/Lubumbashi', 'GMT+2', 2.000, 0,'South Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Lusaka', 'Africa/Lusaka', 'GMT+2', 2.000, 0,'South Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Malabo', 'Africa/Malabo', 'GMT+1', 1.000, 0,'W. Central Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Maputo', 'Africa/Maputo', 'GMT+2', 2.000, 0,'South Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Maseru', 'Africa/Maseru', 'GMT+2', 2.000, 0,'South Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Mbabane', 'Africa/Mbabane', 'GMT+2', 2.000, 0,'South Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Mogadishu', 'Africa/Mogadishu', 'GMT+3', 3.000, 0,'E. Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Monrovia', 'Africa/Monrovia', 'GMT', 0.000, 0,'Greenwich Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Nairobi', 'Africa/Nairobi', 'GMT+3', 3.000, 0,'E. Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Ndjamena', 'Africa/Ndjamena', 'GMT+1', 1.000, 0,'W. Central Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Niamey', 'Africa/Niamey', 'GMT+1', 1.000, 0,'W. Central Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Nouakchott', 'Africa/Nouakchott', 'GMT', 0.000, 0,'Greenwich Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Ouagadougou', 'Africa/Ouagadougou', 'GMT', 0.000, 0,'Greenwich Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Porto-Novo', 'Africa/Porto-Novo', 'GMT+1', 1.000, 0,'W. Central Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Sao_Tome', 'Africa/Sao_Tome', 'GMT', 0.000, 0,'Greenwich Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Tripoli', 'Africa/Tripoli', 'GMT+2', 2.000, 0,'South Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Tunis', 'Africa/Tunis', 'GMT+1', 1.000, 0,'W. Central Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Africa/Windhoek', 'Africa/Windhoek', 'GMT+2', 2.000, 0,'Namibia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Adak', 'America/Adak', 'HAST', -10.000, 0,'Hawaiian Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Anchorage', 'America/Anchorage', 'AKST', -9.000, 0,'Alaskan Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Anguilla', 'America/Anguilla', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Antigua', 'America/Antigua', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Araguaina', 'America/Araguaina', 'GMT-3', -3.000, 0,'SA Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Argentina/Buenos_Aires', 'America/Argentina/Buenos_Aires', 'GMT-3', -3.000, 0,'Argentina Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Argentina/Catamarca', 'America/Argentina/Catamarca', 'GMT-3', -3.000, 0,'Argentina Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Argentina/Cordoba', 'America/Argentina/Cordoba', 'GMT-3', -3.000, 0,'Argentina Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Argentina/Jujuy', 'America/Argentina/Jujuy', 'GMT-3', -3.000, 0,'Argentina Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Argentina/La_Rioja', 'America/Argentina/La_Rioja', 'GMT-3', -3.000, 0,'Argentina Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Argentina/Mendoza', 'America/Argentina/Mendoza', 'GMT-3', -3.000, 0,'Argentina Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Argentina/Rio_Gallegos', 'America/Argentina/Rio_Gallegos', 'GMT-3', -3.000, 0,'Argentina Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Argentina/Salta', 'America/Argentina/Salta', 'GMT-3', -3.000, 0,'Argentina Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Argentina/San_Juan', 'America/Argentina/San_Juan', 'GMT-3', -3.000, 0,'Argentina Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Argentina/San_Luis', 'America/Argentina/San_Luis', 'GMT-3', -3.000, 0,'Argentina Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Argentina/Tucuman', 'America/Argentina/Tucuman', 'GMT-3', -3.000, 0,'Argentina Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Argentina/Ushuaia', 'America/Argentina/Ushuaia', 'GMT-3', -3.000, 0,'Argentina Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Aruba', 'America/Aruba', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Asuncion', 'America/Asuncion', 'GMT-3', -3.000, 0,'Paraguay Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Atikokan', 'America/Atikokan', 'EST', -5.000, 0,'Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Bahia', 'America/Bahia', 'GMT-3', -3.000, 0,'Bahia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Bahia_Banderas', 'America/Bahia_Banderas', 'CST', -6.000, 0,'Central Standard Time (Mexico)', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Barbados', 'America/Barbados', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Belem', 'America/Belem', 'GMT-3', -3.000, 0,'SA Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Belize', 'America/Belize', 'CST', -6.000, 0,'Central America Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Blanc-Sablon', 'America/Blanc-Sablon', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Boa_Vista', 'America/Boa_Vista', 'GMT-4', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Bogota', 'America/Bogota', 'GMT-5', -5.000, 0,'SA Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Boise', 'America/Boise', 'MST', -7.000, 0,'Mountain Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Cambridge_Bay', 'America/Cambridge_Bay', 'MST', -7.000, 0,'Mountain Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Campo_Grande', 'America/Campo_Grande', 'GMT-3', -3.000, 0,'Central Brazilian Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Cancun', 'America/Cancun', 'CST', -6.000, 0,'Central Standard Time (Mexico)', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Caracas', 'America/Caracas', 'GMT-4:30', -4.500, 0,'Venezuela Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Cayenne', 'America/Cayenne', 'GMT-3', -3.000, 0,'SA Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Cayman', 'America/Cayman', 'EST', -5.000, 0,'SA Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Chicago', 'America/Chicago', 'CST', -6.000, 0,'Central Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Chihuahua', 'America/Chihuahua', 'GMT-7', -7.000, 0,'Mountain Standard Time (Mexico)', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Costa_Rica', 'America/Costa_Rica', 'CST', -6.000, 0,'Central America Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Creston', 'America/Creston', 'MST', -7.000, 0,'Mountain Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Cuiaba', 'America/Cuiaba', 'GMT-3', -3.000, 0,'Central Brazilian Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Curacao', 'America/Curacao', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Danmarkshavn', 'America/Danmarkshavn', 'GMT', 0.000, 0,'UTC', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Dawson', 'America/Dawson', 'PST', -8.000, 0,'Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Dawson_Creek', 'America/Dawson_Creek', 'MST', -7.000, 0,'US Mountain Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Denver', 'America/Denver', 'MST', -7.000, 0,'Mountain Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Detroit', 'America/Detroit', 'EST', -5.000, 0,'Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Dominica', 'America/Dominica', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Edmonton', 'America/Edmonton', 'MST', -7.000, 0,'Mountain Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Eirunepe', 'America/Eirunepe', 'GMT-5', -5.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/El_Salvador', 'America/El_Salvador', 'CST', -6.000, 0,'Central America Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Fortaleza', 'America/Fortaleza', 'GMT-3', -3.000, 0,'SA Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Glace_Bay', 'America/Glace_Bay', 'AST', -4.000, 0,'Atlantic Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Godthab', 'America/Godthab', 'GMT-3', -3.000, 0,'Greenland Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Goose_Bay', 'America/Goose_Bay', 'AST', -4.000, 0,'Atlantic Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Grand_Turk', 'America/Grand_Turk', 'AST', -4.000, 0,'Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Grenada', 'America/Grenada', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Guadeloupe', 'America/Guadeloupe', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Guatemala', 'America/Guatemala', 'CST', -6.000, 0,'Central America Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Guayaquil', 'America/Guayaquil', 'GMT-5', -5.000, 0,'SA Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Guyana', 'America/Guyana', 'GMT-4', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Halifax', 'America/Halifax', 'AST', -4.000, 0,'Atlantic Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Havana', 'America/Havana', 'GMT-5', -5.000, 0,'SA Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Hermosillo', 'America/Hermosillo', 'GMT-7', -7.000, 0,'US Mountain Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Indiana/Indianapolis', 'America/Indiana/Indianapolis', 'EST', -5.000, 0,'US Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Indiana/Knox', 'America/Indiana/Knox', 'CST', -6.000, 0,'Central Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Indiana/Marengo', 'America/Indiana/Marengo', 'EST', -5.000, 0,'US Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Indiana/Petersburg', 'America/Indiana/Petersburg', 'EST', -5.000, 0,'Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Indiana/Tell_City', 'America/Indiana/Tell_City', 'CST', -6.000, 0,'Central Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Indiana/Vevay', 'America/Indiana/Vevay', 'EST', -5.000, 0,'US Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Indiana/Vincennes', 'America/Indiana/Vincennes', 'EST', -5.000, 0,'Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Indiana/Winamac', 'America/Indiana/Winamac', 'EST', -5.000, 0,'Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Inuvik', 'America/Inuvik', 'MST', -7.000, 0,'Mountain Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Iqaluit', 'America/Iqaluit', 'EST', -5.000, 0,'Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Jamaica', 'America/Jamaica', 'EST', -5.000, 0,'SA Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Juneau', 'America/Juneau', 'AKST', -9.000, 0,'Alaskan Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Kentucky/Louisville', 'America/Kentucky/Louisville', 'EST', -5.000, 0,'Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Kentucky/Monticello', 'America/Kentucky/Monticello', 'EST', -5.000, 0,'Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Kralendijk', 'America/Kralendijk', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/La_Paz', 'America/La_Paz', 'GMT-4', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Lima', 'America/Lima', 'GMT-5', -5.000, 0,'SA Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Los_Angeles', 'America/Los_Angeles', 'PST', -8.000, 0,'Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Lower_Princes', 'America/Lower_Princes', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Maceio', 'America/Maceio', 'GMT-3', -3.000, 0,'SA Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Managua', 'America/Managua', 'CST', -6.000, 0,'Central America Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Manaus', 'America/Manaus', 'GMT-4', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Marigot', 'America/Marigot', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Martinique', 'America/Martinique', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Matamoros', 'America/Matamoros', 'CST', -6.000, 0,'Central Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Mazatlan', 'America/Mazatlan', 'GMT-7', -7.000, 0,'Mountain Standard Time (Mexico)', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Menominee', 'America/Menominee', 'CST', -6.000, 0,'Central Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Merida', 'America/Merida', 'CST', -6.000, 0,'Central Standard Time (Mexico)', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Metlakatla', 'America/Metlakatla', 'PST', -8.000, 0,'Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Mexico_City', 'America/Mexico_City', 'CST', -6.000, 0,'Central Standard Time (Mexico)', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Miquelon', 'America/Miquelon', 'GMT-3', -3.000, 0,'E. South America Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Moncton', 'America/Moncton', 'AST', -4.000, 0,'Atlantic Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Monterrey', 'America/Monterrey', 'CST', -6.000, 0,'Central Standard Time (Mexico)', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Montevideo', 'America/Montevideo', 'GMT-2', -2.000, 0,'Montevideo Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Montreal', 'America/Montreal', 'GMT-5', -5.000, 0,'Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Montserrat', 'America/Montserrat', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Nassau', 'America/Nassau', 'EST', -5.000, 0,'Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/New_York', 'America/New_York', 'EST', -5.000, 0,'Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Nipigon', 'America/Nipigon', 'EST', -5.000, 0,'Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Nome', 'America/Nome', 'AKST', -9.000, 0,'Alaskan Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Noronha', 'America/Noronha', 'GMT-2', -2.000, 0,'UTC-02', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/North_Dakota/Beulah', 'America/North_Dakota/Beulah', 'CST', -6.000, 0,'Central Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/North_Dakota/Center', 'America/North_Dakota/Center', 'CST', -6.000, 0,'Central Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/North_Dakota/New_Salem', 'America/North_Dakota/New_Salem', 'CST', -6.000, 0,'Central Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Ojinaga', 'America/Ojinaga', 'MST', -7.000, 0,'Mountain Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Panama', 'America/Panama', 'EST', -5.000, 0,'SA Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Pangnirtung', 'America/Pangnirtung', 'EST', -5.000, 0,'Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Paramaribo', 'America/Paramaribo', 'GMT-3', -3.000, 0,'SA Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Phoenix', 'America/Phoenix', 'MST', -7.000, 0,'US Mountain Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Port-au-Prince', 'America/Port-au-Prince', 'EST', -5.000, 0,'SA Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Port_of_Spain', 'America/Port_of_Spain', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Porto_Velho', 'America/Porto_Velho', 'GMT-4', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Puerto_Rico', 'America/Puerto_Rico', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Rainy_River', 'America/Rainy_River', 'CST', -6.000, 0,'Central Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Rankin_Inlet', 'America/Rankin_Inlet', 'CST', -6.000, 0,'Central Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Recife', 'America/Recife', 'GMT-3', -3.000, 0,'SA Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Regina', 'America/Regina', 'CST', -6.000, 0,'Canada Central Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Resolute', 'America/Resolute', 'CST', -6.000, 0,'Central Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Rio_Branco', 'America/Rio_Branco', 'GMT-5', -5.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Santa_Isabel', 'America/Santa_Isabel', 'GMT-8', -8.000, 0,'Pacific Standard Time (Mexico)', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Santarem', 'America/Santarem', 'GMT-3', -3.000, 0,'SA Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Santiago', 'America/Santiago', 'GMT-3', -3.000, 0,'Pacific SA Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Santo_Domingo', 'America/Santo_Domingo', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Sao_Paulo', 'America/Sao_Paulo', 'GMT-2', -2.000, 0,'E. South America Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Scoresbysund', 'America/Scoresbysund', 'GMT-1', -1.000, 0,'Azores Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Shiprock', 'America/Shiprock', 'MST', -7.000, 0,'Mountain Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Sitka', 'America/Sitka', 'AKST', -9.000, 0,'Alaskan Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/St_Barthelemy', 'America/St_Barthelemy', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/St_Johns', 'America/St_Johns', 'GMT-3:30', -3.500, 0,'Newfoundland Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/St_Kitts', 'America/St_Kitts', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/St_Lucia', 'America/St_Lucia', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/St_Thomas', 'America/St_Thomas', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/St_Vincent', 'America/St_Vincent', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Swift_Current', 'America/Swift_Current', 'CST', -6.000, 0,'Canada Central Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Tegucigalpa', 'America/Tegucigalpa', 'CST', -6.000, 0,'Central America Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Thule', 'America/Thule', 'AST', -4.000, 0,'Atlantic Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Thunder_Bay', 'America/Thunder_Bay', 'EST', -5.000, 0,'Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Tijuana', 'America/Tijuana', 'PST', -8.000, 0,'Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Toronto', 'America/Toronto', 'EST', -5.000, 0,'Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Tortola', 'America/Tortola', 'AST', -4.000, 0,'SA Western Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Vancouver', 'America/Vancouver', 'PST', -8.000, 0,'Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Whitehorse', 'America/Whitehorse', 'PST', -8.000, 0,'Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Winnipeg', 'America/Winnipeg', 'CST', -6.000, 0,'Central Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Yakutat', 'America/Yakutat', 'AKST', -9.000, 0,'Alaskan Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'America/Yellowknife', 'America/Yellowknife', 'MST', -7.000, 0,'Mountain Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Antarctica/Casey', 'Antarctica/Casey', 'GMT+8', 8.000, 0,'W. Australia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Antarctica/Davis', 'Antarctica/Davis', 'GMT+7', 7.000, 0,'SE Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Antarctica/DumontDUrville', 'Antarctica/DumontDUrville', 'GMT+10', 10.000, 0,'West Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Antarctica/Macquarie', 'Antarctica/Macquarie', 'GMT+11', 11.000, 0,'Central Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Antarctica/Mawson', 'Antarctica/Mawson', 'GMT+5', 5.000, 0,'West Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Antarctica/McMurdo', 'Antarctica/McMurdo', 'GMT+13', 13.000, 0,'New Zealand Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Antarctica/Palmer', 'Antarctica/Palmer', 'GMT-3', -3.000, 0,'Pacific SA Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Antarctica/Rothera', 'Antarctica/Rothera', 'GMT-3', -3.000, 0,'SA Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Antarctica/South_Pole', 'Antarctica/South_Pole', 'GMT+13', 13.000, 0,'New Zealand Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Antarctica/Syowa', 'Antarctica/Syowa', 'GMT+3', 3.000, 0,'E. Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Antarctica/Troll', 'Antarctica/Troll', 'GMT', 0.000, 0,'GMT Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Antarctica/Vostok', 'Antarctica/Vostok', 'GMT+6', 6.000, 0,'Central Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Arctic/Longyearbyen', 'Arctic/Longyearbyen', 'GMT+1', 1.000, 0,'W. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Aden', 'Asia/Aden', 'GMT+3', 3.000, 0,'Arab Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Almaty', 'Asia/Almaty', 'GMT+6', 6.000, 0,'Central Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Amman', 'Asia/Amman', 'GMT+2', 2.000, 0,'Jordan Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Anadyr', 'Asia/Anadyr', 'GMT+12', 12.000, 0,'Magadan Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Aqtau', 'Asia/Aqtau', 'GMT+5', 5.000, 0,'West Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Aqtobe', 'Asia/Aqtobe', 'GMT+5', 5.000, 0,'West Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Ashgabat', 'Asia/Ashgabat', 'GMT+5', 5.000, 0,'West Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Baghdad', 'Asia/Baghdad', 'GMT+3', 3.000, 0,'Arabic Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Bahrain', 'Asia/Bahrain', 'GMT+3', 3.000, 0,'Arab Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Baku', 'Asia/Baku', 'GMT+4', 4.000, 0,'Azerbaijan Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Bangkok', 'Asia/Bangkok', 'GMT+7', 7.000, 0,'SE Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Beirut', 'Asia/Beirut', 'GMT+2', 2.000, 0,'Middle East Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Bishkek', 'Asia/Bishkek', 'GMT+6', 6.000, 0,'Central Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Brunei', 'Asia/Brunei', 'GMT+8', 8.000, 0,'Singapore Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Chita', 'Asia/Chita', 'GMT+8', 8.000, 0,'North Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Choibalsan', 'Asia/Choibalsan', 'GMT+8', 8.000, 0,'Ulaanbaatar Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Chongqing', 'Asia/Chongqing', 'GMT+8', 8.000, 0,'China Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Colombo', 'Asia/Colombo', 'GMT+5:30', 5.500, 0,'Sri Lanka Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Damascus', 'Asia/Damascus', 'GMT+2', 2.000, 0,'Syria Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Dhaka', 'Asia/Dhaka', 'GMT+6', 6.000, 0,'Bangladesh Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Dili', 'Asia/Dili', 'GMT+9', 9.000, 0,'Tokyo Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Dubai', 'Asia/Dubai', 'GMT+4', 4.000, 0,'Arabian Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Dushanbe', 'Asia/Dushanbe', 'GMT+5', 5.000, 0,'West Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Gaza', 'Asia/Gaza', 'GMT+2', 2.000, 0,'Egypt Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Harbin', 'Asia/Harbin', 'GMT+8', 8.000, 0,'China Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Hebron', 'Asia/Hebron', 'GMT+2', 2.000, 0,'Egypt Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Ho_Chi_Minh', 'Asia/Ho_Chi_Minh', 'GMT+7', 7.000, 0,'SE Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Hong_Kong', 'Asia/Hong_Kong', 'GMT+8', 8.000, 0,'China Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Hovd', 'Asia/Hovd', 'GMT+7', 7.000, 0,'SE Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Irkutsk', 'Asia/Irkutsk', 'GMT+8', 8.000, 0,'North Asia East Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Jakarta', 'Asia/Jakarta', 'GMT+7', 7.000, 0,'SE Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Jayapura', 'Asia/Jayapura', 'GMT+9', 9.000, 0,'Tokyo Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Jerusalem', 'Asia/Jerusalem', 'GMT+2', 2.000, 0,'Israel Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Kabul', 'Asia/Kabul', 'GMT+4:30', 4.500, 0,'Afghanistan Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Kamchatka', 'Asia/Kamchatka', 'GMT+12', 12.000, 0,'Magadan Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Karachi', 'Asia/Karachi', 'GMT+5', 5.000, 0,'Pakistan Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Kashgar', 'Asia/Kashgar', 'GMT+6', 6.000, 0,'China Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Kathmandu', 'Asia/Kathmandu', 'GMT+5:45', 5.750, 0,'Nepal Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Katmandu', 'Asia/Katmandu', 'GMT+5:45', 5.750, 0,'Nepal Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Khandyga', 'Asia/Khandyga', 'GMT+9', 9.000, 0,'North Asia East Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Kolkata', 'Asia/Kolkata', 'GMT+5:30', 5.500, 0,'India Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Krasnoyarsk', 'Asia/Krasnoyarsk', 'GMT+7', 7.000, 0,'North Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Kuala_Lumpur', 'Asia/Kuala_Lumpur', 'GMT+8', 8.000, 0,'Singapore Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Kuching', 'Asia/Kuching', 'GMT+8', 8.000, 0,'Singapore Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Kuwait', 'Asia/Kuwait', 'GMT+3', 3.000, 0,'Arab Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Macau', 'Asia/Macau', 'GMT+8', 8.000, 0,'China Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Magadan', 'Asia/Magadan', 'GMT+10', 10.000, 0,'Magadan Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Makassar', 'Asia/Makassar', 'GMT+8', 8.000, 0,'Singapore Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Manila', 'Asia/Manila', 'GMT+8', 8.000, 0,'Singapore Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Muscat', 'Asia/Muscat', 'GMT+4', 4.000, 0,'Arabian Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Nicosia', 'Asia/Nicosia', 'GMT+2', 2.000, 0,'E. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Novokuznetsk', 'Asia/Novokuznetsk', 'GMT+7', 7.000, 0,'N. Central Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Novosibirsk', 'Asia/Novosibirsk', 'GMT+6', 6.000, 0,'N. Central Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Omsk', 'Asia/Omsk', 'GMT+6', 6.000, 0,'N. Central Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Oral', 'Asia/Oral', 'GMT+5', 5.000, 0,'West Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Phnom_Penh', 'Asia/Phnom_Penh', 'GMT+7', 7.000, 0,'SE Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Pontianak', 'Asia/Pontianak', 'GMT+7', 7.000, 0,'SE Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Pyongyang', 'Asia/Pyongyang', 'GMT+9', 9.000, 0,'Korea Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Qatar', 'Asia/Qatar', 'GMT+3', 3.000, 0,'Arab Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Qyzylorda', 'Asia/Qyzylorda', 'GMT+6', 6.000, 0,'Central Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Rangoon', 'Asia/Rangoon', 'GMT+6:30', 6.500, 0,'Myanmar Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Riyadh', 'Asia/Riyadh', 'GMT+3', 3.000, 0,'Arab Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Sakhalin', 'Asia/Sakhalin', 'GMT+10', 10.000, 0,'Vladivostok Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Samarkand', 'Asia/Samarkand', 'GMT+5', 5.000, 0,'West Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Seoul', 'Asia/Seoul', 'GMT+9', 9.000, 0,'Korea Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Shanghai', 'Asia/Shanghai', 'GMT+8', 8.000, 0,'China Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Singapore', 'Asia/Singapore', 'GMT+8', 8.000, 0,'Singapore Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Srednekolymsk', 'Asia/Srednekolymsk', 'GMT+11', 11.000, 0,'Vladivostok Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Taipei', 'Asia/Taipei', 'GMT+8', 8.000, 0,'Taipei Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Tashkent', 'Asia/Tashkent', 'GMT+5', 5.000, 0,'West Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Tbilisi', 'Asia/Tbilisi', 'GMT+4', 4.000, 0,'Georgian Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Tehran', 'Asia/Tehran', 'GMT+3:30', 3.500, 0,'Iran Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Thimphu', 'Asia/Thimphu', 'GMT+6', 6.000, 0,'Bangladesh Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Tokyo', 'Asia/Tokyo', 'GMT+9', 9.000, 0,'Tokyo Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Ulaanbaatar', 'Asia/Ulaanbaatar', 'GMT+8', 8.000, 0,'Ulaanbaatar Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Urumqi', 'Asia/Urumqi', 'GMT+6', 6.000, 0,'China Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Ust-Nera', 'Asia/Ust-Nera', 'GMT+10', 10.000, 0,'', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Vientiane', 'Asia/Vientiane', 'GMT+7', 7.000, 0,'SE Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Vladivostok', 'Asia/Vladivostok', 'GMT+10', 10.000, 0,'Vladivostok Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Yakutsk', 'Asia/Yakutsk', 'GMT+9', 9.000, 0,'Yakutsk Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Yekaterinburg', 'Asia/Yekaterinburg', 'GMT+5', 5.000, 0,'Ekaterinburg Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Asia/Yerevan', 'Asia/Yerevan', 'GMT+4', 4.000, 0,'Caucasus Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Atlantic/Azores', 'Atlantic/Azores', 'GMT-1', -1.000, 0,'Azores Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Atlantic/Bermuda', 'Atlantic/Bermuda', 'AST', -4.000, 0,'Atlantic Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Atlantic/Canary', 'Atlantic/Canary', 'GMT', 0.000, 0,'GMT Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Atlantic/Cape_Verde', 'Atlantic/Cape_Verde', 'GMT-1', -1.000, 0,'Cape Verde Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Atlantic/Faroe', 'Atlantic/Faroe', 'GMT', 0.000, 0,'', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Atlantic/Madeira', 'Atlantic/Madeira', 'GMT', 0.000, 0,'GMT Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Atlantic/Reykjavik', 'Atlantic/Reykjavik', 'GMT', 0.000, 0,'Greenwich Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Atlantic/South_Georgia', 'Atlantic/South_Georgia', 'GMT-2', -2.000, 0,'UTC-02', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Atlantic/St_Helena', 'Atlantic/St_Helena', 'GMT', 0.000, 0,'Greenwich Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Atlantic/Stanley', 'Atlantic/Stanley', 'GMT-3', -3.000, 0,'', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Australia/Adelaide', 'Australia/Adelaide', 'GMT+10:30', 10.500, 0,'Cen. Australia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Australia/Brisbane', 'Australia/Brisbane', 'GMT+10', 10.000, 0,'E. Australia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Australia/Broken_Hill', 'Australia/Broken_Hill', 'GMT+10:30', 10.500, 0,'Cen. Australia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Australia/Currie', 'Australia/Currie', 'GMT+11', 11.000, 0,'Tasmania Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Australia/Darwin', 'Australia/Darwin', 'GMT+9:30', 9.500, 0,'AUS Central Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Australia/Eucla', 'Australia/Eucla', 'GMT+8:45', 8.750, 0,'', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Australia/Hobart', 'Australia/Hobart', 'GMT+11', 11.000, 0,'Tasmania Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Australia/Lindeman', 'Australia/Lindeman', 'GMT+10', 10.000, 0,'E. Australia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Australia/Lord_Howe', 'Australia/Lord_Howe', 'GMT+11', 11.000, 0,'', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Australia/Melbourne', 'Australia/Melbourne', 'GMT+11', 11.000, 0,'AUS Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Australia/Perth', 'Australia/Perth', 'GMT+8', 8.000, 0,'W. Australia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Australia/Sydney', 'Australia/Sydney', 'GMT+11', 11.000, 0,'AUS Eastern Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Amsterdam', 'Europe/Amsterdam', 'GMT+1', 1.000, 0,'W. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Andorra', 'Europe/Andorra', 'GMT+1', 1.000, 0,'W. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Athens', 'Europe/Athens', 'GMT+2', 2.000, 0,'GTB Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Belgrade', 'Europe/Belgrade', 'GMT+1', 1.000, 0,'Central Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Berlin', 'Europe/Berlin', 'GMT+1', 1.000, 0,'W. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Bratislava', 'Europe/Bratislava', 'GMT+1', 1.000, 0,'Central Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Brussels', 'Europe/Brussels', 'GMT+1', 1.000, 0,'Romance Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Bucharest', 'Europe/Bucharest', 'GMT+2', 2.000, 0,'GTB Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Budapest', 'Europe/Budapest', 'GMT+1', 1.000, 0,'Central Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Busingen', 'Europe/Busingen', 'GMT+1', 1.000, 0,'W. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Chisinau', 'Europe/Chisinau', 'GMT+2', 2.000, 0,'GTB Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Copenhagen', 'Europe/Copenhagen', 'GMT+1', 1.000, 0,'Romance Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Dublin', 'Europe/Dublin', 'GMT', 0.000, 0,'GMT Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Gibraltar', 'Europe/Gibraltar', 'GMT+1', 1.000, 0,'W. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Guernsey', 'Europe/Guernsey', 'GMT', 0.000, 0,'GMT Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Helsinki', 'Europe/Helsinki', 'GMT+2', 2.000, 0,'FLE Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Isle_of_Man', 'Europe/Isle_of_Man', 'GMT', 0.000, 0,'GMT Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Istanbul', 'Europe/Istanbul', 'GMT+2', 2.000, 0,'Turkey Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Jersey', 'Europe/Jersey', 'GMT', 0.000, 0,'GMT Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Kaliningrad', 'Europe/Kaliningrad', 'GMT+2', 2.000, 0,'Kaliningrad Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Kiev', 'Europe/Kiev', 'GMT+2', 2.000, 0,'FLE Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Lisbon', 'Europe/Lisbon', 'GMT', 0.000, 0,'GMT Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Ljubljana', 'Europe/Ljubljana', 'GMT+1', 1.000, 0,'Central Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/London', 'Europe/London', 'GMT', 0.000, 0,'GMT Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Luxembourg', 'Europe/Luxembourg', 'GMT+1', 1.000, 0,'W. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Madrid', 'Europe/Madrid', 'GMT+1', 1.000, 0,'Romance Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Malta', 'Europe/Malta', 'GMT+1', 1.000, 0,'W. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Mariehamn', 'Europe/Mariehamn', 'GMT+2', 2.000, 0,'FLE Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Minsk', 'Europe/Minsk', 'GMT+3', 3.000, 0,'Kaliningrad Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Monaco', 'Europe/Monaco', 'GMT+1', 1.000, 0,'W. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Moscow', 'Europe/Moscow', 'GMT+3', 3.000, 0,'Russian Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Oslo', 'Europe/Oslo', 'GMT+1', 1.000, 0,'W. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Paris', 'Europe/Paris', 'GMT+1', 1.000, 0,'Romance Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Podgorica', 'Europe/Podgorica', 'GMT+1', 1.000, 0,'Central Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Prague', 'Europe/Prague', 'GMT+1', 1.000, 0,'Central Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Riga', 'Europe/Riga', 'GMT+2', 2.000, 0,'FLE Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Rome', 'Europe/Rome', 'GMT+1', 1.000, 0,'W. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Samara', 'Europe/Samara', 'GMT+4', 4.000, 0,'Russian Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/San_Marino', 'Europe/San_Marino', 'GMT+1', 1.000, 0,'W. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Sarajevo', 'Europe/Sarajevo', 'GMT+1', 1.000, 0,'Central European Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Simferopol', 'Europe/Simferopol', 'GMT+3', 3.000, 0,'FLE Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Skopje', 'Europe/Skopje', 'GMT+1', 1.000, 0,'Central European Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Sofia', 'Europe/Sofia', 'GMT+2', 2.000, 0,'FLE Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Stockholm', 'Europe/Stockholm', 'GMT+1', 1.000, 0,'W. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Tallinn', 'Europe/Tallinn', 'GMT+2', 2.000, 0,'FLE Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Tirane', 'Europe/Tirane', 'GMT+1', 1.000, 0,'Central Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Uzhgorod', 'Europe/Uzhgorod', 'GMT+2', 2.000, 0,'FLE Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Vaduz', 'Europe/Vaduz', 'GMT+1', 1.000, 0,'W. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Vatican', 'Europe/Vatican', 'GMT+1', 1.000, 0,'W. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Vienna', 'Europe/Vienna', 'GMT+1', 1.000, 0,'W. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Vilnius', 'Europe/Vilnius', 'GMT+2', 2.000, 0,'FLE Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Volgograd', 'Europe/Volgograd', 'GMT+3', 3.000, 0,'Russian Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Warsaw', 'Europe/Warsaw', 'GMT+1', 1.000, 0,'Central European Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Zagreb', 'Europe/Zagreb', 'GMT+1', 1.000, 0,'Central European Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Zaporozhye', 'Europe/Zaporozhye', 'GMT+2', 2.000, 0,'FLE Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Europe/Zurich', 'Europe/Zurich', 'GMT+1', 1.000, 0,'W. Europe Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'GMT', 'GMT', 'GMT', 0.000, 0,'GMT Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Indian/Antananarivo', 'Indian/Antananarivo', 'GMT+3', 3.000, 0,'E. Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Indian/Chagos', 'Indian/Chagos', 'GMT+6', 6.000, 0,'Central Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Indian/Christmas', 'Indian/Christmas', 'GMT+7', 7.000, 0,'SE Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Indian/Cocos', 'Indian/Cocos', 'GMT+6:30', 6.500, 0,'Myanmar Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Indian/Comoro', 'Indian/Comoro', 'GMT+3', 3.000, 0,'E. Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Indian/Kerguelen', 'Indian/Kerguelen', 'GMT+5', 5.000, 0,'West Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Indian/Mahe', 'Indian/Mahe', 'GMT+4', 4.000, 0,'Mauritius Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Indian/Maldives', 'Indian/Maldives', 'GMT+5', 5.000, 0,'West Asia Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Indian/Mauritius', 'Indian/Mauritius', 'GMT+4', 4.000, 0,'Mauritius Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Indian/Mayotte', 'Indian/Mayotte', 'GMT+3', 3.000, 0,'E. Africa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Indian/Reunion', 'Indian/Reunion', 'GMT+4', 4.000, 0,'Mauritius Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Apia', 'Pacific/Apia', 'GMT+14', 14.000, 0,'Samoa Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Auckland', 'Pacific/Auckland', 'GMT+13', 13.000, 0,'New Zealand Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Chatham', 'Pacific/Chatham', 'GMT+13:45', 13.750, 0,'', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Chuuk', 'Pacific/Chuuk', 'GMT+10', 10.000, 0,'', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Easter', 'Pacific/Easter', 'GMT-5', -5.000, 0,'', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Efate', 'Pacific/Efate', 'GMT+11', 11.000, 0,'Central Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Enderbury', 'Pacific/Enderbury', 'GMT+13', 13.000, 0,'Tonga Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Fakaofo', 'Pacific/Fakaofo', 'GMT+13', 13.000, 0,'Hawaiian Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Fiji', 'Pacific/Fiji', 'GMT+12', 12.000, 0,'Fiji Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Funafuti', 'Pacific/Funafuti', 'GMT+12', 12.000, 0,'UTC+12', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Galapagos', 'Pacific/Galapagos', 'GMT-6', -6.000, 0,'Central America Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Gambier', 'Pacific/Gambier', 'GMT-9', -9.000, 0,'Alaskan Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Guadalcanal', 'Pacific/Guadalcanal', 'GMT+11', 11.000, 0,'Central Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Guam', 'Pacific/Guam', 'GMT+10', 10.000, 0,'West Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Honolulu', 'Pacific/Honolulu', 'HST', -10.000, 0,'Hawaiian Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Johnston', 'Pacific/Johnston', 'HAST', -10.000, 0,'Hawaiian Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Kiritimati', 'Pacific/Kiritimati', 'GMT+14', 14.000, 0,'', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Kosrae', 'Pacific/Kosrae', 'GMT+11', 11.000, 0,'Central Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Kwajalein', 'Pacific/Kwajalein', 'GMT+12', 12.000, 0,'UTC+12', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Majuro', 'Pacific/Majuro', 'GMT+12', 12.000, 0,'UTC+12', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Marquesas', 'Pacific/Marquesas', 'GMT-9:30', -9.500, 0,'SA Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Midway', 'Pacific/Midway', 'GMT-11', -11.000, 0,'UTC-11', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Nauru', 'Pacific/Nauru', 'GMT+12', 12.000, 0,'UTC+12', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Niue', 'Pacific/Niue', 'GMT-11', -11.000, 0,'UTC-11', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Norfolk', 'Pacific/Norfolk', 'GMT+11:30', 11.500, 0,'', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Noumea', 'Pacific/Noumea', 'GMT+11', 11.000, 0,'Central Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Pago_Pago', 'Pacific/Pago_Pago', 'GMT-11', -11.000, 0,'UTC-11', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Palau', 'Pacific/Palau', 'GMT+9', 9.000, 0,'Tokyo Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Pitcairn', 'Pacific/Pitcairn', 'GMT-8', -8.000, 0,'', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Pohnpei', 'Pacific/Pohnpei', 'GMT+11', 11.000, 0,'', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Ponape', 'Pacific/Ponape', 'GMT+11', 11.000, 0,'Central Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Port_Moresby', 'Pacific/Port_Moresby', 'GMT+10', 10.000, 0,'West Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Rarotonga', 'Pacific/Rarotonga', 'GMT-10', -10.000, 0,'Hawaiian Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Saipan', 'Pacific/Saipan', 'GMT+10', 10.000, 0,'West Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Tahiti', 'Pacific/Tahiti', 'GMT-10', -10.000, 0,'Hawaiian Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Tarawa', 'Pacific/Tarawa', 'GMT+12', 12.000, 0,'UTC+12', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Tongatapu', 'Pacific/Tongatapu', 'GMT+13', 13.000, 0,'Tonga Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Truk', 'Pacific/Truk', 'GMT+10', 10.000, 0,'West Pacific Standard Time', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Wake', 'Pacific/Wake', 'GMT+12', 12.000, 0,'UTC+12', GETDATE()

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
select 1, 'Pacific/Wallis', 'Pacific/Wallis', 'GMT+12', 12.000, 0,'UTC+12', GETDATE()


insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
--select 1, 'Pacific/Wallis', 'Pacific/Wallis', 'GMT+12', 12.000, 0,'UTC+12', GETDATE()
select 2 as DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, GETDATE()
from TimeZoneMap a where a.DeviceTypeCodeId = 1

insert into TimeZoneMap (DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, CreateDate)
--select 1, 'Pacific/Wallis', 'Pacific/Wallis', 'GMT+12', 12.000, 0,'UTC+12', GETDATE()
select 5 as DeviceTypeCodeId, TimeZoneId, TimeZoneName, TimeZoneAbbr, UTCOffset, SupportDST, NETTimeZoneId, GETDATE()
from TimeZoneMap a where a.DeviceTypeCodeId = 1