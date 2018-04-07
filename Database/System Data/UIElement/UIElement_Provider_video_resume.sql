EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'video_resume',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'继续视频传输', @pContentEnglish = N'has resumed video'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'video_resume',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Hat Video wieder aufgenommen', @pContentEnglish = N'has resumed video'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go