EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'WorkingSchedule_5',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'修改工作时间', @pContentEnglish = N'Change Working Schedule'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'WorkingSchedule_5',	@pSystemLanguageId = 3,		-- 繁體中文	zh-TW
	@pContentInSystemLanguage = N'修改工作時間', @pContentEnglish = N'Change Working Schedule'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'WorkingSchedule_5',	@pSystemLanguageId = 4,		-- Español	es
	@pContentInSystemLanguage = N'ESTABLECER HORARIOS DE TRABAJO', @pContentEnglish = N'Change Working Schedule'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'WorkingSchedule_5',	@pSystemLanguageId = 14,		-- Deutsch	de
	@pContentInSystemLanguage = N'Arbeitszeitplan ändern', @pContentEnglish = N'Change Working Schedule'




-----------------------------------------------------------------------------------------------------------------------------------

--select * from SystemLanguage
select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'WorkingSchedule_5' and AppName = 'Provider'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'WorkingSchedule_5' and AppName = 'Provider'
) order by SystemLanguageId, Id desc

go

