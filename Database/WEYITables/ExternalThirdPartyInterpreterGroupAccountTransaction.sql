
/****** Object:  Table [dbo].[ExternalThirdPartyInterpreterGroupAccountTransaction]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExternalThirdPartyInterpreterGroupAccountTransaction]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[ExternalThirdPartyInterpreterGroupAccountTransaction]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ExternalThirdPartyInterpreterGroupAccountTransaction')
	)	
	
	
	declare @TblName as nvarchar(64) = 'ExternalThirdPartyInterpreterGroupAccountTransaction'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[ExternalThirdPartyInterpreterGroupAccountTransaction] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ExternalThirdPartyInterpreterGroupAccountTransaction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExternalThirdPartyInterpreterGroupAccountId] int NOT NULL,
	[ExternalTransactionId] nvarchar(128) NOT NULL,
	[JobStartUtcDate] datetime NOT NULL,
	[JobEndUtcDate] datetime NOT NULL,
	[FromLanguage] nvarchar(128) NOT NULL,
	[ToLanguage] nvarchar(128) NOT NULL,
	[Minutes] int NOT NULL,
	[HoldTimeSeconds] int NOT NULL,
	[CallerID] nvarchar(256) NOT NULL,
	[ClientContact] nvarchar(256) NULL,
	[ClientPhone] nvarchar(256) NULL,
    [ContactEmployeeNumber] nvarchar(256) NULL,
    [UserDefined] nvarchar(256) NULL,
    [Doctor] nvarchar(256) NULL,
    [SubjectCaseNumber] nvarchar(256) NULL,
    [SubjectFirstName] nvarchar(256) NULL,
    [SubjectLastName] nvarchar(256) NULL,
    [SubjectPhone] nvarchar(256) NULL,
    [Deleted] bit NOT NULL,
	[CreateDate] datetime NOT NULL,
	[LastUpdate] datetime NOT NULL,
 CONSTRAINT [PK_ExternalThirdPartyInterpreterGroupAccountTransaction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[ExternalThirdPartyInterpreterGroupAccountTransaction] ADD  CONSTRAINT [DF_ExternalThirdPartyInterpreterGroupAccountTransaction_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]






select * from [ExternalThirdPartyInterpreterGroupAccountTransaction]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_ExternalThirdPartyInterpreterGroupAccountTransaction_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ExternalThirdPartyInterpreterGroupAccountTransaction]') AND name = N'IX_ExternalThirdPartyInterpreterGroupAccountTransaction_1')
DROP INDEX [IX_ExternalThirdPartyInterpreterGroupAccountTransaction_1] ON [dbo].[ExternalThirdPartyInterpreterGroupAccountTransaction]
GO




/****** Object:  Index [IX_ExternalThirdPartyInterpreterGroupAccountTransaction_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ExternalThirdPartyInterpreterGroupAccountTransaction_1] ON [dbo].[ExternalThirdPartyInterpreterGroupAccountTransaction]
(
	[ExternalThirdPartyInterpreterGroupAccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [IX_ExternalThirdPartyInterpreterGroupAccountTransaction_2]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ExternalThirdPartyInterpreterGroupAccountTransaction]') AND name = N'IX_ExternalThirdPartyInterpreterGroupAccountTransaction_2')
DROP INDEX [IX_ExternalThirdPartyInterpreterGroupAccountTransaction_2] ON [dbo].[ExternalThirdPartyInterpreterGroupAccountTransaction]
GO




/****** Object:  Index [IX_ExternalThirdPartyInterpreterGroupAccountTransaction_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ExternalThirdPartyInterpreterGroupAccountTransaction_2] ON [dbo].[ExternalThirdPartyInterpreterGroupAccountTransaction]
(
	[JobStartUtcDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [IX_ExternalThirdPartyInterpreterGroupAccountTransaction_3]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ExternalThirdPartyInterpreterGroupAccountTransaction]') AND name = N'IX_ExternalThirdPartyInterpreterGroupAccountTransaction_3')
DROP INDEX [IX_ExternalThirdPartyInterpreterGroupAccountTransaction_3] ON [dbo].[ExternalThirdPartyInterpreterGroupAccountTransaction]
GO




/****** Object:  Index [IX_ExternalThirdPartyInterpreterGroupAccountTransaction_3]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ExternalThirdPartyInterpreterGroupAccountTransaction_3] ON [dbo].[ExternalThirdPartyInterpreterGroupAccountTransaction]
(
	[JobEndUtcDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [IX_ExternalThirdPartyInterpreterGroupAccountTransaction_4]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ExternalThirdPartyInterpreterGroupAccountTransaction]') AND name = N'IX_ExternalThirdPartyInterpreterGroupAccountTransaction_4')
DROP INDEX [IX_ExternalThirdPartyInterpreterGroupAccountTransaction_4] ON [dbo].[ExternalThirdPartyInterpreterGroupAccountTransaction]
GO




/****** Object:  Index [IX_ExternalThirdPartyInterpreterGroupAccountTransaction_4]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ExternalThirdPartyInterpreterGroupAccountTransaction_4] ON [dbo].[ExternalThirdPartyInterpreterGroupAccountTransaction]
(
	[ExternalTransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---------------------------------------------------------------End Index------------------------------------------------------------------
