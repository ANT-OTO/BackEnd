EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'VideoFullScreen',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'全屏', @pContentEnglish = N'Full'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'VideoFullScreen',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Vollbild', @pContentEnglish = N'Full'


-----------------------------------------------------------------------------------------------------------------------------------

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Video_Status1',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'正在建立视频连接。。。', @pContentEnglish = N'Establishing Video connection...'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Video_Status1',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Video-Verbindung aufbauen ...', @pContentEnglish = N'Establishing Video connection...'


-----------------------------------------------------------------------------------------------------------------------------------


EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Video_Status2',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'就快连上了。。。', @pContentEnglish = N'Almost there ...'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Video_Status2',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Fast dort ...', @pContentEnglish = N'Almost there ...'


-----------------------------------------------------------------------------------------------------------------------------------


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go

