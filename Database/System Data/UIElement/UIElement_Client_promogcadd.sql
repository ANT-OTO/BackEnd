EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'promogcadd',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'添加优惠码或礼品卡', @pContentEnglish = N'Add promo code/gift card'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'promogcadd',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Fügen Sie Promo-Code / Geschenkkarte hinzu', @pContentEnglish = N'Add promo code/gift card'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go

