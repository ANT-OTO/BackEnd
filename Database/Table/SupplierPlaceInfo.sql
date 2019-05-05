
/****** Object:  Table [dbo].[]    Script DSupplierPlaceInfoate: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SupplierPlaceInfo]') AND type in (N'U'))
Begin
	/*
	alter table [SupplierPlaceInfoY] drop constraint [FK_SupplierPlaceInfoY_SupplierPlaceInfo]
	DROP TABLE [dbo].[SupplierPlaceInfo]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'SupplierPlaceInfo')
	)
	
	
	declare @TblName as nvarchar(64) = 'SupplierPlaceInfo'
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
	print 'you need to manually exec DROP TABLE [dbo].[SupplierPlaceInfo] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[SupplierPlaceInfo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SupplierName] nvarchar(256) NOT NULL,
	[SupplierLocation] nvarchar(256) NOT NULL,
	[PriceInfo] nvarchar(128) NOT NULL,
	[CurrencyId] int NOT NULL,
	[Description] nvarchar(max) NOT NULL,
 	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[LastUpdateBy] int NOT NULL,
	[LastUpdateByType] int NOT NULL,
 CONSTRAINT [PK_SupplierPlaceInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[SupplierPlaceInfo] ADD  CONSTRAINT [DF_SupplierPlaceInfo_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
ALTER TABLE [dbo].[SupplierPlaceInfo] ADD  CONSTRAINT [DF_SupplierPlaceInfo_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------


-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SupplierPlaceInfo]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SupplierPlaceInfoY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_SupplierPlaceInfoY_SupplierPlaceInfo]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[SupplierPlaceInfoY]  WITH CHECK ADD  CONSTRAINT [FK_SupplierPlaceInfoY_SupplierPlaceInfo] FOREIGN KEY([SupplierPlaceInfoId])
	REFERENCES [dbo].[SupplierPlaceInfo] ([Id])

	ALTER TABLE [dbo].[SupplierPlaceInfoY] CHECK CONSTRAINT [FK_SupplierPlaceInfoY_SupplierPlaceInfo]
end

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------

select * from [SupplierPlaceInfo]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_SupplierPlaceInfo_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SupplierPlaceInfo]') AND name = N'IX_SupplierPlaceInfo_1')
DROP INDEX [IX_SupplierPlaceInfo_1] ON [dbo].[SupplierPlaceInfo]
GO




/****** Object:  Index [IX_SupplierPlaceInfo_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_SupplierPlaceInfo_1] ON [dbo].[SupplierPlaceInfo]
(
	[SupplierName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




---------------------------------------------------------------End Index------------------------------------------------------------------

