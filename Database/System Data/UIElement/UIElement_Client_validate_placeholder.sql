EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'validate_placeholder',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'输入邀请码', @pContentEnglish = N'Type in the invitation code'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'validate_placeholder',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Geben Sie den Einladungscode ein', @pContentEnglish = N'Type in the invitation code'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go