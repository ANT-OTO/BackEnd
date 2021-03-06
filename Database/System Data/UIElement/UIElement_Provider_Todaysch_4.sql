EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Todaysch_4',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'我的原有日程保持不变', @pContentEnglish = N'My schedule remains the same for the time not defined above'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Todaysch_4',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Meine ursprüngliche Zeitplan bleibt unverändert', @pContentEnglish = N'My schedule remains the same for the time not defined above'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Todaysch_4',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'MI HORARIO SIGUE SIENDO EL MISMO, POR EL MOMENTO NO SE HA DEFINIDO ANTERIORMENTE', @pContentEnglish = N'My schedule remains the same for the time not defined above'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Todaysch_4',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'我的原有日程保持不變', @pContentEnglish = N'My schedule remains the same for the time not defined above'


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'Todaysch_4'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'Todaysch_4'
) order by SystemLanguageId, Id desc

go

