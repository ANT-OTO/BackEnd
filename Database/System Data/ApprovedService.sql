EXEC	[dbo].[sp_ApprovedService_Generate]


select a.*, b.[EnglishName] as Language1Name, c.[EnglishName] as Language2Name from ApprovedService a
	inner join [Language] b on a.LanguageId1 = b.Id
	inner join [Language] c on a.LanguageId2 = c.Id
