EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'join_meeting',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'加入会议', @pContentEnglish = N'joined the conference'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'join_meeting',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Trat der Konferenz bei', @pContentEnglish = N'joined the conference'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go