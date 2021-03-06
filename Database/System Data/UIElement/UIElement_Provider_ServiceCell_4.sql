EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ServiceCell_4',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'翻译需求语言', @pContentEnglish = N'Need'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ServiceCell_4',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Brauchen', @pContentEnglish = N'Need'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ServiceCell_4',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'NECESITAR', @pContentEnglish = N'Need'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ServiceCell_4',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'翻譯需求語言', @pContentEnglish = N'Need'


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'ServiceCell_4'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'ServiceCell_4'
) order by SystemLanguageId, Id desc

go

