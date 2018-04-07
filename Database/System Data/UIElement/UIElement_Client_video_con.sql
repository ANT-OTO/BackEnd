EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'video_con',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'视频会议', @pContentEnglish = N'Video Conference'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'video_con',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Videokonferenz', @pContentEnglish = N'Video Conference'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go