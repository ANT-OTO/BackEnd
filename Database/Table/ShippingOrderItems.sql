
/****** Object:  Table [dbo].[ShippingOrderItems]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingOrderItems]') AND type in (N'U'))
Begin
	/*
	alter table [ShippingOrderItemsY] drop constraint [FK_ShippingOrderItemsY_ShippingOrderItems]
	DROP TABLE [dbo].[ShippingOrderItems]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ShippingOrderItems')
	)
	
	
	declare @TblName as nvarchar(64) = 'ShippingOrderItems'
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
	print 'you need to manually exec DROP TABLE [dbo].[ShippingOrderItems] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ShippingOrderItems](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ShippingOrderId] int NOT NULL,
	[ItemId] int NULL,
	[StockItemId] int NULL,
	[ItemName] nvarchar(256) NOT NULL,
	[Quantity] int NOT NULL,
	[Unit] nvarchar(64) NOT NULL,
	[Weight] decimal(10,2) NOT NULL,
	[WeightUnit] int NOT NULL, --1 lb 2 kg 3 g
	[Price] decimal(10, 2) NOT NULL,
	[CurrencyId] int NOT NULL,
	[TaxPrice] decimal(10,2) NOT NULL,
	[SourceArea] nvarchar(64) NOT NULL,
	[GoodCode] nvarchar(256) NOT NULL, --SKU Number
	[StateBarCode] nvarchar(256) NULL, --UPC Number
	[Brand] nvarchar(256) NULL,
	[Specifications] nvarchar(256) NULL,
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[LastUpdateBy] int NOT NULL,
	[LastUpdateByType] int NOT NULL,
 CONSTRAINT [PK_ShippingOrderItems] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[ShippingOrderItems] ADD  CONSTRAINT [DF_ShippingOrderItems_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
ALTER TABLE [dbo].[ShippingOrderItems] ADD  CONSTRAINT [DF_ShippingOrderItems_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------


-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------


-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------

select * from [ShippingOrderItems]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_ShippingOrderItems_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ShippingOrderItems]') AND name = N'IX_ShippingOrderItems_1')
DROP INDEX [IX_ShippingOrderItems_1] ON [dbo].[ShippingOrderItems]
GO




/****** Object:  Index [IX_ShippingOrderItems_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ShippingOrderItems_1] ON [dbo].[ShippingOrderItems]
(
	[ShippingOrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---------------------------------------------------------------End Index------------------------------------------------------------------

