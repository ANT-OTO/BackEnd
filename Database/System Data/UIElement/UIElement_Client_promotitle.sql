EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'promotitle',	@pSystemLanguageId = 2,		-- 简体中文	zh-CN
	@pContentInSystemLanguage = N'我的优惠码', @pContentEnglish = N'My Promotions'

EXECUTE [dbo].[sp_UIElementSave] @pAppName = 'Client', 	@pElementKey = 'promotitle',	@pSystemLanguageId = 14,		-- de
	@pContentInSystemLanguage = N'Meine Promotionen', @pContentEnglish = N'My Promotions'

select top 10 * from UIElement order by Id desc
select top 10 * from UIElementY order by Id desc

go

