EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'in_conference',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'会议', @pContentEnglish = N'Conference'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'in_conference',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'der Konferenz', @pContentEnglish = N'Conference'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go
