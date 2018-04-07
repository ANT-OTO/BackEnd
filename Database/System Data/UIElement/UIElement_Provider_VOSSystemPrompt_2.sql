EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'VOSSystemPrompt_2',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'好的。我是您的&ttt&翻译。请问我有什么可以帮到您？您是否需要邀请第三方进行语音会议？', @pContentEnglish = N'OK. I am your &ttt& interpreter. How may I help you? Do you need third party conference?'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Provider', 	@pElementKey = 'VOSSystemPrompt_2',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'OK. Ich bin dein &ttt& Dolmetscher. Wie kann ich dir helfen? Brauchen Sie Drittkonferenz?', @pContentEnglish = N'OK. I am your &ttt& interpreter. How may I help you? Do you need third party conference?'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go