EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'video_status_mute',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'已静音', @pContentEnglish = N'has muted'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'video_status_mute',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Hat gedämpft', @pContentEnglish = N'has muted'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go