ALTER TABLE [RegionY] ADD [SortCode] [varchar](256)
go

--select * from [RegionY]

update a
set a.SortCode = b.[name]
--select *
from [RegionY] a  inner join Region b on a.RegionId = b.Id
where a.SortCode is null

go

ALTER TABLE [RegionY] ALTER COLUMN [SortCode] [varchar](256) NOT NULL
go



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_RegionY_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RegionY]') AND name = N'IX_RegionY_2')
DROP INDEX [IX_RegionY_2] ON [dbo].[RegionY]
GO




/****** Object:  Index [IX_RegionY_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_RegionY_2] ON [dbo].[RegionY]
(
	[SystemLanguageId] ASC,
	[SortCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
