EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'dialpad_text_view',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'键盘', @pContentEnglish = N'keypad'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'dialpad_text_view',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Tastenfeld', @pContentEnglish = N'keypad'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go