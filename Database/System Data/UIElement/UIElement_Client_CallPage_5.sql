EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'CallPage_5',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'信息', @pContentEnglish = N' text'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'CallPage_5',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'text', @pContentEnglish = N' text'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'CallPage_5',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'信息', @pContentEnglish = N'text'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'CallPage_5',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'text', @pContentEnglish = N'text'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go
