use weyi
declare @CompanyId int = 0
select @CompanyId = a.Id
--select *
from WEYIMgr.dbo.Company a where CompanyCode = 'DrTranslate'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Client', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 2,
				@pContentInSystemLanguage = N'DrTranslate 客户端', @pContentEnglish = N'DrTranslate Client'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Client', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 14,
				@pContentInSystemLanguage = N'DrTranslate Kunde', @pContentEnglish = N'DrTranslate Client'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Provider', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 2,
				@pContentInSystemLanguage = N'DrTranslate 译员端', @pContentEnglish = N'DrTranslate Interpreter'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Provider', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 14,
				@pContentInSystemLanguage = N'DrTranslate Dolmetscher', @pContentEnglish = N'DrTranslate Interpreter'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Manager', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 2,
				@pContentInSystemLanguage = N'DrTranslate 远程视频翻译管理', @pContentEnglish = N'DrTranslate Remote Video Interpretation Management'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Manager', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 14,
				@pContentInSystemLanguage = N'DrTranslate Remote Video Interpretation Management', @pContentEnglish = N'DrTranslate Remote Video Interpretation Management'

--select * from Test.dbo.UILanguageCustomization where SystemLanguageId = 14

select top 100 * from UIElementCompany order by Id desc
select top 100 * from UIElementCompanyY order by Id desc

go
