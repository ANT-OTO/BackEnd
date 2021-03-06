EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Rate_1',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'评价表现', @pContentEnglish = N'RATE PERFORMANCE'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Rate_1',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Performance bewerten', @pContentEnglish = N'RATE PERFORMANCE'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Rate_1',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'CALIFICAR EL SERVICIO', @pContentEnglish = N'RATE PERFORMANCE'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Rate_1',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'評價表現', @pContentEnglish = N'RATE PERFORMANCE'


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'Rate_1' and AppName = 'Provider'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'Rate_1' and AppName = 'Provider'
) order by SystemLanguageId, Id desc

go

