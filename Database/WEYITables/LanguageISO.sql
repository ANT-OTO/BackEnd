
/****** Object:  Table [dbo].[LanguageISO]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LanguageISO]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[LanguageISO]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'LanguageISO')
	)	
	

	declare @TblName as nvarchar(64) = 'LanguageISO'
	select distinct '
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].[' + @TblName + ']'') AND type in (N''U''))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].[' + b.name + ']'') AND type in (N''U''))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].[' + a.name + ']'') AND type in (N''F''))
begin
	ALTER TABLE [dbo].[' + b.name + ']  WITH CHECK ADD  CONSTRAINT [' + a.name + '] FOREIGN KEY([' + c.ColumnName + '])
	REFERENCES [dbo].[' + @TblName + '] ([Id])

	ALTER TABLE [dbo].[' + b.name + '] CHECK CONSTRAINT [' + a.name + ']
end
'
	--select b.name as TableName, a.name as FKName, c.ColumnName
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
		inner join (   select fk.constraint_object_id, c.name as ColumnName from sys.foreign_key_columns as fk inner join sys.columns c on fk.parent_object_id = c.object_id and fk.parent_column_id = c.column_id
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = @TblName)
	) c on a.object_id = c.constraint_object_id				
	 	
	*/
	
	print 'you need to manually exec DROP TABLE [dbo].[LanguageISO] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[LanguageISO](
	[Id] [int] IDENTITY(1,1) NOT NULL,

	[LanguageId] [int] NULL,

	[LanguageFamily] [nvarchar](32) NULL,
	[LanguageName] [nvarchar](128) NULL,
	[NativeName] [nvarchar](128) NULL,
	[639_1] [nvarchar](8) NULL,
	[639_2T] [nvarchar](8) NULL,
	[639_2B] [nvarchar](8) NULL,
	[639_3] [nvarchar](8) NULL,
	[639_6] [nvarchar](8) NULL,
	[Notes] [nvarchar](max) NULL,
	[SubLanguageCnt] [int] NULL,
	[ParentLanguageId] [int] NULL,

	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_LanguageISO] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[LanguageISO] ADD  CONSTRAINT [DF_LanguageISO_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LanguageISO]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_LanguageISO_Language]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[LanguageISO]  WITH CHECK ADD  CONSTRAINT [FK_LanguageISO_Language] FOREIGN KEY([LanguageId])
	REFERENCES [dbo].[Language] ([Id])

	ALTER TABLE [dbo].[LanguageISO] CHECK CONSTRAINT [FK_LanguageISO_Language]
end

-------------------------- End Foreign Key ---------------------------------------------------------------

-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------

select * from [LanguageISO]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_LanguageISO_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LanguageISO]') AND name = N'IX_LanguageISO_1')
DROP INDEX [IX_LanguageISO_1] ON [dbo].[LanguageISO]
GO




/****** Object:  Index [IX_LanguageISO_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_LanguageISO_1] ON [dbo].[LanguageISO]
(
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




/****** Object:  Index [IX_LanguageISO_2]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LanguageISO]') AND name = N'IX_LanguageISO_2')
DROP INDEX [IX_LanguageISO_2] ON [dbo].[LanguageISO]
GO




/****** Object:  Index [IX_LanguageISO_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_LanguageISO_2] ON [dbo].[LanguageISO]
(
	[639_1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO





/****** Object:  Index [IX_LanguageISO_3]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LanguageISO]') AND name = N'IX_LanguageISO_3')
DROP INDEX [IX_LanguageISO_3] ON [dbo].[LanguageISO]
GO




/****** Object:  Index [IX_LanguageISO_3]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_LanguageISO_3] ON [dbo].[LanguageISO]
(
	[639_3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




---------------------------------------------------------------End Index------------------------------------------------------------------



/*


update a
set a.EnglishName = 'Slovenian'
--select *
from [Language] a
where a.EnglishName = 'Slovenia' 

update a
set a.EnglishName = 'Croatian'
--select *
from [Language] a
where a.EnglishName = 'Crotian'

update a
set a.Available = 0
--select *
from [Language] a
where a.EnglishName = 'Filipino'



--select * from LanguageISO

insert into LanguageISO
(LanguageFamily,LanguageName,NativeName,[639_1],[639_2T],[639_2B],[639_3],[639_6],Notes,SubLanguageCnt,CreateDate)
select [Language family],[Language name],[Native name],[639-1],[639-2 T],[639-2 B],[639-3],[639-6],Notes,Additional
	,GETUTCDATE()
--select *
from Test.dbo.Language a where a.[639-3] not in (select [639_3] from LanguageISO)

insert into LanguageISO
(LanguageName,[639_3], ParentLanguageId,CreateDate)
select a.Ref_Name, a.Id, c.Id
	,GETUTCDATE()
--select *
from [Test].[dbo].[iso-639-3_20150330] a inner join [Test].[dbo].[iso-639-3-macrolanguages_20150112] b on a.Id = b.I_Id
	inner join LanguageISO c on b.M_Id = c.[639_3]
where a.Id not in (select [639_3] from LanguageISO)


update b
set b.LanguageId = a.Id
--select *
from [Language] a inner join LanguageISO b on a.EnglishName = b.LanguageName
where b.LanguageId is null or b.LanguageId <> a.Id

update b
set b.LanguageId = a.Id
--select *
from [Language] a inner join LanguageISO b on a.EnglishName = 'Bengali' and b.LanguageName = 'Bengali, Bangla'
where b.LanguageId is null or b.LanguageId <> a.Id

update b
set b.LanguageId = a.Id
--select *
from [Language] a inner join LanguageISO b on a.EnglishName = 'Chinese Cantonese' and b.LanguageName = 'Yue Chinese'
where b.LanguageId is null or b.LanguageId <> a.Id



update b
set b.LanguageId = a.Id
--select *
from [Language] a inner join LanguageISO b on a.EnglishName = 'Hebrew' and b.LanguageName = 'Hebrew (modern)'
where b.LanguageId is null or b.LanguageId <> a.Id

update b
set b.LanguageId = a.Id
--select *
from [Language] a inner join LanguageISO b on a.EnglishName = 'Persian' and b.LanguageName = 'Persian (Farsi)'
where b.LanguageId is null or b.LanguageId <> a.Id


update b
set b.LanguageId = a.Id
--select *
from [Language] a inner join LanguageISO b on a.EnglishName = 'South Africa Zulu' and b.LanguageName = 'Zulu'
where b.LanguageId is null or b.LanguageId <> a.Id


update b
set b.LanguageId = a.Id
--select *
from [Language] a inner join LanguageISO b on a.EnglishName = 'Indonesian Javanese' and b.LanguageName = 'Javanese'
where b.LanguageId is null or b.LanguageId <> a.Id




update b
set b.LanguageId = a.Id
--select *
from [Language] a inner join LanguageISO b on a.EnglishName = 'Slovenian' and b.LanguageName = 'Slovene'
where b.LanguageId is null or b.LanguageId <> a.Id


select *
from [Language] a left join LanguageISO b on a.Id = b.LanguageId
where b.Id is null


select * from LanguageISO where LanguageName like '%Slovene%'
select * from [Test].[dbo].[iso-639-3_20150330] where Ref_Name like '%Slov%'

--select b.LanguageName
--from LanguageISO b
--group by b.LanguageName
--having count(1) > 1

*/