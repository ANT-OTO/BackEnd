
/****** Object:  Table [dbo].[ShippingOrder]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingOrder]') AND type in (N'U'))
Begin
	/*
	alter table [ShippingOrderY] drop constraint [FK_ShippingOrderY_ShippingOrder]
	DROP TABLE [dbo].[ShippingOrder]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ShippingOrder')
	)
	
	
	declare @TblName as nvarchar(64) = 'ShippingOrder'
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
	print 'you need to manually exec DROP TABLE [dbo].[ShippingOrder] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ShippingOrder](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] int NOT NULL,
	[CustomerOrderId] int NULL,
	[ReferenceOrderCode] nvarchar(256) NULL,
	[ShippingFromAddressId] int NOT NULL,
	[ShippingToAddressId] int NOT NULL,
	[ShippingChannelId] int NULL,
	[Price] decimal(10,2) NOT NULL,
	[CurrencyId] int NOT NULL,
	[TotalWeight] decimal NOT NULL,
	[WeightUnitId] int NOT NULL,
	[ShippingOrderStatusCodeId] int NOT NULL,
	[ShippingOrderCode] nvarchar(256) NOT NULL,

	[UserId] int NOT NULL,
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[LastUpdateBy] int NOT NULL,
	[LastUpdateByType] int NOT NULL,
 CONSTRAINT [PK_ShippingOrder] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[ShippingOrder] ADD  CONSTRAINT [DF_ShippingOrder_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
ALTER TABLE [dbo].[ShippingOrder] ADD  CONSTRAINT [DF_ShippingOrder_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------


-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingOrder]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingOrderY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ShippingOrderY_ShippingOrder]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ShippingOrderY]  WITH CHECK ADD  CONSTRAINT [FK_ShippingOrderY_ShippingOrder] FOREIGN KEY([ShippingOrderId])
	REFERENCES [dbo].[ShippingOrder] ([Id])

	ALTER TABLE [dbo].[ShippingOrderY] CHECK CONSTRAINT [FK_ShippingOrderY_ShippingOrder]
end

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------

select * from [ShippingOrder]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_ShippingOrder_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ShippingOrder]') AND name = N'IX_ShippingOrder_1')
DROP INDEX [IX_ShippingOrder_1] ON [dbo].[ShippingOrder]
GO




/****** Object:  Index [IX_ShippingOrder_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ShippingOrder_1] ON [dbo].[ShippingOrder]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_ShippingOrder_3]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ShippingOrder]') AND name = N'IX_ShippingOrder_3')
DROP INDEX [IX_ShippingOrder_3] ON [dbo].[ShippingOrder]
GO




/****** Object:  Index [IX_ShippingOrder_3]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ShippingOrder_3] ON [dbo].[ShippingOrder]
(
	[ShippingOrderCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------

