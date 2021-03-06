EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineOffReasonDetailHint_label',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'请输入此次动作备注', @pContentEnglish = N'Please enter some detail about this action'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineOffReasonDetailHint_label',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'請輸入此次動作備註', @pContentEnglish = N'Please enter some detail about this action'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineOffReasonDetailHint_label',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'Por favor, introduzca las Observaciones de acción', @pContentEnglish = N'Please enter some detail about this action'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineOffReasonDetailHint_label',	@pSystemLanguageId = 14,		-- de		--select * from SystemLanguage
	@pContentInSystemLanguage = N'Bitte geben Sie einige Details über diese Aktion', @pContentEnglish = N'Please enter some detail about this action'


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'ProviderOnlineOffReasonDetailHint_label'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'ProviderOnlineOffReasonDetailHint_label'
) order by SystemLanguageId, Id desc


--select * from UIElement where ElementKey like 'Dashboard%'

go
