EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'WorkingSchedule_6',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'是否可以工作', @pContentEnglish = N'Available'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'WorkingSchedule_6',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Ich kann arbeiten', @pContentEnglish = N'Available'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'WorkingSchedule_6',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'Puedo trabajar', @pContentEnglish = N'Available'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'WorkingSchedule_6',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'是否可以工作', @pContentEnglish = N'Available'


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'WorkingSchedule_6'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'WorkingSchedule_6'
) order by SystemLanguageId, Id desc

go

