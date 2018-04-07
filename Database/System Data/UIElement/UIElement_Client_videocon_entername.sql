EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'videocon_entername',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'请输入姓名', @pContentEnglish = N'Please enter name'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'videocon_entername',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Bitte geben Sie den Namen ein', @pContentEnglish = N'Please enter name'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go