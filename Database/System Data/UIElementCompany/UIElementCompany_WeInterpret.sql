use weyi
declare @CompanyId int = 0
select @CompanyId = a.Id
--select *
from WEYIMgr.dbo.Company a where CompanyCode = 'WeInterpret'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Client', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 2,
				@pContentInSystemLanguage = N'WeInterpret 客户端', @pContentEnglish = N'WeInterpret Client'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Client', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 14,
				@pContentInSystemLanguage = N'WeInterpret Kunde', @pContentEnglish = N'WeInterpret Client'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Provider', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 2,
				@pContentInSystemLanguage = N'WeInterpret 译员端', @pContentEnglish = N'WeInterpret Interpreter'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Provider', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 14,
				@pContentInSystemLanguage = N'WeInterpret Dolmetscher', @pContentEnglish = N'WeInterpret Interpreter'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Manager', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 2,
				@pContentInSystemLanguage = N'WeInterpret 远程视频翻译管理', @pContentEnglish = N'WeInterpret Remote Video Interpretation Management'

EXECUTE [dbo].[sp_UIElementCompanySave] @pCompanyId = @CompanyId, @pAppName = 'Manager', 	@pElementKey = N'App_Title',	@pSystemLanguageId = 14,
				@pContentInSystemLanguage = N'WeInterpret Remote Video Interpretation Management', @pContentEnglish = N'WeInterpret Remote Video Interpretation Management'

--select * from Test.dbo.UILanguageCustomization where SystemLanguageId = 14

select top 100 * from UIElementCompany order by Id desc
select top 100 * from UIElementCompanyY order by Id desc

go
