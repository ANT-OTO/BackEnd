EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'video_status_unmute',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'已取消静音', @pContentEnglish = N'has unmuted'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'video_status_unmute',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Ist nicht stumm', @pContentEnglish = N'has unmuted'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go