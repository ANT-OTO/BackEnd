EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Summary_1',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'服务概要', @pContentEnglish = N'Service Summary'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Summary_1',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Service Zusammenfassung', @pContentEnglish = N'Service Summary'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Summary_1',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'RESUMEN DE SERVICIO', @pContentEnglish = N'Service Summary'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Summary_1',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'服務概要', @pContentEnglish = N'Service Summary'


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'Summary_1' and AppName = 'Provider'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'Summary_1' and AppName = 'Provider'
) order by SystemLanguageId, Id desc

go

