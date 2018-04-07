EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'hold_call',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'保持', @pContentEnglish = N'hold'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'hold_call',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'halt', @pContentEnglish = N'hold'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go