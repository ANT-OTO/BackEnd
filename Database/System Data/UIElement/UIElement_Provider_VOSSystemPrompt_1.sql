EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'VOSSystemPrompt_1',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'我的名字是&ttt&。请问您需要什么语言的服务？', @pContentEnglish = N'My name is &ttt&. What language do you need?'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'VOSSystemPrompt_1',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Mein Name ist &ttt&. Welche Sprache brauchst du?', @pContentEnglish = N'My name is &ttt&. What language do you need?'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go