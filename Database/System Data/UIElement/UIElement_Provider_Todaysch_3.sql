EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Todaysch_3',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'除了以上定义的时间外我不工作', @pContentEnglish = N'I am not available other than the time defined above'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Todaysch_3',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Zusätzlich zu dem oben definierten Zeit nicht funktionieren I', @pContentEnglish = N'I am not available other than the time defined above'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Todaysch_3',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'YO NO ESTOY DISPONIBLE QUE NO SEA EL TIEMPO DEFINIDO ANTERIORMENTE', @pContentEnglish = N'I am not available other than the time defined above'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Todaysch_3',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'除了以上定義的時間外我不工作', @pContentEnglish = N'I am not available other than the time defined above'


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'Todaysch_3'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'Todaysch_3'
) order by SystemLanguageId, Id desc

go

