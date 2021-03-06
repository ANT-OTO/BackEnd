EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Dashboard_4',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'显示摄像', @pContentEnglish = N'View Self'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Dashboard_4',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Kamera Anzeigen', @pContentEnglish = N'View Self'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Dashboard_4',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'Mostrar Cámara', @pContentEnglish = N'View Self'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Dashboard_4',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'顯示攝像', @pContentEnglish = N'View Self'


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'Dashboard_4'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'Dashboard_4'
) order by SystemLanguageId, Id desc


--select * from UIElement where ElementKey like 'Dashboard%'

go
