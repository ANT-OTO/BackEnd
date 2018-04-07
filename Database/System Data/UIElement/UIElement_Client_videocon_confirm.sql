EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'videocon_confirm',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'已确认', @pContentEnglish = N'Confirmed'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'videocon_confirm',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Bestätigt', @pContentEnglish = N'Confirmed'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go