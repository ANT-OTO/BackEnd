EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'CallPage_3',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'静音', @pContentEnglish = N' mute'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'CallPage_3',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Stummschaltung', @pContentEnglish = N' mute'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'CallPage_3',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'静音', @pContentEnglish = N'mute'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'CallPage_3',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Stummschaltung', @pContentEnglish = N'mute'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go

