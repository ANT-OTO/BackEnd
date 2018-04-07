
/****** Object:  Table [dbo].[PaymentEngine]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PaymentEngine]') AND type in (N'U'))
Begin
	/*
	

alter table [PaymentEngineProperty] drop constraint [FK_PaymentEngineProperty_PaymentEngine]
alter table [InterviewPayment] drop constraint [FK_InterviewPayment_PaymentEngine]
alter table [RequestPayment] drop constraint [FK_RequestPayment_PaymentEngine]
	
	DROP TABLE [dbo].[PaymentEngine]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'PaymentEngine')
	)	
	
	
	declare @TblName as nvarchar(64) = 'PaymentEngine'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[PaymentEngine] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[PaymentEngine](
	[Id] [int] NOT NULL,
	[EngineName] [nvarchar](64) NOT NULL,			-- Authorize.Net, PayPal, Bank of America
	
													-- Open questions: How do we determine what payment engine to use under various situations?
													-- Such as Charge Person, Make Payment to Provider
													--
													
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_PaymentEngine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]




ALTER TABLE [dbo].[PaymentEngine] ADD  CONSTRAINT [DF_PaymentEngine_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
ALTER TABLE [dbo].[PaymentEngine] ADD  CONSTRAINT [DF_PaymentEngine_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------


-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PaymentEngine]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PaymentEngineProperty]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PaymentEngineProperty_PaymentEngine]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PaymentEngineProperty]  WITH CHECK ADD  CONSTRAINT [FK_PaymentEngineProperty_PaymentEngine] FOREIGN KEY([PaymentEngineId])
	REFERENCES [dbo].[PaymentEngine] ([Id])

	ALTER TABLE [dbo].[PaymentEngineProperty] CHECK CONSTRAINT [FK_PaymentEngineProperty_PaymentEngine]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PaymentEngine]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewPayment]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_InterviewPayment_PaymentEngine]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[InterviewPayment]  WITH CHECK ADD  CONSTRAINT [FK_InterviewPayment_PaymentEngine] FOREIGN KEY([PaymentEngineId])
	REFERENCES [dbo].[PaymentEngine] ([Id])

	ALTER TABLE [dbo].[InterviewPayment] CHECK CONSTRAINT [FK_InterviewPayment_PaymentEngine]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PaymentEngine]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestPayment]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestPayment_PaymentEngine]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestPayment]  WITH CHECK ADD  CONSTRAINT [FK_RequestPayment_PaymentEngine] FOREIGN KEY([PaymentEngineId])
	REFERENCES [dbo].[PaymentEngine] ([Id])

	ALTER TABLE [dbo].[RequestPayment] CHECK CONSTRAINT [FK_RequestPayment_PaymentEngine]
end

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from PaymentEngine
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_PaymentEngine_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PaymentEngine]') AND name = N'IX_PaymentEngine_1')
DROP INDEX [IX_PaymentEngine_1] ON [dbo].[PaymentEngine]
GO




/****** Object:  Index [IX_PaymentEngine_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_PaymentEngine_1] ON [dbo].[PaymentEngine]
(
	[EngineName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
