EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'NonBussinessDay_2',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'从（日期）：', @pContentEnglish = N'From Date:'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'NonBussinessDay_2',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Ab Datum:', @pContentEnglish = N'From Date:'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'NonBussinessDay_2',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'A PARTIR DE:', @pContentEnglish = N'From Date:'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'NonBussinessDay_2',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'從（日期）：', @pContentEnglish = N'From Date:'


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'NonBussinessDay_2'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'NonBussinessDay_2'
) order by SystemLanguageId, Id desc

go

