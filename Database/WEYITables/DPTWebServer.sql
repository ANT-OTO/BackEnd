
/****** Object:  Table [dbo].[DPTWebServer]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTWebServer]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[DPTWebServer]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'DPTWebServer')
	)	
	

	declare @TblName as nvarchar(64) = 'DPTWebServer'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[DPTWebServer] ' + convert(varchar, getdate())
	
End
else
begin
--drop table [dbo].[DPTWebServer]

CREATE TABLE [dbo].[DPTWebServer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	
	[DPTId] [int] NOT NULL,
	[WebServerId] [int] NOT NULL,
	[WebServerNotificationStatusCodeId] int NOT NULL,			/*
																	1	New
																	2	In Process
																	3	Notified
																	4	Failed
																	select * from CodeList where Category = 'WebServerNotificationStatus'
																*/
		
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_DPTWebServer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[DPTWebServer] ADD  CONSTRAINT [DF_DPTWebServer_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[DPTWebServer] ADD  CONSTRAINT [DF_DPTWebServer_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPT]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTWebServer]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPTWebServer_DPT]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPTWebServer]  WITH CHECK ADD  CONSTRAINT [FK_DPTWebServer_DPT] FOREIGN KEY([DPTId])
	REFERENCES [dbo].[DPT] ([Id])

	ALTER TABLE [dbo].[DPTWebServer] CHECK CONSTRAINT [FK_DPTWebServer_DPT]
end



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebServer]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebServerFeedback]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_WebServerFeedback_WebServer]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[WebServerFeedback]  WITH CHECK ADD  CONSTRAINT [FK_WebServerFeedback_WebServer] FOREIGN KEY([WebServerId])
	REFERENCES [dbo].[WebServer] ([Id])

	ALTER TABLE [dbo].[WebServerFeedback] CHECK CONSTRAINT [FK_WebServerFeedback_WebServer]
end




-------------------------- End Foreign Key ---------------------------------------------------------------


select * from [DPTWebServer]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_DPTWebServer_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DPTWebServer]') AND name = N'IX_DPTWebServer_1')
DROP INDEX [IX_DPTWebServer_1] ON [dbo].[DPTWebServer]
GO




/****** Object:  Index [IX_DPTWebServer_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_DPTWebServer_1] ON [dbo].[DPTWebServer]
(
	[DPTId] ASC,
	[WebServerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
