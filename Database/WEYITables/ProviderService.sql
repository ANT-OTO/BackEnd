
/****** Object:  Table [dbo].[ProviderService]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderService]') AND type in (N'U'))
Begin
	/*
	
alter table [ProviderServiceApplication] drop constraint [FK_ProviderServiceApplication_ProviderService]
alter table [ProviderServiceCert] drop constraint [FK_ProviderServiceCert_ProviderService]
alter table [RequestProvider] drop constraint [FK_RequestProvider_ProviderService]
	
	DROP TABLE [dbo].[ProviderService]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ProviderService')
	)
	

	declare @TblName as nvarchar(64) = 'ProviderService'
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
	print 'you need to manually exec DROP TABLE [dbo].[ProviderService] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ProviderService](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProviderId] [int] NULL,			
	[LanguageId1] [int] NOT NULL,		-- ProviderService Language 1
	[LanguageId2] [int] NOT NULL,		-- ProviderService Language 2

	[Deleted] [bit] NOT NULL,			-- used 

	[Active] [bit] NOT NULL,	
	
	[ProviderServiceStatusCodeId] [int] NOT NULL,		-- CodeList (Category: ProviderServiceStatus): New, Approved, Denied
	
	[ChargeRate] [money] NULL,			-- Hourly rate in US$?
	
	[QualifiedInterviewer] [bit] NOT NULL,

	[ServiceProficiency] decimal(5, 3) NULL,			-- Proficiency that is used for basic task assignment
	[AveragePerformance] decimal(5, 3) NULL,			-- Average Performance by user's feedback
	
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProviderService] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


--ALTER TABLE [dbo].[ProviderService] ADD  CONSTRAINT [DF_ProviderService_QualifiedInterviewer]  DEFAULT (0) FOR [QualifiedInterviewer]


--ALTER TABLE [dbo].[ProviderService] ADD  CONSTRAINT [DF_ProviderService_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
--ALTER TABLE [dbo].[ProviderService] ADD  CONSTRAINT [DF_ProviderService_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderService]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderService_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderService]  WITH CHECK ADD  CONSTRAINT [FK_ProviderService_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ProviderService] CHECK CONSTRAINT [FK_ProviderService_Provider]
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

-------------------------- End Foreign Key ---------------------------------------------------------------

-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------




IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderService]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderServiceApplication]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderServiceApplication_ProviderService]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderServiceApplication]  WITH CHECK ADD  CONSTRAINT [FK_ProviderServiceApplication_ProviderService] FOREIGN KEY([ProviderServiceId])
	REFERENCES [dbo].[ProviderService] ([Id])

	ALTER TABLE [dbo].[ProviderServiceApplication] CHECK CONSTRAINT [FK_ProviderServiceApplication_ProviderService]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderService]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderServiceCert]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderServiceCert_ProviderService]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderServiceCert]  WITH CHECK ADD  CONSTRAINT [FK_ProviderServiceCert_ProviderService] FOREIGN KEY([ProviderServiceId])
	REFERENCES [dbo].[ProviderService] ([Id])

	ALTER TABLE [dbo].[ProviderServiceCert] CHECK CONSTRAINT [FK_ProviderServiceCert_ProviderService]
end



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderService]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestProvider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestProvider_ProviderService]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestProvider]  WITH CHECK ADD  CONSTRAINT [FK_RequestProvider_ProviderService] FOREIGN KEY([ProviderServiceId])
	REFERENCES [dbo].[ProviderService] ([Id])

	ALTER TABLE [dbo].[RequestProvider] CHECK CONSTRAINT [FK_RequestProvider_ProviderService]
end

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [ProviderService]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_ProviderService_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProviderService]') AND name = N'IX_ProviderService_1')
DROP INDEX [IX_ProviderService_1] ON [dbo].[ProviderService]
GO




/****** Object:  Index [IX_ProviderService_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ProviderService_1] ON [dbo].[ProviderService]
(
	[ProviderId] ASC,
	[LanguageId1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_ProviderService_2]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProviderService]') AND name = N'IX_ProviderService_2')
DROP INDEX [IX_ProviderService_2] ON [dbo].[ProviderService]
GO




/****** Object:  Index [IX_ProviderService_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ProviderService_2] ON [dbo].[ProviderService]
(
	[ProviderId] ASC,
	[LanguageId2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




/****** Object:  Index [IX_ProviderService_3]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProviderService]') AND name = N'IX_ProviderService_3')
DROP INDEX [IX_ProviderService_3] ON [dbo].[ProviderService]
GO




/****** Object:  Index [IX_ProviderService_3]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ProviderService_3] ON [dbo].[ProviderService]
(
	[ProviderId] ASC,
	[LanguageId1] ASC,
	[LanguageId2] ASC,
	[ProviderServiceStatusCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

---------------------------------------------------------------End Index------------------------------------------------------------------
