EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Provider_login',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'译员登录', @pContentEnglish = N'Provider Login'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Provider_login',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Sprachler Login', @pContentEnglish = N'Provider Login'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Provider_login',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'PROVEEDOR DE INICIO DE SESIÓN', @pContentEnglish = N'Provider Login'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'Provider_login',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'譯員登錄', @pContentEnglish = N'Provider Login'


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'Provider_login' and AppName = 'Provider'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'Provider_login' and AppName = 'Provider'
) order by SystemLanguageId, Id desc

go

