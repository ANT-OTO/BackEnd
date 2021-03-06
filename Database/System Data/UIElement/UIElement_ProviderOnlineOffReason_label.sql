EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineOffReason_label',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'原因', @pContentEnglish = N'Reason'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineOffReason_label',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'原因', @pContentEnglish = N'Reason'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineOffReason_label',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'Razón', @pContentEnglish = N'Reason'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineOffReason_label',	@pSystemLanguageId = 14,		-- de		--select * from SystemLanguage
	@pContentInSystemLanguage = N'Grund', @pContentEnglish = N'Reason'


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'ProviderOnlineOffReason_label'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'ProviderOnlineOffReason_label'
) order by SystemLanguageId, Id desc


--select * from UIElement where ElementKey like 'Dashboard%'

go
