EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'promoadd',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'添加优惠码', @pContentEnglish = N'Add promo code'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'promoadd',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Promo-Code hinzu', @pContentEnglish = N'Add promo code'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go

