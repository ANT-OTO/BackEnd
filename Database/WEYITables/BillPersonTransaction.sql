/****** Object:  Table [dbo].[BillPersonTransaction]    Script Date: Jul 14 2016  4:12PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonTransaction]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[BillPersonTransaction]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'BillPersonTransaction')
	)	
	
	
	declare @TblName as nvarchar(64) = 'BillPersonTransaction'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[BillPersonTransaction] ' + convert(varchar, getdate())
	
End
else
begin

	CREATE TABLE [dbo].[BillPersonTransaction](
		[Id] int IDENTITY(1,1) NOT NULL,
		[PersonId] [int] NOT NULL,
		[PersonBillingTypeCodeId] [int]  NOT NULL,		

		[Quantity] decimal (11,3) NOT NULL,
		[UnitValue] decimal (11,6) NOT NULL,
		[TotalValue] decimal (11,2) NOT NULL,

		[TransactionDate] datetime NOT NULL,

		[SourceTableId] int  NULL,
		[SourceTable] varchar (255)  NULL,
		[Version] timestamp NOT NULL,
		[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_BillProviderTransactionRequest_CreateDate]  DEFAULT (getutcdate()),
		[LastUpdate] datetime NOT NULL CONSTRAINT [DF_BillProviderTransactionRequest_LastUpdate]  DEFAULT (getutcdate()),
		[LastUpdateBy] int NOT NULL,
		[LastUpdateByType] int NOT NULL,
	 CONSTRAINT [PK_BillPersonTransaction] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	-------------------------- Begin Foreign Key ---------------------------------------------------------------
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
		and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonTransaction]') AND type in (N'U'))
		and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_BillPersonTransaction_Person]') AND type in (N'F'))
	begin
		ALTER TABLE [dbo].[BillPersonTransaction]  WITH CHECK ADD  CONSTRAINT FK_BillPersonTransaction_Person FOREIGN KEY(PersonId)
		REFERENCES [dbo].Person ([Id])

		ALTER TABLE [dbo].[BillPersonTransaction] CHECK CONSTRAINT FK_BillPersonTransaction_Person
	end

	-------------------------- End Foreign Key ---------------------------------------------------------------

select * from [BillPersonTransaction]
end
GO

SET ANSI_PADDING OFF
GO

print '
Create Index ' + convert(varchar, getdate())


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonTransaction]') AND name = N'BillPersonTransaction_1')
DROP INDEX [BillPersonTransaction_1] ON [dbo].[BillPersonTransaction]
GO

CREATE NONCLUSTERED INDEX [BillPersonTransaction_1] ON [dbo].[BillPersonTransaction]
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
