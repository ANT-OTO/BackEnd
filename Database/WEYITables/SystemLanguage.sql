
/****** Object:  Table [dbo].[SystemLanguage]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemLanguage]') AND type in (N'U'))
Begin
	/*
	
alter table [CodeListY] drop constraint [FK_CodeListY_SystemLanguage]
alter table [DescrTemplateY] drop constraint [FK_DescrTemplateY_SystemLanguage]
alter table [ErrorMsgY] drop constraint [FK_ErrorMsgY_SystemLanguage]
alter table [EvalQuestionY] drop constraint [FK_EvalQuestionY_SystemLanguage]
alter table [FAQY] drop constraint [FK_FAQY_SystemLanguage]
alter table [LanguageY] drop constraint [FK_LanguageY_SystemLanguage]
alter table [MsgTemplateY] drop constraint [FK_MsgTemplateY_SystemLanguage]
alter table [NotificationPush] drop constraint [FK_NotificationPush_SystemLanguage]
alter table [NotificationText] drop constraint [FK_NotificationText_SystemLanguage]
alter table [PersonSession] drop constraint [FK_PersonSession_SystemLanguage]
alter table [ProviderSession] drop constraint [FK_ProviderSession_SystemLanguage]
alter table [RegionY] drop constraint [FK_RegionY_SystemLanguage]
alter table [UIElementY] drop constraint [FK_UIElementY_SystemLanguage]

	DROP TABLE [dbo].[SystemLanguage]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'SystemLanguage')
	)	
	

	declare @TblName as nvarchar(64) = 'SystemLanguage'
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
	
	
	print 'you need to manually exec DROP TABLE [dbo].[SystemLanguage] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[SystemLanguage](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[LanguageCode] [nvarchar](8) NOT NULL,
	[Available] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SystemLanguage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



ALTER TABLE [dbo].[SystemLanguage] ADD  CONSTRAINT [DF_SystemLanguage_Available]  DEFAULT (1) FOR [Available]
ALTER TABLE [dbo].[SystemLanguage] ADD  CONSTRAINT [DF_SystemLanguage_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------


-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemLanguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CodeListY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_CodeListY_SystemLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[CodeListY]  WITH CHECK ADD  CONSTRAINT [FK_CodeListY_SystemLanguage] FOREIGN KEY([SystemLanguageId])
	REFERENCES [dbo].[SystemLanguage] ([Id])

	ALTER TABLE [dbo].[CodeListY] CHECK CONSTRAINT [FK_CodeListY_SystemLanguage]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemLanguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DescrTemplateY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DescrTemplateY_SystemLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DescrTemplateY]  WITH CHECK ADD  CONSTRAINT [FK_DescrTemplateY_SystemLanguage] FOREIGN KEY([SystemLanguageId])
	REFERENCES [dbo].[SystemLanguage] ([Id])

	ALTER TABLE [dbo].[DescrTemplateY] CHECK CONSTRAINT [FK_DescrTemplateY_SystemLanguage]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemLanguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ErrorMsgY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ErrorMsgY_SystemLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ErrorMsgY]  WITH CHECK ADD  CONSTRAINT [FK_ErrorMsgY_SystemLanguage] FOREIGN KEY([SystemLanguageId])
	REFERENCES [dbo].[SystemLanguage] ([Id])

	ALTER TABLE [dbo].[ErrorMsgY] CHECK CONSTRAINT [FK_ErrorMsgY_SystemLanguage]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemLanguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EvalQuestionY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_EvalQuestionY_SystemLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[EvalQuestionY]  WITH CHECK ADD  CONSTRAINT [FK_EvalQuestionY_SystemLanguage] FOREIGN KEY([SystemLanguageId])
	REFERENCES [dbo].[SystemLanguage] ([Id])

	ALTER TABLE [dbo].[EvalQuestionY] CHECK CONSTRAINT [FK_EvalQuestionY_SystemLanguage]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemLanguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAQY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_FAQY_SystemLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[FAQY]  WITH CHECK ADD  CONSTRAINT [FK_FAQY_SystemLanguage] FOREIGN KEY([SystemLanguageId])
	REFERENCES [dbo].[SystemLanguage] ([Id])

	ALTER TABLE [dbo].[FAQY] CHECK CONSTRAINT [FK_FAQY_SystemLanguage]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemLanguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LanguageY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_LanguageY_SystemLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[LanguageY]  WITH CHECK ADD  CONSTRAINT [FK_LanguageY_SystemLanguage] FOREIGN KEY([SystemLanguageId])
	REFERENCES [dbo].[SystemLanguage] ([Id])

	ALTER TABLE [dbo].[LanguageY] CHECK CONSTRAINT [FK_LanguageY_SystemLanguage]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemLanguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsgTemplateY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_MsgTemplateY_SystemLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[MsgTemplateY]  WITH CHECK ADD  CONSTRAINT [FK_MsgTemplateY_SystemLanguage] FOREIGN KEY([SystemLanguageId])
	REFERENCES [dbo].[SystemLanguage] ([Id])

	ALTER TABLE [dbo].[MsgTemplateY] CHECK CONSTRAINT [FK_MsgTemplateY_SystemLanguage]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemLanguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NotificationPush]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotificationPush_SystemLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[NotificationPush]  WITH CHECK ADD  CONSTRAINT [FK_NotificationPush_SystemLanguage] FOREIGN KEY([SystemLanguageId])
	REFERENCES [dbo].[SystemLanguage] ([Id])

	ALTER TABLE [dbo].[NotificationPush] CHECK CONSTRAINT [FK_NotificationPush_SystemLanguage]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemLanguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NotificationText]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotificationText_SystemLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[NotificationText]  WITH CHECK ADD  CONSTRAINT [FK_NotificationText_SystemLanguage] FOREIGN KEY([SystemLanguageId])
	REFERENCES [dbo].[SystemLanguage] ([Id])

	ALTER TABLE [dbo].[NotificationText] CHECK CONSTRAINT [FK_NotificationText_SystemLanguage]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemLanguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonSession]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonSession_SystemLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonSession]  WITH CHECK ADD  CONSTRAINT [FK_PersonSession_SystemLanguage] FOREIGN KEY([SystemLanguageId])
	REFERENCES [dbo].[SystemLanguage] ([Id])

	ALTER TABLE [dbo].[PersonSession] CHECK CONSTRAINT [FK_PersonSession_SystemLanguage]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemLanguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderSession]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderSession_SystemLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderSession]  WITH CHECK ADD  CONSTRAINT [FK_ProviderSession_SystemLanguage] FOREIGN KEY([SystemLanguageId])
	REFERENCES [dbo].[SystemLanguage] ([Id])

	ALTER TABLE [dbo].[ProviderSession] CHECK CONSTRAINT [FK_ProviderSession_SystemLanguage]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemLanguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RegionY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RegionY_SystemLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RegionY]  WITH CHECK ADD  CONSTRAINT [FK_RegionY_SystemLanguage] FOREIGN KEY([SystemLanguageId])
	REFERENCES [dbo].[SystemLanguage] ([Id])

	ALTER TABLE [dbo].[RegionY] CHECK CONSTRAINT [FK_RegionY_SystemLanguage]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemLanguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UIElementY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_UIElementY_SystemLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[UIElementY]  WITH CHECK ADD  CONSTRAINT [FK_UIElementY_SystemLanguage] FOREIGN KEY([SystemLanguageId])
	REFERENCES [dbo].[SystemLanguage] ([Id])

	ALTER TABLE [dbo].[UIElementY] CHECK CONSTRAINT [FK_UIElementY_SystemLanguage]
end

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from SystemLanguage
end

GO

SET ANSI_PADDING OFF
GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_SystemLanguage_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SystemLanguage]') AND name = N'IX_SystemLanguage_1')
DROP INDEX [IX_SystemLanguage_1] ON [dbo].[SystemLanguage]
GO




/****** Object:  Index [IX_SystemLanguage_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_SystemLanguage_1] ON [dbo].[SystemLanguage]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




/****** Object:  Index [IX_SystemLanguage_2]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SystemLanguage]') AND name = N'IX_SystemLanguage_2')
DROP INDEX [IX_SystemLanguage_2] ON [dbo].[SystemLanguage]
GO




/****** Object:  Index [IX_SystemLanguage_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_SystemLanguage_2] ON [dbo].[SystemLanguage]
(
	[LanguageCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---------------------------------------------------------------End Index------------------------------------------------------------------
