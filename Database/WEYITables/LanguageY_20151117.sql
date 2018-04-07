ALTER TABLE [LanguageY] ADD [SortCode] [varchar](256)
go



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_LanguageY_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LanguageY]') AND name = N'IX_LanguageY_2')
DROP INDEX [IX_LanguageY_2] ON [dbo].[LanguageY]
GO




/****** Object:  Index [IX_LanguageY_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_LanguageY_2] ON [dbo].[LanguageY]
(
	[SystemLanguageId] ASC,
	[SortCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------


--select * from [LanguageY]

update a
set a.SortCode = b.[EnglishName]
--select *
from [LanguageY] a  inner join Language b on a.LanguageId = b.Id
where a.SortCode is null

go

--ALTER TABLE [LanguageY] ALTER COLUMN [SortCode] [varchar](256) NOT NULL
--go