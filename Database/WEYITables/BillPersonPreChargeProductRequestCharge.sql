/****** Object:  Table [dbo].[BillPersonPreChargeProductRequestCharge]    Script Date: Jul 14 2016  4:12PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonPreChargeProductRequestCharge]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[BillPersonPreChargeProductRequestCharge]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'BillPersonPreChargeProductRequestCharge')
	)	
	
	
	declare @TblName as nvarchar(64) = 'BillPersonPreChargeProductRequestCharge'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[BillPersonPreChargeProductRequestCharge] ' + convert(varchar, getdate())
	
End
else
begin

	CREATE TABLE [dbo].[BillPersonPreChargeProductRequestCharge](
		[Id] int IDENTITY(1,1) NOT NULL,
		[BillPersonPreChargeProductRequestId] int NOT NULL,
		[BillPersonTransactionId] int NOT NULL,
		[Version] timestamp NOT NULL,
		[CreateDate] datetime NOT NULL CONSTRAINT [DF_BillPersonPreChargeProductRequestCharge_CreateDate]  DEFAULT (getutcdate()),
	 CONSTRAINT [PK_BillPersonPreChargeProductRequestCharge] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	-------------------------- Begin Foreign Key ---------------------------------------------------------------
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonPreChargeProductRequest]') AND type in (N'U'))
		and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonPreChargeProductRequestCharge]') AND type in (N'U'))
		and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_BillPersonPreChargeProductRequestCharge_BillPersonPreChargeProductRequest]') AND type in (N'F'))
	begin
		ALTER TABLE [dbo].[BillPersonPreChargeProductRequestCharge]  WITH CHECK ADD  CONSTRAINT FK_BillPersonPreChargeProductRequestCharge_BillPersonPreChargeProductRequest FOREIGN KEY(BillPersonPreChargeProductRequestId)
		REFERENCES [dbo].BillPersonPreChargeProductRequest ([Id])

		ALTER TABLE [dbo].[BillPersonPreChargeProductRequestCharge] CHECK CONSTRAINT FK_BillPersonPreChargeProductRequestCharge_BillPersonPreChargeProductRequest
	end

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonTransaction]') AND type in (N'U'))
		and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonPreChargeProductRequestCharge]') AND type in (N'U'))
		and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_BillPersonPreChargeProductRequestCharge_BillPersonTransaction]') AND type in (N'F'))
	begin
		ALTER TABLE [dbo].[BillPersonPreChargeProductRequestCharge]  WITH CHECK ADD  CONSTRAINT FK_BillPersonPreChargeProductRequestCharge_BillPersonTransaction FOREIGN KEY(BillPersonTransactionId)
		REFERENCES [dbo].BillPersonTransaction ([Id])

		ALTER TABLE [dbo].[BillPersonPreChargeProductRequestCharge] CHECK CONSTRAINT FK_BillPersonPreChargeProductRequestCharge_BillPersonTransaction
	end

	-------------------------- End Foreign Key ---------------------------------------------------------------

select * from [BillPersonPreChargeProductRequestCharge]
end
GO

SET ANSI_PADDING OFF
GO

print '
Create Index ' + convert(varchar, getdate())


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonPreChargeProductRequestCharge]') AND name = N'BillPersonPreChargeProductRequestCharge_1')
DROP INDEX [BillPersonPreChargeProductRequestCharge_1] ON [dbo].[BillPersonPreChargeProductRequestCharge]
GO

CREATE NONCLUSTERED INDEX [BillPersonPreChargeProductRequestCharge_1] ON [dbo].[BillPersonPreChargeProductRequestCharge]
(
	BillPersonPreChargeProductRequestId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

