EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'video_txt_hideme',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'暂停视频', @pContentEnglish = N'Hide Me'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'video_txt_hideme',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Versteck mich', @pContentEnglish = N'Hide Me'


-----------------------------------------------------------------------------------------------------------------------------------


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go

