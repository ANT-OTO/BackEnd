EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'not_valid_code',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'无效代码', @pContentEnglish = N'Invalid code'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'not_valid_code',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Kein gültiger code', @pContentEnglish = N'Invalid code'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go

