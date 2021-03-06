EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'Mainview_2',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'点击下方图标', @pContentEnglish = N'Click an icon below'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'Mainview_2',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Klicken Sie auf die Schaltfläche unten', @pContentEnglish = N'Click an icon below'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'Mainview_2',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'Presione el botón inferior', @pContentEnglish = N'Click an icon below'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'Mainview_2',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'點擊下方圖標', @pContentEnglish = N'Click an icon below'


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'Mainview_2'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'Mainview_2'
) order by SystemLanguageId, Id desc

go

