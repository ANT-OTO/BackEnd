EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'merge_call',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'合并', @pContentEnglish = N'merge'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'merge_call',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'verschmelzen', @pContentEnglish = N'merge'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go