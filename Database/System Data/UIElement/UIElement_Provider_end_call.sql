EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'end_call',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'结束', @pContentEnglish = N'End'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'end_call',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Ende', @pContentEnglish = N'End'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go

