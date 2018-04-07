EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'invite',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'邀请', @pContentEnglish = N'Invite'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'invite',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Einladen', @pContentEnglish = N'Invite'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go