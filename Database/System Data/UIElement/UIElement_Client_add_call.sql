EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'add_call',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'添加电话', @pContentEnglish = N'add call'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'add_call',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Anruf hinzufügen', @pContentEnglish = N'add call'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go


