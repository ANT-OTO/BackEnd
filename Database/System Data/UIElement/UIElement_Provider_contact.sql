EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'contact',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'联系人', @pContentEnglish = N'contacts'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'contact',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Kontakte', @pContentEnglish = N'contacts'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go