EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'video_status_pause',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'暂停视频传输', @pContentEnglish = N'has paused video'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'video_status_pause',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Hat Video angehalten', @pContentEnglish = N'has paused video'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go