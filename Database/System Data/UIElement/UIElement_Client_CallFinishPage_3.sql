EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'CallFinishPage_3',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'您可以在一分钟内立即再次连接', @pContentEnglish = N'You can reconnect for 1 minute.'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'CallFinishPage_3',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Erneut verbinden nach 1 Minute', @pContentEnglish = N'You can reconnect for 1 minute.'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'CallFinishPage_3',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'Vuelva a intentar en un (1) minuto.', @pContentEnglish = N'You can reconnect for 1 minute.'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'CallFinishPage_3',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'您可以在一分鐘內立即再次連接', @pContentEnglish = N'You can reconnect for 1 minute.'


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'CallFinishPage_3'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'CallFinishPage_3'
) order by SystemLanguageId, Id desc

go

