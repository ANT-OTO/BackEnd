EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'MainPageOption_1',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'智能翻译', @pContentEnglish = N'Machine'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'MainPageOption_1',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Intelligente Übersetzung', @pContentEnglish = N'Machine'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'MainPageOption_1',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'Traducción inteligente', @pContentEnglish = N'Machine'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'MainPageOption_1',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'智能翻譯', @pContentEnglish = N'Machine'


select top 5 * from UIElement order by Id desc
select top 5 * from UIElementY order by Id desc
--select top 10 * from UIElement where Id in (
--select top 10 UIElementId from UIElementY where Content = 'Fong Auto' order by Id desc
--)
--select top 10 * from UIElementY where Content = 'Fong Auto' order by Id desc

select * from UIElement where ElementKey = 'MainPageOption_1'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'MainPageOption_1'
) order by SystemLanguageId, Id desc

go

