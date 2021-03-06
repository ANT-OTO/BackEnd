EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineOffEstimateTime_label',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'预估离线时间', @pContentEnglish = N'Estimated Off Time'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineOffEstimateTime_label',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'預估離線時間', @pContentEnglish = N'Estimated Off Time'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineOffEstimateTime_label',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'Tiempo estimado de apagado', @pContentEnglish = N'Estimated Off Time'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineOffEstimateTime_label',	@pSystemLanguageId = 14,		-- de		--select * from SystemLanguage
	@pContentInSystemLanguage = N'Geschätzte Zeit aus', @pContentEnglish = N'Estimated Off Time'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'ProviderOnlineOffEstimateTime_label'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'ProviderOnlineOffEstimateTime_label'
) order by SystemLanguageId, Id desc


--select * from UIElement where ElementKey like 'Dashboard%'

go
