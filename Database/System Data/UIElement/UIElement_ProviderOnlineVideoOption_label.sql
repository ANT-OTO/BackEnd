EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineVideoOption_label',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'视频选项', @pContentEnglish = N'Video Option'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineVideoOption_label',	@pSystemLanguageId = 3,		-- zh-TW		--select * from SystemLanguage
	@pContentInSystemLanguage = N'視頻選項', @pContentEnglish = N'Video Option'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineVideoOption_label',	@pSystemLanguageId = 4,		-- es		--select * from SystemLanguage
	@pContentInSystemLanguage = N'Opción de vídeo', @pContentEnglish = N'Video Option'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'ProviderOnlineVideoOption_label',	@pSystemLanguageId = 14,		-- de		--select * from SystemLanguage
	@pContentInSystemLanguage = N'Video-Optionen', @pContentEnglish = N'Video Option'


select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

select * from UIElement where ElementKey = 'ProviderOnlineVideoOption_label'

select * from UIElementY where UIElementId in (
select Id from UIElement where ElementKey = 'ProviderOnlineVideoOption_label'
) order by SystemLanguageId, Id desc


--select * from UIElement where ElementKey like 'Dashboard%'

go
