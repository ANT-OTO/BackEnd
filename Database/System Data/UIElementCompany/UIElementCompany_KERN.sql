use weyi
declare @CompanyId int = 0
select @CompanyId = a.Id
--select *
from WEYIMgr.dbo.Company a where CompanyCode = 'KERN'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Client', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 2,
				@pContentInSystemLanguage = N'KERN 客户端', @pContentEnglish = N'KERN Client'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Client', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 14,
				@pContentInSystemLanguage = N'KERN Kunde', @pContentEnglish = N'KERN Client'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Provider', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 2,
				@pContentInSystemLanguage = N'KERN 译员端', @pContentEnglish = N'KERN Interpreter'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Provider', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 14,
				@pContentInSystemLanguage = N'KERN Dolmetscher', @pContentEnglish = N'KERN Interpreter'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Manager', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 2,
				@pContentInSystemLanguage = N'KERN 远程视频翻译管理', @pContentEnglish = N'KERN Remote Video Interpretation Management'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Manager', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 14,
				@pContentInSystemLanguage = N'KERN Remote Video Interpretation Management', @pContentEnglish = N'KERN Remote Video Interpretation Management'

--select * from Test.dbo.UILanguageCustomization where SystemLanguageId = 14

select top 100 * from UIElementCompany order by Id desc
select top 100 * from UIElementCompanyY order by Id desc

go
