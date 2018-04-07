
/****** Object:  Table [dbo].[BillPersonTransactionPaymentAuthorizeNet]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonTransactionPaymentAuthorizeNet]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[BillPersonTransactionPaymentAuthorizeNet]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'BillPersonTransactionPaymentAuthorizeNet')
	)	
	
	
	declare @TblName as nvarchar(64) = 'BillPersonTransactionPaymentAuthorizeNet'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[BillPersonTransactionPaymentAuthorizeNet] ' + convert(varchar, getdate())
	
End
else
begin

	CREATE TABLE [dbo].[BillPersonTransactionPaymentAuthorizeNet](
		[Id] [int] IDENTITY(1,1) NOT NULL,
		[BillPersonTransactionPaymentId] [int] NOT NULL,
		--[BillPersonTransactionId] [int] NULL,
		[x_trans_id] [varchar](20) NULL,
		[x_response_code] [int] NULL,
		[x_response_reason_code] [int] NULL,
		[x_response_reason_text] [varchar](255) NULL,
		[x_auth_code] [varchar](6) NULL,
		[x_avs_code] [varchar](10) NULL,
		[x_invoice_num] [varchar](20) NULL,
		[x_description] [varchar](255) NULL,
		[x_method] [varchar](6) NULL,
		[x_type] [varchar](20) NULL,
		[x_card_type] [varchar](50) NULL,
		[x_cavv_response] [varchar](10) NULL,
		[x_cust_id] [varchar](20) NULL,
		[Version] [timestamp] NOT NULL,
		[CreateDate] [datetime] NOT NULL,
	 CONSTRAINT [PK_BillPersonTransactionPaymentAuthorizeNet] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	-------------------------- Begin Foreign Key ---------------------------------------------------------------
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonTransactionPayment]') AND type in (N'U'))
		and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillBillPersonTransactionPaymentTransactionPaymentAuthorizeNet]') AND type in (N'U'))
		and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_BillBillPersonTransactionPaymentTransactionPaymentAuthorizeNet_BillPersonTransactionPayment]') AND type in (N'F'))
	begin
		ALTER TABLE [dbo].[BillBillPersonTransactionPaymentTransactionPaymentAuthorizeNet]  WITH CHECK ADD  CONSTRAINT FK_BillBillPersonTransactionPaymentTransactionPaymentAuthorizeNet_BillPersonTransactionPayment FOREIGN KEY(BillPersonTransactionPaymentId)
		REFERENCES [dbo].BillPersonTransactionPayment ([Id])

		ALTER TABLE [dbo].[BillBillPersonTransactionPaymentTransactionPaymentAuthorizeNet] CHECK CONSTRAINT FK_BillBillPersonTransactionPaymentTransactionPaymentAuthorizeNet_BillPersonTransactionPayment
	end

	-------------------------- End Foreign Key ---------------------------------------------------------------

	select * from dbo.BillPersonTransactionPaymentAuthorizeNet
end
GO

SET ANSI_PADDING OFF
GO

print '
Create Index ' + convert(varchar, getdate())


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonTransactionPaymentAuthorizeNet]') AND name = N'BillPersonTransactionPaymentAuthorizeNet_1')
DROP INDEX [BillPersonTransactionPaymentAuthorizeNet_1] ON [dbo].[BillPersonTransactionPaymentAuthorizeNet]
GO

CREATE NONCLUSTERED INDEX [BillPersonTransactionPaymentAuthorizeNet_1] ON [dbo].[BillPersonTransactionPaymentAuthorizeNet]
(
	[BillPersonTransactionPaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO