EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'product_select',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'您所选产品', @pContentEnglish = N'Your Product'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'product_select',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Ihr Produkt Ihr Produkt', @pContentEnglish = N'Your Product'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go

