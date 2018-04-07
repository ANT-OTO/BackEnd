
/****** Object:  Table [dbo].[RequestProvider]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestProvider]') AND type in (N'U'))
Begin
	/*
	
alter table [RequestProviderQuery] drop constraint [FK_RequestProviderQuery_RequestProviderId]
alter table [RequestProviderTwilioAccount] drop constraint [FK_RequestProviderTwilioAccount_RequestProvider]

	DROP TABLE [dbo].[RequestProvider]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'RequestProvider')
	)	
	

	declare @TblName as nvarchar(64) = 'RequestProvider'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[RequestProvider] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[RequestProvider](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RequestId] [int] NOT NULL,
	[ProviderId] [int] NOT NULL,
	[ProviderServiceId] [int] NOT NULL,					-- ProviderService that is used to make provider qualified for the job. This record contains ProviderId, however
														-- we also saved ProviderId in the table and we have to make sure data intergrity is maintained.
	
	[RequestProviderStatusCodeId] [int] NOT NULL,		-- from CodeList (Category RequestProviderStatus): 
														-- New, Sent, Received, Accepted, Confirmed
	
	[SentTime] [datetime] NULL,
	[ReceivedTime] [datetime] NULL,
	[AcceptedTime] [datetime] NULL,
	[ConfirmedTime] [datetime] NULL,

	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_RequestProvider] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


--ALTER TABLE [dbo].[RequestProvider] ADD  CONSTRAINT [DF_RequestProvider_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
--ALTER TABLE [dbo].[RequestProvider] ADD  CONSTRAINT [DF_RequestProvider_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Request]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestProvider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestProvider_Request]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestProvider]  WITH CHECK ADD  CONSTRAINT [FK_RequestProvider_Request] FOREIGN KEY([RequestId])
	REFERENCES [dbo].[Request] ([Id])

	ALTER TABLE [dbo].[RequestProvider] CHECK CONSTRAINT [FK_RequestProvider_Request]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestProvider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestProvider_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestProvider]  WITH CHECK ADD  CONSTRAINT [FK_RequestProvider_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[RequestProvider] CHECK CONSTRAINT [FK_RequestProvider_Provider]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderService]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestProvider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestProvider_ProviderService]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestProvider]  WITH CHECK ADD  CONSTRAINT [FK_RequestProvider_ProviderService] FOREIGN KEY([ProviderServiceId])
	REFERENCES [dbo].[ProviderService] ([Id])

	ALTER TABLE [dbo].[RequestProvider] CHECK CONSTRAINT [FK_RequestProvider_ProviderService]
end

-------------------------- End Foreign Key ---------------------------------------------------------------

-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestProvider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestProviderQuery]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestProviderQuery_RequestProviderId]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestProviderQuery]  WITH CHECK ADD  CONSTRAINT [FK_RequestProviderQuery_RequestProviderId] FOREIGN KEY([RequestProviderId])
	REFERENCES [dbo].[RequestProvider] ([Id])

	ALTER TABLE [dbo].[RequestProviderQuery] CHECK CONSTRAINT [FK_RequestProviderQuery_RequestProviderId]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestProvider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestProviderTwilioAccount]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestProviderTwilioAccount_RequestProvider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestProviderTwilioAccount]  WITH CHECK ADD  CONSTRAINT [FK_RequestProviderTwilioAccount_RequestProvider] FOREIGN KEY([RequestProviderId])
	REFERENCES [dbo].[RequestProvider] ([Id])

	ALTER TABLE [dbo].[RequestProviderTwilioAccount] CHECK CONSTRAINT [FK_RequestProviderTwilioAccount_RequestProvider]
end

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------



select * from [RequestProvider]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_RequestProvider_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RequestProvider]') AND name = N'IX_RequestProvider_1')
DROP INDEX [IX_RequestProvider_1] ON [dbo].[RequestProvider]
GO




/****** Object:  Index [IX_RequestProvider_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_RequestProvider_1] ON [dbo].[RequestProvider]
(
	[RequestId] ASC,
	[ProviderId] ASC,
	[RequestProviderStatusCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RequestProvider]') AND name = N'IX_RequestProvider_2')
begin
	print 'DROP INDEX [IX_RequestProvider_2] ON [dbo].[RequestProvider]'
	DROP INDEX [IX_RequestProvider_2] ON [dbo].[RequestProvider]
end
GO




CREATE NONCLUSTERED INDEX [IX_RequestProvider_2] ON [dbo].[RequestProvider]
(
	[ProviderId] ASC,
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

---------------------------------------------------------------End Index------------------------------------------------------------------
