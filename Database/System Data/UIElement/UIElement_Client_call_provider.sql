EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'call_provider',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'呼叫译员中...', @pContentEnglish = N'calling provider...'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'call_provider',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Anrufanbieter...', @pContentEnglish = N'calling provider...'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go

