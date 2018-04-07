EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'videocon_disconnect',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'已离开会议', @pContentEnglish = N'Left Conference'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'videocon_disconnect',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Verlassen Sie die Konferenz', @pContentEnglish = N'Left Conference'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go