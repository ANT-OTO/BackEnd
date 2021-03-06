EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineOffReasonDetail_label',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'备注', @pContentEnglish = N'Detail'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineOffReasonDetail_label',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'備註', @pContentEnglish = N'Detail'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineOffReasonDetail_label',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'Detalle', @pContentEnglish = N'Detail'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineOffReasonDetail_label',	@pSystemLanguageId = 14,		-- de		--select * from SystemLanguage
	@pContentInSystemLanguage = N'Bemerkung', @pContentEnglish = N'Detail'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'ProviderOnlineOffReasonDetail_label'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'ProviderOnlineOffReasonDetail_label'
) order by SystemLanguageId, Id desc


--select * from UIElement where ElementKey like 'Dashboard%'

go
