
/****** Object:  Table [dbo].[Language]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
Begin
	/*
alter table [LanguageY] drop constraint [FK_LanguageY_Language]
alter table [PersonLanguage] drop constraint [FK_PersonLanguage_Language]
alter table [ProviderLanguage] drop constraint [FK_ProviderLanguage_Language]
alter table [ProviderService] drop constraint [FK_ProviderService_LanguageId1]
alter table [ProviderService] drop constraint [FK_ProviderService_LanguageId2]

	DROP TABLE [dbo].[Language]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'Language')
	)
	

	declare @TblName as nvarchar(64) = 'Language'
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
	print 'you need to manually exec DROP TABLE [dbo].[Language] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[Language](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EnglishName] [varchar](256) NOT NULL,
	[Available] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



ALTER TABLE [dbo].[Language] ADD  CONSTRAINT [DF_Language_Available]  DEFAULT (1) FOR [Available]

ALTER TABLE [dbo].[Language] ADD  CONSTRAINT [DF_Language_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

-------------------------- End Foreign Key ---------------------------------------------------------------


-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LanguageY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_LanguageY_Language]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[LanguageY]  WITH CHECK ADD  CONSTRAINT [FK_LanguageY_Language] FOREIGN KEY([LanguageId])
	REFERENCES [dbo].[Language] ([Id])

	ALTER TABLE [dbo].[LanguageY] CHECK CONSTRAINT [FK_LanguageY_Language]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonLanguage]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonLanguage_Language]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonLanguage]  WITH CHECK ADD  CONSTRAINT [FK_PersonLanguage_Language] FOREIGN KEY([LanguageId])
	REFERENCES [dbo].[Language] ([Id])

	ALTER TABLE [dbo].[PersonLanguage] CHECK CONSTRAINT [FK_PersonLanguage_Language]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderLanguage]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderLanguage_Language]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderLanguage]  WITH CHECK ADD  CONSTRAINT [FK_ProviderLanguage_Language] FOREIGN KEY([LanguageId])
	REFERENCES [dbo].[Language] ([Id])

	ALTER TABLE [dbo].[ProviderLanguage] CHECK CONSTRAINT [FK_ProviderLanguage_Language]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderService]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderService_LanguageId1]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderService]  WITH CHECK ADD  CONSTRAINT [FK_ProviderService_LanguageId1] FOREIGN KEY([LanguageId1])
	REFERENCES [dbo].[Language] ([Id])

	ALTER TABLE [dbo].[ProviderService] CHECK CONSTRAINT [FK_ProviderService_LanguageId1]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderService]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderService_LanguageId2]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderService]  WITH CHECK ADD  CONSTRAINT [FK_ProviderService_LanguageId2] FOREIGN KEY([LanguageId2])
	REFERENCES [dbo].[Language] ([Id])

	ALTER TABLE [dbo].[ProviderService] CHECK CONSTRAINT [FK_ProviderService_LanguageId2]
end


-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------

select * from [Language]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())

/****** Object:  Index [IX_Language_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND name = N'IX_Language_1')
DROP INDEX [IX_Language_1] ON [dbo].[Language]
GO




/****** Object:  Index [IX_Language_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_Language_1] ON [dbo].[Language]
(
	[EnglishName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
