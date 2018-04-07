EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'leave_meeting',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'离开会议', @pContentEnglish = N'left the conference'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'leave_meeting',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Verließ die Konferenz', @pContentEnglish = N'left the conference'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go