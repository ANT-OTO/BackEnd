
/****** Object:  Table [dbo].[ThirdPartyExternalRequest]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ThirdPartyExternalRequest]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[ThirdPartyExternalRequest]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ThirdPartyExternalRequest')
	)	
	
	

	declare @TblName as nvarchar(64) = 'ThirdPartyExternalRequest'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[ThirdPartyExternalRequest] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ThirdPartyExternalRequest](
	[Id] [int] IDENTITY(10082000,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[AudioOnlyClientId] [int] NULL,
	[PersonId] [int] NOT NULL,
	[AudioOnlyPersonId] [int] NULL,
	[BillCompanyProductId] [int] NOT NULL,
	[AudioOnlyOnDemandProductId] [int] NULL,
	[FromLanguageId] [int] NOT NULL,
	[ToLanguageId] [int] NOT NULL,
	[RequestId] [int] NULL,
	[AudioOnlyOnDemandRequestId] [int] NULL,
	[ThirdPartyUId] nvarchar(256) NOT NULL,
	[CustomerName] nvarchar(128) NULL,
	[CareGiverName] nvarchar(128) NULL,
	[AdditionalInfoCustomer] nvarchar(256) NULL,
	[AdditionalInfoInterpreter] nvarchar(256) NULL,
	[VideoOptionCodeId] int NOT NULL, --select * from CodeList where Category = 'ProviderVideoOption'
	[RedirectAfterServiceCustomer] nvarchar(max) NULL,
	[RedirectAfterServiceInterpreter] nvarchar(max) NULL,
	[StatusPostBackUrl] nvarchar(max) NULL,
	[CompanyId] int NOT NULL,
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_ThirdPartyExternalRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[ThirdPartyExternalRequest] ADD  CONSTRAINT [DF_ThirdPartyExternalRequest_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[ThirdPartyExternalRequest] ADD  CONSTRAINT [DF_ThirdPartyExternalRequest_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ThirdPartyExternalRequest]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ThirdPartyExternalRequest_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ThirdPartyExternalRequest]  WITH CHECK ADD  CONSTRAINT [FK_ThirdPartyExternalRequest_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[ThirdPartyExternalRequest] CHECK CONSTRAINT [FK_ThirdPartyExternalRequest_Person]
end


select * from [ThirdPartyExternalRequest]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_ThirdPartyExternalRequest_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ThirdPartyExternalRequest]') AND name = N'IX_ThirdPartyExternalRequest_1')
DROP INDEX [IX_ThirdPartyExternalRequest_1] ON [dbo].[ThirdPartyExternalRequest]
GO

/****** Object:  Index [IX_ThirdPartyExternalRequest_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ThirdPartyExternalRequest_1] ON [dbo].[ThirdPartyExternalRequest]
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [IX_ThirdPartyExternalRequest_2]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ThirdPartyExternalRequest]') AND name = N'IX_ThirdPartyExternalRequest_2')
DROP INDEX [IX_ThirdPartyExternalRequest_2] ON [dbo].[ThirdPartyExternalRequest]
GO

/****** Object:  Index [IX_ThirdPartyExternalRequest_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ThirdPartyExternalRequest_2] ON [dbo].[ThirdPartyExternalRequest]
(
	[ThirdPartyUId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [IX_ThirdPartyExternalRequest_3]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ThirdPartyExternalRequest]') AND name = N'IX_ThirdPartyExternalRequest_3')
DROP INDEX [IX_ThirdPartyExternalRequest_3] ON [dbo].[ThirdPartyExternalRequest]
GO




/****** Object:  Index [IX_ThirdPartyExternalRequest_3]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ThirdPartyExternalRequest_3] ON [dbo].[ThirdPartyExternalRequest]
(
	[AudioOnlyPersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

---------------------------------------------------------------End Index------------------------------------------------------------------
