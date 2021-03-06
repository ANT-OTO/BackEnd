use weyi
declare @CompanyId int = 0
select @CompanyId = a.Id
--select *
from WEYIMgr.dbo.Company a where CompanyCode = 'WEYIVideo2'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Client', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 2,
				@pContentInSystemLanguage = N'WEYI Video 2 客户端', @pContentEnglish = N'WEYI Video 2 Client'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Client', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 14,
				@pContentInSystemLanguage = N'WEYI Video 2 Kunde', @pContentEnglish = N'WEYI Video 2 Client'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Provider', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 2,
				@pContentInSystemLanguage = N'WEYI Video 2 译员端', @pContentEnglish = N'WEYI Video 2 Interpreter'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Provider', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 14,
				@pContentInSystemLanguage = N'WEYI Video 2 Dolmetscher ', @pContentEnglish = N'WEYI Video 2 Interpreter'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Manager', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 2,
				@pContentInSystemLanguage = N'WEYI Video 2 远程视频翻译管理', @pContentEnglish = N'WEYI Video 2 Remote Interpretation Management'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Manager', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 14,
				@pContentInSystemLanguage = N'WEYI Video 2 Remote Interpretation Management', @pContentEnglish = N'WEYI Video 2 Remote Interpretation Management'

--select * from Test.dbo.UILanguageCustomization where SystemLanguageId = 14

select top 100 * from UIElementCompany order by Id desc
select top 100 * from UIElementCompanyY order by Id desc

go

