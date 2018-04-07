EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'videocon_inform',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'已通知', @pContentEnglish = N'Informed'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'videocon_inform',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Informiert', @pContentEnglish = N'Informed'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go