
/****** Object:  Table [dbo].[BillProviderPayGateway_Check]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillProviderPayGateway_Check]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[BillProviderPayGateway_Check]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'BillProviderPayGateway_Check')
	)	
	
	
	declare @TblName as nvarchar(64) = 'BillProviderPayGateway_Check'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[BillProviderPayGateway_Check] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[BillProviderPayGateway_Check](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BillProviderPayGatewayId] int NOT NULL,
	[BankName] nvarchar (50) NOT NULL,
	[BankAcctNumber] nvarchar (50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_BillProviderPayGateway_Check] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[BillProviderPayGateway_Check] ADD  CONSTRAINT [DF_BillProviderPayGateway_Check_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillProviderPayGateway]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillProviderPayGateway_Check]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_BillProviderPayGateway_Id]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[BillProviderPayGateway_Check]  WITH CHECK ADD  CONSTRAINT FK_BillProviderPayGateway_Id FOREIGN KEY([BillProviderPayGatewayId])
	REFERENCES [dbo].BillProviderPayGateway ([Id])

	ALTER TABLE [dbo].[BillProviderPayGateway_Check] CHECK CONSTRAINT FK_BillProviderPayGateway_Id
end

select * from [BillProviderPayGateway_Check]
end

GO

SET ANSI_PADDING OFF
GO

GO

---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_BillProviderPayGateway_Check_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BillProviderPayGateway_Check]') AND name = N'IX_BillProviderPayGateway_Check_1')
DROP INDEX [IX_BillProviderPayGateway_Check_1] ON [dbo].[BillProviderPayGateway_Check]
GO

/****** Object:  Index [IX_BillProviderPayGateway_Check_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_BillProviderPayGateway_Check_1] ON [dbo].[BillProviderPayGateway_Check]
(
	[BillProviderPayGatewayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

---------------------------------------------------------------End Index------------------------------------------------------------------
