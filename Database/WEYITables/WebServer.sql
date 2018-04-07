
/****** Object:  Table [dbo].[WebServer]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebServer]') AND type in (N'U'))
Begin
	/*
	
alter table [PersonDistributed] drop constraint [FK_PersonDistributed_WebServer]
alter table [ProviderDistributed] drop constraint [FK_ProviderDistributed_WebServer]
alter table [WebServerInfo] drop constraint [FK_WebServerInfo_WebServer]
alter table [WebServerPreferenceCountry] drop constraint [FK_WebServerPreferenceCountry_WebServer]
alter table [WebServerPreferenceRegion] drop constraint [FK_WebServerPreferenceRegion_WebServer]
alter table [WebServerProperty] drop constraint [FK_WebServerProperty_WebServer]
	
	DROP TABLE [dbo].[WebServer]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'WebServer')
	)	
	
	
	declare @TblName as nvarchar(64) = 'WebServer'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[WebServer] ' + convert(varchar, getdate())
	
End
else
begin


CREATE TABLE [dbo].[WebServer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GlobalId] int NOT NULL,			
	[URL] [nvarchar](256) NOT NULL,			
	[Local] [bit] NOT NULL,			
	[Available] [bit] NOT NULL,			
	[AuthKey] nvarchar(256) NOT NULL,			
	[PublicKey] nvarchar(max) NULL,			
	[PrivateKey] nvarchar(max) NULL,			

	[Registered] bit NULL,				-- whether the local server has been registered in remote server
	[LastSyncTime] [datetime] NULL, 

	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_WebServer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]




ALTER TABLE [dbo].[WebServer] ADD  CONSTRAINT [DF_WebServer_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[WebServer] ADD  CONSTRAINT [DF_WebServer_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]


if( exists(select * from DBServerProperty where PropertyType = 'DBName' and PropertyName = 'DBName' and PropertyValue = 'WEYIDB001')
	and exists(select * from DBServerProperty where PropertyType = 'Environment' and PropertyName = 'Type' and PropertyValue = 'Dev') )
begin
	insert into WebServer
	([GlobalId], [URL], [Local], [Available], [AuthKey], [PublicKey], [PrivateKey])
	select 2, 'https://localhost:44303/',-- 'https://test.weyimobile.com/API/', 
		1, 1, replace(convert(varchar(64), newid()), '-', ''), NULL, NULL
end
else if( exists(select * from DBServerProperty where PropertyType = 'DBName' and PropertyName = 'DBName' and PropertyValue = 'WEYIDB001')
	and exists(select * from DBServerProperty where PropertyType = 'Environment' and PropertyName = 'Type' and PropertyValue = 'Test') )
begin
	insert into WebServer
	([GlobalId], [URL], [Local], [Available], [AuthKey], [PublicKey], [PrivateKey])
	select 1, 'https://test.weyimobile.com/API/', 
		1, 1, replace(convert(varchar(64), newid()), '-', ''), NULL, NULL
end
else
if( exists(select * from DBServerProperty where PropertyType = 'DBName' and PropertyName = 'DBName' and PropertyValue = 'WEYIDB001')
	and (not exists(select * from DBServerProperty where PropertyType = 'Environment' and PropertyName = 'Type'
		or exists(select * from DBServerProperty where PropertyType = 'Environment' and PropertyName = 'Type' and PropertyValue in( 'Production', 'Prod' ))
	)
	) )
begin
	insert into WebServer
	([GlobalId], [URL], [Local], [Available], [AuthKey], [PublicKey], [PrivateKey])
	select 2, 'https://www.weyimobile.com/API/', 1, 1, replace(convert(varchar(64), newid()), '-', ''), NULL, NULL
end

-------------------------- Begin Foreign Key ---------------------------------------------------------------


-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebServer]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonDistributed]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonDistributed_WebServer]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonDistributed]  WITH CHECK ADD  CONSTRAINT [FK_PersonDistributed_WebServer] FOREIGN KEY([WebServerId])
	REFERENCES [dbo].[WebServer] ([Id])

	ALTER TABLE [dbo].[PersonDistributed] CHECK CONSTRAINT [FK_PersonDistributed_WebServer]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebServer]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderDistributed]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderDistributed_WebServer]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderDistributed]  WITH CHECK ADD  CONSTRAINT [FK_ProviderDistributed_WebServer] FOREIGN KEY([WebServerId])
	REFERENCES [dbo].[WebServer] ([Id])

	ALTER TABLE [dbo].[ProviderDistributed] CHECK CONSTRAINT [FK_ProviderDistributed_WebServer]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebServer]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebServerInfo]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_WebServerInfo_WebServer]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[WebServerInfo]  WITH CHECK ADD  CONSTRAINT [FK_WebServerInfo_WebServer] FOREIGN KEY([WebServerId])
	REFERENCES [dbo].[WebServer] ([Id])

	ALTER TABLE [dbo].[WebServerInfo] CHECK CONSTRAINT [FK_WebServerInfo_WebServer]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebServer]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebServerPreferenceCountry]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_WebServerPreferenceCountry_WebServer]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[WebServerPreferenceCountry]  WITH CHECK ADD  CONSTRAINT [FK_WebServerPreferenceCountry_WebServer] FOREIGN KEY([WebServerId])
	REFERENCES [dbo].[WebServer] ([Id])

	ALTER TABLE [dbo].[WebServerPreferenceCountry] CHECK CONSTRAINT [FK_WebServerPreferenceCountry_WebServer]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebServer]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebServerPreferenceRegion]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_WebServerPreferenceRegion_WebServer]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[WebServerPreferenceRegion]  WITH CHECK ADD  CONSTRAINT [FK_WebServerPreferenceRegion_WebServer] FOREIGN KEY([WebServerId])
	REFERENCES [dbo].[WebServer] ([Id])

	ALTER TABLE [dbo].[WebServerPreferenceRegion] CHECK CONSTRAINT [FK_WebServerPreferenceRegion_WebServer]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebServer]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebServerProperty]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_WebServerProperty_WebServer]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[WebServerProperty]  WITH CHECK ADD  CONSTRAINT [FK_WebServerProperty_WebServer] FOREIGN KEY([WebServerId])
	REFERENCES [dbo].[WebServer] ([Id])

	ALTER TABLE [dbo].[WebServerProperty] CHECK CONSTRAINT [FK_WebServerProperty_WebServer]
end


-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from WebServer
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_WebServer_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WebServer]') AND name = N'IX_WebServer_1')
DROP INDEX [IX_WebServer_1] ON [dbo].[WebServer]
GO




/****** Object:  Index [IX_WebServer_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_WebServer_1] ON [dbo].[WebServer]
(
	[Local] ASC,
	[URL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
