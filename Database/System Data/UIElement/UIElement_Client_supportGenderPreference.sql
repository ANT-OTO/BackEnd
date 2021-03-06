EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportGenderPreference_1',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'对于翻译的性别选择', @pContentEnglish = N'Gender Preference'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportGenderPreference_1',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Dolmetscher-Eigenschaften', @pContentEnglish = N'Gender Preference'


-----------------------------------------------------------------------------------------------------------------------------------

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportGenderPreference_2',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'存盘成功', @pContentEnglish = N'Save Successful'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportGenderPreference_2',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Erfolgreich speichern', @pContentEnglish = N'Save Successful'


-----------------------------------------------------------------------------------------------------------------------------------

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportGenderPreference_3',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'请再试一次', @pContentEnglish = N'Please Try Again'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'supportGenderPreference_3',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Bitte versuche es erneut', @pContentEnglish = N'Please Try Again'


-----------------------------------------------------------------------------------------------------------------------------------


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go

