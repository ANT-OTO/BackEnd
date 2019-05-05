
/****** Object:  Table [dbo].[SFExpressOrder]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SFExpressOrder]') AND type in (N'U'))
Begin
	/*
	alter table [SFExpressOrderY] drop constraint [FK_SFExpressOrderY_SFExpressOrder]
	DROP TABLE [dbo].[SFExpressOrder]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'SFExpressOrder')
	)
	
	
	declare @TblName as nvarchar(64) = 'SFExpressOrder'
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
	print 'you need to manually exec DROP TABLE [dbo].[SFExpressOrder] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[SFExpressOrder](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MailNo] nvarchar(4000) NULL,
	[CneeContactName] nvarchar(100) NOT NULL, 
	[CneeCompany] nvarchar(100) NULL,
	[CneeAddress] nvarchar(200) NOT NULL,
	[CneeCity] nvarchar(100) NULL,
	[CneeProvince] nvarchar(30) null,
	[CneeCountry] nvarchar(30) NOT NULL, -- CN, HK, TW, SG, US (refer to total country code list).
	[CneePostCode] nvarchar(25) NOT NULL,
	[CneePhone] nvarchar(20) NOT NULL, 
	[CneeEmail] nvarchar(50) NULL, 
	[SenderContactName] nvarchar(100) NOT NULL, --M Sender contact name
	[SenderPhone] nvarchar(20) NOT NULL, --M Sender phone
	[SenderAddress] nvarchar(200) NOT NULL, --M Sender address
	[SenderCity] nvarchar(100) NOT NULL, -- Sender city
	[SenderProvince] nvarchar(30) NOT NULL, -- Sender province or state
	[SenderCountry ] nvarchar(30) NULL, -- US Sender country
	[SenderIsResidential] bit NULL, --O True Whether Sender’s address is residential
	[SenderPostCode] nvarchar(25) NOT NULL, --M Sender address post code
	[SenderEmail] nvarchar(50) NULL, --O Sender email
	[ReferenceNo1] nvarchar(64) NOT NULL, --M Customer reference number 1. Original reference number(order Id) 
	[ReferenceNo2] nvarchar(64) NULL, --O Customer reference number 2. Put your UPS, USPS agent tracking here, multiple parcels separated with half-width comma. e.g. 1Z1EF7860399457913,1Z1EF7860202479494
	[ExpressType] int NOT NULL, --M 100 SF Express product code
								--• 100: Int’l Standard Express - Doc
								--• 101: Int’l Standard Express - Parcel
								--• 200: Int’l Economy Express - Pilot
								--• 201: Int’l Economy Express - Doc
								--• 202: Int’l Economy Express - Parcel
	[ParcelQuantity] int NOT NULL, --M 1 Total package number(Mostly it should be 1 unless it has mother and child shipments)
	[PayMethod] int NOT NULL, -- M 1 Payment method
								--• 1: Shipper
								--• 2: Receiver
								--• 3: Third party
	[TaxPayType] int NULL, --O 1 Tax payment method:
							--1: Shipper
							--2: Receiver
	[Currency] nvarchar(5) NOT NULL, --M Currency for declared value, only accept：
	[TotalWeight] decimal(10,3) NULL,-- O Total package weight(kg for most coyntries or lbs for US/UK/AU), including all sub-shipments
	[TotalLength] decimal(10,3) NULL, -- O Total package length(cm for most coyntries or inch for US/UK/AU), including all subshipments
	[TotalWidth] decimal(10,3) NULL, --Total package width(cm for most coyntries or inch for US/UK/AU), including all subshipments 
	[TotalHeight] decimal(10,3) NULL, -- O Total package height(cm for most coyntries or inch for US/UK/AU), including all subshipments
	[Freight] nvarchar(50) NULL, -- Freight charge from customer(merchant)
	[TaxFee] nvarchar(50) NULL, -- Tax fee
	[DiscountAmount] decimal(10,2) NULL, --O Discount Amount (Total discount for whole order)
	[TransactionAmount] decimal(10,2) NULL, -- O Transaction Amount (The amount that customer need to pay)
	[PaymentTool] nvarchar(100) NULL, -- Payment tool: TENPAY CHINAPAY ALIPAY
	[PaymentNumber] nvarchar(100) NULL, -- Payment reference number
	[PaymentTime] datetime NULL, -- o Payment time
	[PromotionType] nvarchar(100) NULL, --o Promotion type
	[BuyersNickName] nvarchar(100) NULL, -- O Buyer nickname
	[OrderCertType] int NULL, -- o Certificate type 1: Identification 2: Passport
	[OrderCertNo] nvarchar(100) NULL, --o Certificate number
	[SenderRemark] nvarchar(256) NULL, -- O Remark from Sender
	[PrintSize] int NULL, --O 0 Label Print Size:
						--• 0 : 100 x 210 mm
						--• 1 : 100 x 150 mm
						--• 2 : 100 x 45 mm 
	[OrderId] nvarchar(512) NOT NULL, --The sequence number in S.F(US) order system
	[Hawbs] nvarchar(512) NOT NULL, -- S.F Waybill number(s) that assigned to your shipment(s)
	[LabelToPrint] nvarchar(512) NOT NULL, -- Print url of your S.F Express shipment waybill label
	[InvoiceToPrint] nvarchar(512) NOT NULL, -- Print url of your S.F Express shipment invoice
	[AgentLabelToPrint] nvarchar(512) NULL, -- O Print url for UPS agent label. Null for S.F Express pickup, not available if ReferenceNo2 is provided.
	[AgentPickupReference] nvarchar(512) NULL, -- O Reference number for UPS pickup. Null for S.F Express pickup, not available if ReferenceNo2 is provided.
	[FirstMileType] nvarchar(10) NOT NULL, -- First mile type applied 
	[CustomClearancePort] nvarchar(3) NULL, --O PVG Reccomanded for EPilot especially when you
											--use multiple ports or express products.
											--PVG,
											--NGB,
											--XMN
	[BatchReference] nvarchar(32) NULL, --O Batch Reference from customer referencing a	batch of shipments.
	[DgUnNumber] nvarchar(255) NULL, --O UN1993 Dangerous Good UN Number. If multiple applies, please use comma separated values.
	[Dyanmic6] nvarchar(2000) NULL, --O isBBD This is a dynamic field assigned for VAS services. E.G. for BBD Service, please include a value of isBBD to indicate this is a BBD Shipment.
	[Dyanmic7] nvarchar(64) NULL, --O This is a dynamic field. If you are using BBD	Service, please use this field for the 360 AWB.
	[PayerName] nvarchar(64) NULL, -- O This field is the actual payer’s name for the order. This is needed for B2C custom clearance. According custom’s requirement 
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[LastUpdateBy] int NOT NULL,
	[LastUpdateByType] int NOT NULL,
 CONSTRAINT [PK_SFExpressOrder] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[SFExpressOrder] ADD  CONSTRAINT [DF_SFExpressOrder_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
ALTER TABLE [dbo].[SFExpressOrder] ADD  CONSTRAINT [DF_SFExpressOrder_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------


-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------


-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------

select * from [SFExpressOrder]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_SFExpressOrder_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SFExpressOrder]') AND name = N'IX_SFExpressOrder_1')
DROP INDEX [IX_SFExpressOrder_1] ON [dbo].[SFExpressOrder]
GO




/****** Object:  Index [IX_SFExpressOrder_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_SFExpressOrder_1] ON [dbo].[SFExpressOrder]
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_SFExpressOrder_2]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SFExpressOrder]') AND name = N'IX_SFExpressOrder_2')
DROP INDEX [IX_SFExpressOrder_2] ON [dbo].[SFExpressOrder]
GO




/****** Object:  Index [IX_SFExpressOrder_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_SFExpressOrder_2] ON [dbo].[SFExpressOrder]
(
	[SenderContactName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_SFExpressOrder_3]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SFExpressOrder]') AND name = N'IX_SFExpressOrder_3')
DROP INDEX [IX_SFExpressOrder_3] ON [dbo].[SFExpressOrder]
GO




/****** Object:  Index [IX_SFExpressOrder_3]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_SFExpressOrder_3] ON [dbo].[SFExpressOrder]
(
	[SenderPhone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------

