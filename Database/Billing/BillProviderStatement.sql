
/****** Object:  Table [dbo].[BillProviderStatement]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillProviderStatement]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[BillProviderStatement]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'BillProviderStatement')
	)	
	
	
	declare @TblName as nvarchar(64) = 'BillProviderStatement'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[BillProviderStatement] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[BillProviderStatement](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProviderId] [int] NOT NULL,
	[StatementNumber] nvarchar(50) NULL,
	[StatementDate] [datetime] NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[PayableAmount] decimal(9, 2) NOT NULL,
	[PaidAmount] decimal(9, 2) NOT NULL,
	[IsCurrent] bit NOT NULL,
	[Approved] bit NOT NULL DEFAULT (0),
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_BillProviderStatement] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[BillProviderStatement] ADD  CONSTRAINT [DF_BillProviderStatement_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillProviderStatement]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_BillProviderStatement_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[BillProviderStatement]  WITH CHECK ADD  CONSTRAINT FK_BillProviderStatement_Provider FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[BillProviderStatement] CHECK CONSTRAINT [FK_BillProviderStatement_Provider]
end

select * from [BillProviderStatement]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_BillProviderStatement_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BillProviderStatement]') AND name = N'IX_BillProviderStatement_1')
DROP INDEX [IX_BillProviderStatement_1] ON [dbo].[BillProviderStatement]
GO

/****** Object:  Index [IX_BillProviderStatement_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_BillProviderStatement_1] ON [dbo].[BillProviderStatement]
(
	[ProviderId] ASC,
	[IsCurrent] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [IX_BillProviderStatement_2]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BillProviderStatement]') AND name = N'IX_BillProviderStatement_2')
DROP INDEX [IX_BillProviderStatement_2] ON [dbo].[BillProviderStatement]
GO

/****** Object:  Index [IX_BillProviderStatement_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_BillProviderStatement_2] ON [dbo].[BillProviderStatement]
(
	[ProviderId] ASC,
	[Approved] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

---------------------------------------------------------------End Index------------------------------------------------------------------
