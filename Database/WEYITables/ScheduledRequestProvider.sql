
/****** Object:  Table [dbo].[ScheduledRequestProvider]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduledRequestProvider]') AND type in (N'U'))
Begin
	/*
	
alter table [ScheduledRequestProviderQuery] drop constraint [FK_ScheduledRequestProviderQuery_ScheduledRequestProviderId]
alter table [ScheduledRequestProviderTwilioAccount] drop constraint [FK_ScheduledRequestProviderTwilioAccount_ScheduledRequestProvider]

	DROP TABLE [dbo].[ScheduledRequestProvider]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ScheduledRequestProvider')
	)	
	

	declare @TblName as nvarchar(64) = 'ScheduledRequestProvider'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[ScheduledRequestProvider] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ScheduledRequestProvider](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ScheduledRequestId] [int] NOT NULL,
	[ProviderId] [int] NOT NULL,
	[ProviderServiceId] [int] NOT NULL,					-- ProviderService that is used to make provider qualified for the job. This record contains ProviderId, however
														-- we also saved ProviderId in the table and we have to make sure data intergrity is maintained.
	
	[ScheduledRequestProviderStatusCodeId] [int] NOT NULL,		-- from CodeList (Category ScheduledRequestProviderStatus): 
														-- New, Sent, Received, Accepted, Confirmed
	
	[SentTime] [datetime] NULL,
	[ReceivedTime] [datetime] NULL,
	[AcceptedTime] [datetime] NULL,
	[BillCompanyProductId] int NULL,
	[PayRate] decimal(9, 2) NULL,
	[PayMinMinute] int NULL,
	[ExtBillCompanyProductId] int NULL,
	[Rate] decimal(9, 2) NULL,
	[MinMinute] int NULL,
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[LastUpdateBy] [int] NOT NULL,
	[LastUpdateByType] [int] NOT NULL,
 CONSTRAINT [PK_ScheduledRequestProvider] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


--ALTER TABLE [dbo].[ScheduledRequestProvider] ADD  CONSTRAINT [DF_ScheduledRequestProvider_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
--ALTER TABLE [dbo].[ScheduledRequestProvider] ADD  CONSTRAINT [DF_ScheduledRequestProvider_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduledRequest]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduledRequestProvider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScheduledRequestProvider_ScheduledRequest]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScheduledRequestProvider]  WITH CHECK ADD  CONSTRAINT [FK_ScheduledRequestProvider_ScheduledRequest] FOREIGN KEY([ScheduledRequestId])
	REFERENCES [dbo].[ScheduledRequest] ([Id])

	ALTER TABLE [dbo].[ScheduledRequestProvider] CHECK CONSTRAINT [FK_ScheduledRequestProvider_ScheduledRequest]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduledRequestProvider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScheduledRequestProvider_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScheduledRequestProvider]  WITH CHECK ADD  CONSTRAINT [FK_ScheduledRequestProvider_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ScheduledRequestProvider] CHECK CONSTRAINT [FK_ScheduledRequestProvider_Provider]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderService]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduledRequestProvider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScheduledRequestProvider_ProviderService]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScheduledRequestProvider]  WITH CHECK ADD  CONSTRAINT [FK_ScheduledRequestProvider_ProviderService] FOREIGN KEY([ProviderServiceId])
	REFERENCES [dbo].[ProviderService] ([Id])

	ALTER TABLE [dbo].[ScheduledRequestProvider] CHECK CONSTRAINT [FK_ScheduledRequestProvider_ProviderService]
end

-------------------------- End Foreign Key ---------------------------------------------------------------

-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduledRequestProvider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduledRequestProviderQuery]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScheduledRequestProviderQuery_ScheduledRequestProviderId]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScheduledRequestProviderQuery]  WITH CHECK ADD  CONSTRAINT [FK_ScheduledRequestProviderQuery_ScheduledRequestProviderId] FOREIGN KEY([ScheduledRequestProviderId])
	REFERENCES [dbo].[ScheduledRequestProvider] ([Id])

	ALTER TABLE [dbo].[ScheduledRequestProviderQuery] CHECK CONSTRAINT [FK_ScheduledRequestProviderQuery_ScheduledRequestProviderId]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduledRequestProvider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduledRequestProviderTwilioAccount]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScheduledRequestProviderTwilioAccount_ScheduledRequestProvider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScheduledRequestProviderTwilioAccount]  WITH CHECK ADD  CONSTRAINT [FK_ScheduledRequestProviderTwilioAccount_ScheduledRequestProvider] FOREIGN KEY([ScheduledRequestProviderId])
	REFERENCES [dbo].[ScheduledRequestProvider] ([Id])

	ALTER TABLE [dbo].[ScheduledRequestProviderTwilioAccount] CHECK CONSTRAINT [FK_ScheduledRequestProviderTwilioAccount_ScheduledRequestProvider]
end

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------



select * from [ScheduledRequestProvider]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_ScheduledRequestProvider_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduledRequestProvider]') AND name = N'IX_ScheduledRequestProvider_1')
DROP INDEX [IX_ScheduledRequestProvider_1] ON [dbo].[ScheduledRequestProvider]
GO




/****** Object:  Index [IX_ScheduledRequestProvider_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ScheduledRequestProvider_1] ON [dbo].[ScheduledRequestProvider]
(
	[ScheduledRequestId] ASC,
	[ProviderId] ASC,
	[ScheduledRequestProviderStatusCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
