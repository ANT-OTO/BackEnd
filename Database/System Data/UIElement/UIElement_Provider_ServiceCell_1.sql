EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ServiceCell_1',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'服务类型', @pContentEnglish = N'Type'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ServiceCell_1',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Art der Dienstleistung', @pContentEnglish = N'Type'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ServiceCell_1',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'TIPO', @pContentEnglish = N'Type'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ServiceCell_1',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'服務類型', @pContentEnglish = N'Type'


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'ServiceCell_1'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'ServiceCell_1'
) order by SystemLanguageId, Id desc

go

