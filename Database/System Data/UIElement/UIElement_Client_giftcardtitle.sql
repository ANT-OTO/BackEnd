EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'giftcardtitle',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'我的礼品卡', @pContentEnglish = N'My Gift Cards'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'giftcardtitle',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Meine Geschenkkarten', @pContentEnglish = N'My Gift Cards'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go

