EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'ServiceTypeSelectPage_1',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'呼叫', @pContentEnglish = N'TALK'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'ServiceTypeSelectPage_1',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Anruf', @pContentEnglish = N'TALK'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go

