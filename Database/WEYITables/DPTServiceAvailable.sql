
/****** Object:  Table [dbo].[DPTServiceAvailable]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTServiceAvailable]') AND type in (N'U'))
Begin
	/*

	
	DROP TABLE [dbo].[DPTServiceAvailable]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'DPTServiceAvailable')
	)
	

	declare @TblName as nvarchar(64) = 'DPTServiceAvailable'
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
	print 'you need to manually exec DROP TABLE [dbo].[DPTServiceAvailable] ' + convert(varchar, getdate())
	
End
else
begin

--drop table [dbo].[DPTServiceAvailable]
CREATE TABLE [dbo].[DPTServiceAvailable](
	[Id] [int] IDENTITY(1,1) NOT NULL,

	[WebServerId] int NOT NULL,
	[LanguageId1] [int] NOT NULL,		-- DPTServiceAvailable Language 1
	[LanguageId2] [int] NOT NULL,		-- DPTServiceAvailable Language 2

	[ApprovedProviderCnt] [int] NOT NULL,
	[AvailableProviderCnt] [int] NOT NULL,
	[NotBusyProviderCnt] [int] NOT NULL,

	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,

 CONSTRAINT [PK_DPTServiceAvailable] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]




ALTER TABLE [dbo].[DPTServiceAvailable] ADD  CONSTRAINT [DF_DPTServiceAvailable_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[DPTServiceAvailable] ADD  CONSTRAINT [DF_DPTServiceAvailable_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebServer]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTServiceAvailable]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPTServiceAvailable_WebServerId]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPTServiceAvailable]  WITH CHECK ADD  CONSTRAINT [FK_DPTServiceAvailable_WebServerId] FOREIGN KEY([WebServerId])
	REFERENCES [dbo].[WebServer] ([Id])

	ALTER TABLE [dbo].[DPTServiceAvailable] CHECK CONSTRAINT [FK_DPTServiceAvailable_WebServerId]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTServiceAvailable]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPTServiceAvailable_LanguageId1]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPTServiceAvailable]  WITH CHECK ADD  CONSTRAINT [FK_DPTServiceAvailable_LanguageId1] FOREIGN KEY([LanguageId1])
	REFERENCES [dbo].[Language] ([Id])

	ALTER TABLE [dbo].[DPTServiceAvailable] CHECK CONSTRAINT [FK_DPTServiceAvailable_LanguageId1]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTServiceAvailable]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPTServiceAvailable_LanguageId2]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPTServiceAvailable]  WITH CHECK ADD  CONSTRAINT [FK_DPTServiceAvailable_LanguageId2] FOREIGN KEY([LanguageId2])
	REFERENCES [dbo].[Language] ([Id])

	ALTER TABLE [dbo].[DPTServiceAvailable] CHECK CONSTRAINT [FK_DPTServiceAvailable_LanguageId2]
end

-------------------------- End Foreign Key ---------------------------------------------------------------

-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [DPTServiceAvailable]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_DPTServiceAvailable_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DPTServiceAvailable]') AND name = N'IX_DPTServiceAvailable_1')
DROP INDEX [IX_DPTServiceAvailable_1] ON [dbo].[DPTServiceAvailable]
GO




/****** Object:  Index [IX_DPTServiceAvailable_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_DPTServiceAvailable_1] ON [dbo].[DPTServiceAvailable]
(
	[LanguageId1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_DPTServiceAvailable_2]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DPTServiceAvailable]') AND name = N'IX_DPTServiceAvailable_2')
DROP INDEX [IX_DPTServiceAvailable_2] ON [dbo].[DPTServiceAvailable]
GO




/****** Object:  Index [IX_DPTServiceAvailable_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_DPTServiceAvailable_2] ON [dbo].[DPTServiceAvailable]
(
	[LanguageId2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




/****** Object:  Index [IX_DPTServiceAvailable_3]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DPTServiceAvailable]') AND name = N'IX_DPTServiceAvailable_3')
DROP INDEX [IX_DPTServiceAvailable_3] ON [dbo].[DPTServiceAvailable]
GO




/****** Object:  Index [IX_DPTServiceAvailable_3]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_DPTServiceAvailable_3] ON [dbo].[DPTServiceAvailable]
(
	[WebServerId] ASC,
	[LanguageId1] ASC,
	[LanguageId2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



/****** Object:  Index [IX_DPTServiceAvailable_4]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DPTServiceAvailable]') AND name = N'IX_DPTServiceAvailable_4')
DROP INDEX [IX_DPTServiceAvailable_4] ON [dbo].[DPTServiceAvailable]
GO




/****** Object:  Index [IX_DPTServiceAvailable_4]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_DPTServiceAvailable_4] ON [dbo].[DPTServiceAvailable]
(
	[WebServerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

---------------------------------------------------------------End Index------------------------------------------------------------------
