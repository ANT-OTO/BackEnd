EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'Service_16',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'扬声器', @pContentEnglish = N' speaker'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'Service_16',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Aufrechtzuerhalten', @pContentEnglish = N' speaker'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'Service_16',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'扬声器', @pContentEnglish = N'speaker'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'Service_16',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Aufrechtzuerhalten', @pContentEnglish = N'speaker'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go

