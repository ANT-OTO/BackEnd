EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Dashboard_5',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'关闭摄像', @pContentEnglish = N'Close Camera'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Dashboard_5',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Kamera Schließen', @pContentEnglish = N'Close Camera'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Dashboard_5',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'Cerrar la Cámara', @pContentEnglish = N'Close Camera'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Dashboard_5',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'關閉攝像', @pContentEnglish = N'Close Camera'


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'Dashboard_5'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'Dashboard_5'
) order by SystemLanguageId, Id desc


--select * from UIElement where ElementKey like 'Dashboard%'

go
