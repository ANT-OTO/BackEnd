
/****** Object:  Table [dbo].[PersonDirectConnect]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonDirectConnect]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[PersonDirectConnect]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'PersonDirectConnect')
	)	
	
	

	declare @TblName as nvarchar(64) = 'PersonDirectConnect'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[PersonDirectConnect] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[PersonDirectConnect](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonSessionId] [int] NOT NULL,				
	[ProviderId] [int] NOT NULL,				
	[LanguageId] [int] NOT NULL,
	[ProviderServiceId] int NOT NULL,				
	[RequestId] [int] NULL,

	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_PersonDirectConnect] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[PersonDirectConnect] ADD  CONSTRAINT [DF_PersonDirectConnect_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[PersonDirectConnect] ADD  CONSTRAINT [DF_PersonDirectConnect_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonSession]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonDirectConnect]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonDirectConnect_PersonSession]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonDirectConnect]  WITH CHECK ADD  CONSTRAINT [FK_PersonDirectConnect_PersonSession] FOREIGN KEY([PersonSessionId])
	REFERENCES [dbo].[PersonSession] ([Id])

	ALTER TABLE [dbo].[PersonDirectConnect] CHECK CONSTRAINT [FK_PersonDirectConnect_PersonSession]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonDirectConnect]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonDirectConnect_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonDirectConnect]  WITH CHECK ADD  CONSTRAINT [FK_PersonDirectConnect_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[PersonDirectConnect] CHECK CONSTRAINT [FK_PersonDirectConnect_Provider]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonDirectConnect]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonDirectConnect_Language]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonDirectConnect]  WITH CHECK ADD  CONSTRAINT [FK_PersonDirectConnect_Language] FOREIGN KEY([LanguageId])
	REFERENCES [dbo].[Language] ([Id])

	ALTER TABLE [dbo].[PersonDirectConnect] CHECK CONSTRAINT [FK_PersonDirectConnect_Language]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Request]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonDirectConnect]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonDirectConnect_Request]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonDirectConnect]  WITH CHECK ADD  CONSTRAINT [FK_PersonDirectConnect_Request] FOREIGN KEY([RequestId])
	REFERENCES [dbo].[Request] ([Id])

	ALTER TABLE [dbo].[PersonDirectConnect] CHECK CONSTRAINT [FK_PersonDirectConnect_Request]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderService]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonDirectConnect]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonDirectConnect_ProviderService]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonDirectConnect]  WITH CHECK ADD  CONSTRAINT [FK_PersonDirectConnect_ProviderService] FOREIGN KEY([ProviderServiceId])
	REFERENCES [dbo].[ProviderService] ([Id])

	ALTER TABLE [dbo].[PersonDirectConnect] CHECK CONSTRAINT [FK_PersonDirectConnect_ProviderService]
end

select * from [PersonDirectConnect]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_PersonDirectConnect_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PersonDirectConnect]') AND name = N'IX_PersonDirectConnect_1')
DROP INDEX [IX_PersonDirectConnect_1] ON [dbo].[PersonDirectConnect]
GO




/****** Object:  Index [IX_PersonDirectConnect_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_PersonDirectConnect_1] ON [dbo].[PersonDirectConnect]
(
	[PersonSessionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
