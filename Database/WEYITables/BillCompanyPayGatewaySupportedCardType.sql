
/****** Object:  Table [dbo].[BillCompanyPayGatewaySupportedCardType]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillCompanyPayGatewaySupportedCardType]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[BillCompanyPayGatewaySupportedCardType]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'BillCompanyPayGatewaySupportedCardType')
	)	
	
	
	declare @TblName as nvarchar(64) = 'BillCompanyPayGatewaySupportedCardType'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[BillCompanyPayGatewaySupportedCardType] ' + convert(varchar, getdate())
	
End
else
begin

	CREATE TABLE [dbo].[BillCompanyPayGatewaySupportedCardType](
		[Id] [int] IDENTITY(1,1) NOT NULL,
		[BillCompanyPayGatewayId] int NOT NULL,
		[BillSupportedCardTypeCodeId] int NOT NULL,

		[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_BillCompanyPayGatewaySupportedCardType_CreateDate]  DEFAULT (getutcdate()),
	 CONSTRAINT [PK_BillCompanyPayGatewaySupportedCardType] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillCompanyPayGateway]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillCompanyPayGatewaySupportedCardType]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_BillCompanyPayGatewaySupportedCardType_BillCompanyPayGateway]') AND type in (N'F'))
	begin
		ALTER TABLE [dbo].[BillCompanyPayGatewaySupportedCardType]  WITH CHECK ADD  CONSTRAINT FK_BillCompanyPayGatewaySupportedCardType_BillCompanyPayGateway FOREIGN KEY(BillCompanyPayGatewayId)
		REFERENCES [dbo].BillCompanyPayGateway ([Id])

		ALTER TABLE [dbo].[BillCompanyPayGatewaySupportedCardType] CHECK CONSTRAINT FK_BillCompanyPayGatewaySupportedCardType_BillCompanyPayGateway
	end


	select * from dbo.BillCompanyPayGatewaySupportedCardType
end
GO

SET ANSI_PADDING OFF
GO
---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BillCompanyPayGatewaySupportedCardType]') AND name = N'BillCompanyPayGatewaySupportedCardType_1')
DROP INDEX [BillCompanyPayGatewaySupportedCardType_1] ON [dbo].[BillCompanyPayGatewaySupportedCardType]
GO

CREATE NONCLUSTERED INDEX [BillCompanyPayGatewaySupportedCardType_1] ON [dbo].[BillCompanyPayGatewaySupportedCardType]
(
	[BillCompanyPayGatewayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BillCompanyPayGatewaySupportedCardType]') AND name = N'BillCompanyPayGatewaySupportedCardType_2')
DROP INDEX BillCompanyPayGatewaySupportedCardType_2 ON [dbo].[BillCompanyPayGatewaySupportedCardType]
GO

CREATE NONCLUSTERED INDEX BillCompanyPayGatewaySupportedCardType_2 ON [dbo].[BillCompanyPayGatewaySupportedCardType]
(
	[BillCompanyPayGatewayId] ASC,
	[BillSupportedCardTypeCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
---------------------------------------------------------------End Index------------------------------------------------------------------
