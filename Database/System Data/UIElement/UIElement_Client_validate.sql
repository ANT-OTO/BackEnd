EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'validate',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'验证', @pContentEnglish = N'Validate'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'validate',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Bestätigen', @pContentEnglish = N'Validate'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go