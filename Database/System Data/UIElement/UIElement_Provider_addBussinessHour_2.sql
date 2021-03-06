EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'addBussinessHour_2',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'从（时间）：', @pContentEnglish = N'From Time:'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'addBussinessHour_2',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Von Zeit:', @pContentEnglish = N'From Time:'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'addBussinessHour_2',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'DE VEZ:', @pContentEnglish = N'From Time:'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'addBussinessHour_2',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'從（時間）：', @pContentEnglish = N'From Time:'


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'addBussinessHour_2'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'addBussinessHour_2'
) order by SystemLanguageId, Id desc

go

