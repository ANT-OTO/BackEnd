EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'video_txt_showme',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'重启视频', @pContentEnglish = N'Show Me'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'video_txt_showme',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Video anzeigen', @pContentEnglish = N'Show Me'


-----------------------------------------------------------------------------------------------------------------------------------


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go

