EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'invite_phone',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'输入电话号码以邀请', @pContentEnglish = N'Type in phone number to invite'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'invite_phone',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Geben Sie die Telefonnummer ein, um sie einzuladen', @pContentEnglish = N'Type in phone number to invite'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go