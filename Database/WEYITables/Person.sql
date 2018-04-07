
/****** Object:  Table [dbo].[Person]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
Begin
	/*


alter table [PersonBilling] drop constraint [FK_PersonBilling_Person]
alter table [PersonCreditCard] drop constraint [FK_PersonCreditCard_Person]
alter table [PersonDevice] drop constraint [FK_PersonDevice_Person]
alter table [PersonFeedback] drop constraint [FK_PersonFeedback_Person]
alter table [PersonLanguage] drop constraint [FK_PersonLanguage_Person]
alter table [PersonPayment] drop constraint [FK_PersonPayment_Person]
alter table [PersonPaymentMethod] drop constraint [FK_PersonPaymentMethod_Person]
alter table [PersonPayPal] drop constraint [FK_PersonPayPal_Person]
alter table [PersonPicture] drop constraint [FK_PersonPicture_Person]
alter table [PersonProperty] drop constraint [FK_PersonProperty_Person]
alter table [PersonSession] drop constraint [FK_PersonSession_Person]
alter table [Request] drop constraint [FK_Request_Person]

	DROP TABLE [dbo].[Person]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'Person')
	)	
	
	declare @TblName as nvarchar(64) = 'Person'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[Person] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[Person](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](128) NOT NULL,
	[RegionId] int NOT NULL,
	[MobilePhone] [varchar](32) NOT NULL,
	[Pwd] [nvarchar](128) NOT NULL,
	
	[PromoCode] [nvarchar](16) NOT NULL,	
	
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]




--ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
--ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Region]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_Person_Region]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_Region] FOREIGN KEY([RegionId])
	REFERENCES [dbo].[Region] ([Id])

	ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Region]
end

-------------------------- End Foreign Key ---------------------------------------------------------------


--------------------------------------------------- Begin Primary Key Referenced by other tables -------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonBilling]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonBilling_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonBilling]  WITH CHECK ADD  CONSTRAINT [FK_PersonBilling_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[PersonBilling] CHECK CONSTRAINT [FK_PersonBilling_Person]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonCreditCard]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonCreditCard_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonCreditCard]  WITH CHECK ADD  CONSTRAINT [FK_PersonCreditCard_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[PersonCreditCard] CHECK CONSTRAINT [FK_PersonCreditCard_Person]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonDevice]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonDevice_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonDevice]  WITH CHECK ADD  CONSTRAINT [FK_PersonDevice_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[PersonDevice] CHECK CONSTRAINT [FK_PersonDevice_Person]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonFeedback]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonFeedback_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonFeedback]  WITH CHECK ADD  CONSTRAINT [FK_PersonFeedback_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[PersonFeedback] CHECK CONSTRAINT [FK_PersonFeedback_Person]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonLanguage]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonLanguage_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonLanguage]  WITH CHECK ADD  CONSTRAINT [FK_PersonLanguage_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[PersonLanguage] CHECK CONSTRAINT [FK_PersonLanguage_Person]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonPayment]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonPayment_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonPayment]  WITH CHECK ADD  CONSTRAINT [FK_PersonPayment_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[PersonPayment] CHECK CONSTRAINT [FK_PersonPayment_Person]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonPaymentMethod]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonPaymentMethod_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonPaymentMethod]  WITH CHECK ADD  CONSTRAINT [FK_PersonPaymentMethod_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[PersonPaymentMethod] CHECK CONSTRAINT [FK_PersonPaymentMethod_Person]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonPayPal]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonPayPal_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonPayPal]  WITH CHECK ADD  CONSTRAINT [FK_PersonPayPal_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[PersonPayPal] CHECK CONSTRAINT [FK_PersonPayPal_Person]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonPicture]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonPicture_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonPicture]  WITH CHECK ADD  CONSTRAINT [FK_PersonPicture_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[PersonPicture] CHECK CONSTRAINT [FK_PersonPicture_Person]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonProperty]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonProperty_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonProperty]  WITH CHECK ADD  CONSTRAINT [FK_PersonProperty_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[PersonProperty] CHECK CONSTRAINT [FK_PersonProperty_Person]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonSession]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonSession_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonSession]  WITH CHECK ADD  CONSTRAINT [FK_PersonSession_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[PersonSession] CHECK CONSTRAINT [FK_PersonSession_Person]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Request]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_Request_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[Request]  WITH CHECK ADD  CONSTRAINT [FK_Request_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[Request] CHECK CONSTRAINT [FK_Request_Person]
end


--------------------------------------------------- End Primary Key Referenced by other tables -------------------------------------------


select * from Person
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())

/****** Object:  Index [IX_Person_Email]    Script Date: 01/16/2015 11:52:42 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND name = N'IX_Person_Email')
DROP INDEX [IX_Person_Email] ON [dbo].[Person] WITH ( ONLINE = OFF )
GO


/****** Object:  Index [IX_Person_Email]    Script Date: 01/16/2015 11:52:37 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Person_Email] ON [dbo].[Person] 
(
	[Email] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


--------------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND name = N'IX_Person_MobilePhone')
DROP INDEX [IX_Person_MobilePhone] ON [dbo].[Person] WITH ( ONLINE = OFF )
GO


/****** Object:  Index [IX_Person_MobilePhone]    Script Date: 1/30/2015 5:08:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_Person_MobilePhone] ON [dbo].[Person]
(
	[RegionId] ASC,
	[MobilePhone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------

