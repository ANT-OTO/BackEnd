EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'giftcardadd',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'添加礼品卡', @pContentEnglish = N'Add gift card'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'giftcardadd',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Fügen Sie eine Geschenkkarte', @pContentEnglish = N'Add gift card'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go

