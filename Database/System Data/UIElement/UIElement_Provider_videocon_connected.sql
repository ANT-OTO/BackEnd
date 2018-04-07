EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'videocon_connected',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'会议中', @pContentEnglish = N'In conference'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'videocon_connected',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'In der Konferenz', @pContentEnglish = N'In conference'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

goe