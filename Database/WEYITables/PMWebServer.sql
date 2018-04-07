
/****** Object:  Table [dbo].[PMWebServer]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PMWebServer]') AND type in (N'U'))
Begin
	/*
	DROP TABLE [dbo].[PMWebServer]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'PMWebServer')
	)	
	
	
	declare @TblName as nvarchar(64) = 'PMWebServer'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[PMWebServer] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[PMWebServer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PMId] [int] NOT NULL,

	[WebServerId] [int] NOT NULL,

	[WebServerPMId] [int] NOT NULL,
	
	[DistributedTypeCodeId] [int] NOT NULL,		-- select * from CodeList where Category = 'DistributedType'
												-- 1: Main
												-- 2: Backup
												-- 3: Transaction
	
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_PMWebServer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]




ALTER TABLE [dbo].[PMWebServer] ADD  CONSTRAINT [DF_PMWebServer_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
ALTER TABLE [dbo].[PMWebServer] ADD  CONSTRAINT [DF_PMWebServer_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PM]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PMWebServer]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PMWebServer_PM]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PMWebServer]  WITH CHECK ADD  CONSTRAINT [FK_PMWebServer_PM] FOREIGN KEY([PMId])
	REFERENCES [dbo].[PM] ([Id])

	ALTER TABLE [dbo].[PMWebServer] CHECK CONSTRAINT [FK_PMWebServer_PM]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebServer]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PMWebServer]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PMWebServer_WebServer]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PMWebServer]  WITH CHECK ADD  CONSTRAINT [FK_PMWebServer_WebServer] FOREIGN KEY([WebServerId])
	REFERENCES [dbo].[WebServer] ([Id])

	ALTER TABLE [dbo].[PMWebServer] CHECK CONSTRAINT [FK_PMWebServer_WebServer]
end


-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from PMWebServer
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_PMWebServer_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PMWebServer]') AND name = N'IX_PMWebServer_1')
DROP INDEX [IX_PMWebServer_1] ON [dbo].[PMWebServer]
GO




/****** Object:  Index [IX_PMWebServer_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_PMWebServer_1] ON [dbo].[PMWebServer]
(
	[PMId] ASC,
	[WebServerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
