EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportAgreement_1',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'同意', @pContentEnglish = N'Agree'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportAgreement_1',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Zustimmen', @pContentEnglish = N'Agree'


-----------------------------------------------------------------------------------------------------------------------------------

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportAgreement_2',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'以后决定', @pContentEnglish = N'Later'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportAgreement_2',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Später', @pContentEnglish = N'Later'


-----------------------------------------------------------------------------------------------------------------------------------



select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go

