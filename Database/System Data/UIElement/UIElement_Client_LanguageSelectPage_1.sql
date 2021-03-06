EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'LanguageSelectPage_1',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'我希望有人帮我翻译', @pContentEnglish = N'I need help with'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'LanguageSelectPage_1',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Ich suche einen Dolmetscher/eine Dolmetscherin für', @pContentEnglish = N'I need help with'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'LanguageSelectPage_1',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'Necesito ayuda con lo siguiente', @pContentEnglish = N'I need help with'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'LanguageSelectPage_1',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'我希望有人幫我翻譯', @pContentEnglish = N'I need help with'


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go

