EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportProductList_1',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'产品列表', @pContentEnglish = N'Product List'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportProductList_1',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Produkte Liste', @pContentEnglish = N'Product List'


-----------------------------------------------------------------------------------------------------------------------------------

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportProductList_2',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'语言： ', @pContentEnglish = N'Language Pair: '

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportProductList_2',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Sprachpaar: ', @pContentEnglish = N'Language Pair: '


-----------------------------------------------------------------------------------------------------------------------------------

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportProductList_3',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'English 到 Chinese', @pContentEnglish = N'English to Chinese'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportProductList_3',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'English auf Chinese', @pContentEnglish = N'English to Chinese'

-----------------------------------------------------------------------------------------------------------------------------------

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportProductList_4',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'产品： ', @pContentEnglish = N'Product: '

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportProductList_4',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Produkt: ', @pContentEnglish = N'Product: '


-----------------------------------------------------------------------------------------------------------------------------------

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportProductList_5',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'确认', @pContentEnglish = N'Confirm'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportProductList_5',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Bestätigen', @pContentEnglish = N'Confirm'

	
-----------------------------------------------------------------------------------------------------------------------------------

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportProductList_6',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'语言 1: ', @pContentEnglish = N'Source Language: '

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportProductList_6',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Sprache 1: ', @pContentEnglish = N'Source Language: '

-----------------------------------------------------------------------------------------------------------------------------------

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportProductList_7',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'语言 2: ', @pContentEnglish = N'Requested Language: '

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportProductList_7',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Sprache 2: ', @pContentEnglish = N'Requested Language: '

-----------------------------------------------------------------------------------------------------------------------------------

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportProductList_8',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'您的余额是： ', @pContentEnglish = N'You have credit: '

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportProductList_8',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Du hast kredit: ', @pContentEnglish = N'You have credit: '


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go

