use weyi
declare @CompanyId int = 0
select @CompanyId = a.Id
--select *
from WEYIMgr.dbo.Company a where CompanyCode = 'UbiqusDemo'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Client', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 2,
				@pContentInSystemLanguage = N'UbiqusDemo 客户端', @pContentEnglish = N'UbiqusDemo Client'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Client', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 14,
				@pContentInSystemLanguage = N'UbiqusDemo Kunde', @pContentEnglish = N'UbiqusDemo Client'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Provider', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 2,
				@pContentInSystemLanguage = N'UbiqusDemo 译员端', @pContentEnglish = N'UbiqusDemo Interpreter'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Provider', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 14,
				@pContentInSystemLanguage = N'UbiqusDemo Dolmetscher', @pContentEnglish = N'UbiqusDemo Interpreter'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Manager', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 2,
				@pContentInSystemLanguage = N'UbiqusDemo 远程视频翻译管理', @pContentEnglish = N'UbiqusDemo Remote Video Interpretation Management'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Manager', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 14,
				@pContentInSystemLanguage = N'UbiqusDemo Remote Video Interpretation Management', @pContentEnglish = N'UbiqusDemo Remote Video Interpretation Management'

--select * from Test.dbo.UILanguageCustomization where SystemLanguageId = 14

select top 100 * from UIElementCompany order by Id desc
select top 100 * from UIElementCompanyY order by Id desc

go
