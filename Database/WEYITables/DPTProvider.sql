
/****** Object:  Table [dbo].[DPTProvider]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTProvider]') AND type in (N'U'))
Begin
	/*


	DROP TABLE [dbo].[DPTProvider]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'DPTProvider')
	)	
	

	declare @TblName as nvarchar(64) = 'DPTProvider'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[DPTProvider] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[DPTProvider](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DPTId] [int] NOT NULL,
	[ProviderId] [int] NOT NULL,
	[ProviderServiceId] [int] NOT NULL,					-- ProviderService that is used to make provider qualified for the job. This record contains ProviderId, however
														-- we also saved ProviderId in the table and we have to make sure data intergrity is maintained.
	
	[DPTProviderStatusCodeId] [int] NOT NULL,		-- from CodeList (Category DPTProviderStatus): 
														-- New, Sent, Received, Accepted, Finished, Denied, Escalated
	
	[SentTime] [datetime] NULL,
	[ReceivedTime] [datetime] NULL,
	[AcceptedTime] [datetime] NULL,
	[DoneTime] [datetime] NULL,						-- Finished, Denied, Escalated

	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_DPTProvider] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[DPTProvider] ADD  CONSTRAINT [DF_DPTProvider_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[DPTProvider] ADD  CONSTRAINT [DF_DPTProvider_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPT]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTProvider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPTProvider_DPT]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPTProvider]  WITH CHECK ADD  CONSTRAINT [FK_DPTProvider_DPT] FOREIGN KEY([DPTId])
	REFERENCES [dbo].[DPT] ([Id])

	ALTER TABLE [dbo].[DPTProvider] CHECK CONSTRAINT [FK_DPTProvider_DPT]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTProvider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPTProvider_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPTProvider]  WITH CHECK ADD  CONSTRAINT [FK_DPTProvider_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[DPTProvider] CHECK CONSTRAINT [FK_DPTProvider_Provider]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderService]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTProvider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPTProvider_ProviderService]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPTProvider]  WITH CHECK ADD  CONSTRAINT [FK_DPTProvider_ProviderService] FOREIGN KEY([ProviderServiceId])
	REFERENCES [dbo].[ProviderService] ([Id])

	ALTER TABLE [dbo].[DPTProvider] CHECK CONSTRAINT [FK_DPTProvider_ProviderService]
end

-------------------------- End Foreign Key ---------------------------------------------------------------

-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTProvider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTProviderQuery]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPTProviderQuery_DPTProviderId]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPTProviderQuery]  WITH CHECK ADD  CONSTRAINT [FK_DPTProviderQuery_DPTProviderId] FOREIGN KEY([DPTProviderId])
	REFERENCES [dbo].[DPTProvider] ([Id])

	ALTER TABLE [dbo].[DPTProviderQuery] CHECK CONSTRAINT [FK_DPTProviderQuery_DPTProviderId]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTProvider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTProviderTwilioAccount]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPTProviderTwilioAccount_DPTProvider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPTProviderTwilioAccount]  WITH CHECK ADD  CONSTRAINT [FK_DPTProviderTwilioAccount_DPTProvider] FOREIGN KEY([DPTProviderId])
	REFERENCES [dbo].[DPTProvider] ([Id])

	ALTER TABLE [dbo].[DPTProviderTwilioAccount] CHECK CONSTRAINT [FK_DPTProviderTwilioAccount_DPTProvider]
end

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------



select * from [DPTProvider]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_DPTProvider_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DPTProvider]') AND name = N'IX_DPTProvider_1')
DROP INDEX [IX_DPTProvider_1] ON [dbo].[DPTProvider]
GO




/****** Object:  Index [IX_DPTProvider_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_DPTProvider_1] ON [dbo].[DPTProvider]
(
	[DPTId] ASC,
	[ProviderId] ASC,
	[DPTProviderStatusCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

-----------------------------------------------------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DPTProvider]') AND name = N'IX_DPTProvider_2')
begin
	print 'DROP INDEX [IX_DPTProvider_2] ON [dbo].[DPTProvider]'
	DROP INDEX [IX_DPTProvider_2] ON [dbo].[DPTProvider]
end
GO

CREATE NONCLUSTERED INDEX [IX_DPTProvider_2] ON [dbo].[DPTProvider]
(
	[DoneTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

---------------------------------------------------------------End Index------------------------------------------------------------------
