
/****** Object:  Table [dbo].[ShippingChannelCompany]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingChannelCompany]') AND type in (N'U'))
Begin
	/*
	alter table [ShippingChannelCompanyY] drop constraint [FK_ShippingChannelCompanyY_ShippingChannelCompany]
	DROP TABLE [dbo].[ShippingChannelCompany]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ShippingChannelCompany')
	)
	
	
	declare @TblName as nvarchar(64) = 'ShippingChannelCompany'
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
	print 'you need to manually exec DROP TABLE [dbo].[ShippingChannelCompany] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ShippingChannelCompany](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ShippingChannelId] int NOT NULL,
	[SourceCompanyId] int NOT NULL,
	[HandlerCompanyId] int NOT NULL,
	[TaxRate] decimal(10,2) NULL, --%
	[PriceFirstRate] decimal(10,2) NULL,
	[PriceAdditionRate] decimal(10, 2) NULL,
	[WeightUnit] int NULL, -- lb, kg, g
	[WeightFirst] int NULL, --first weight
	[UnitPriceFirst] decimal(10,2) NULL,
	[UnitPriceAdditional] decimal(10,2) NULL, 
	[JumpToInt] bit NULL,
	[TaxPaymentMethodAvailable] bit NULL,
	[Available] bit NOT NULL,
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[LastUpdateBy] int NOT NULL,
	[LastUpdateByType] int NOT NULL,
 CONSTRAINT [PK_ShippingChannelCompany] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[ShippingChannelCompany] ADD  CONSTRAINT [DF_ShippingChannelCompany_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
ALTER TABLE [dbo].[ShippingChannelCompany] ADD  CONSTRAINT [DF_ShippingChannelCompany_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------


-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------


-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------

select * from [ShippingChannelCompany]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_ShippingChannelCompany_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ShippingChannelCompany]') AND name = N'IX_ShippingChannelCompany_1')
DROP INDEX [IX_ShippingChannelCompany_1] ON [dbo].[ShippingChannelCompany]
GO




/****** Object:  Index [IX_ShippingChannelCompany_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ShippingChannelCompany_1] ON [dbo].[ShippingChannelCompany]
(
	[HandlerCompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_ShippingChannelCompany_2]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ShippingChannelCompany]') AND name = N'IX_ShippingChannelCompany_2')
DROP INDEX [IX_ShippingChannelCompany_2] ON [dbo].[ShippingChannelCompany]
GO


/****** Object:  Index [IX_ShippingChannelCompany_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ShippingChannelCompany_2] ON [dbo].[ShippingChannelCompany]
(
	[SourceCompanyId] ASC,
	[HandlerCompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

---------------------------------------------------------------End Index------------------------------------------------------------------

