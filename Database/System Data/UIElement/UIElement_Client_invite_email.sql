EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'invite_email',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'输入电子邮箱以邀请', @pContentEnglish = N'Type in email to invite'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'invite_email',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Geben Sie die E-Mail ein, um sie einzuladen', @pContentEnglish = N'Type in email to invite'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go