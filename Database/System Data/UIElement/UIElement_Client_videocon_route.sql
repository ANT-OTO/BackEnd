EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'videocon_route',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'正在接入会议', @pContentEnglish = N'Routing to conference'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'videocon_route',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Routing zur Konferenz', @pContentEnglish = N'Routing to conference'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go