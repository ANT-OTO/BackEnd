
/****** Object:  Table [dbo].[Request]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Request]') AND type in (N'U'))
Begin
	/*
	
alter table [RequestCall] drop constraint [FK_RequestCall_Request]
alter table [RequestEval] drop constraint [FK_RequestEval_Request]
alter table [RequestEvalByProvider] drop constraint [FK_RequestEvalByProvider_Request]
alter table [RequestPicture] drop constraint [FK_RequestPicture_Request]
alter table [RequestProvider] drop constraint [FK_RequestProvider_Request]
	
	DROP TABLE [dbo].[Request]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'Request')
	)
	
	
	declare @TblName as nvarchar(64) = 'Request'
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
	print 'you need to manually exec DROP TABLE [dbo].[Request] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[Request](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NULL,				-- 
	[LanguageId] [int] NOT NULL,		-- Request Help on

	[SituationCodeId] [int] NOT NULL,	-- CodeList (Category; RequestSituation): In retaurant, etc.
	[Note] nvarchar(max) NOT NULL,		-- Note by the Person

	[RequestStatusCodeId] [int] NOT NULL,		
										-- CodeList (Category; RequestStatus): New, In Service, Serviced, Cancelled, Cancelled After Failed Service
	

	[ProviderId] [int] NULL,			-- Provider who performed service
	[ProviderRate] [money] NULL,		-- Charge per hour
	[Amount] [money] NULL,				-- Total charge amount
	

	[TotalTime] Decimal(10, 2) NULL,			-- Total time in seconds

	--[ServiceStartTime] [datetime] NULL,
	--[ServiceEndTime] [datetime] NULL,
	--[CancelledTime] [datetime] NULL,
	
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_Request] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]




--ALTER TABLE [dbo].[Request] ADD  CONSTRAINT [DF_Request_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
--ALTER TABLE [dbo].[Request] ADD  CONSTRAINT [DF_Request_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Request]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_Request_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[Request]  WITH CHECK ADD  CONSTRAINT [FK_Request_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[Request] CHECK CONSTRAINT [FK_Request_Person]
end

-------------------------- End Foreign Key ---------------------------------------------------------------

--------------------------------------------------- Begin Primary Key Referenced by other tables -------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Request]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestCall]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestCall_Request]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestCall]  WITH CHECK ADD  CONSTRAINT [FK_RequestCall_Request] FOREIGN KEY([RequestId])
	REFERENCES [dbo].[Request] ([Id])

	ALTER TABLE [dbo].[RequestCall] CHECK CONSTRAINT [FK_RequestCall_Request]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Request]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestEval]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestEval_Request]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestEval]  WITH CHECK ADD  CONSTRAINT [FK_RequestEval_Request] FOREIGN KEY([RequestId])
	REFERENCES [dbo].[Request] ([Id])

	ALTER TABLE [dbo].[RequestEval] CHECK CONSTRAINT [FK_RequestEval_Request]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Request]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestEvalByProvider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestEvalByProvider_Request]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestEvalByProvider]  WITH CHECK ADD  CONSTRAINT [FK_RequestEvalByProvider_Request] FOREIGN KEY([RequestId])
	REFERENCES [dbo].[Request] ([Id])

	ALTER TABLE [dbo].[RequestEvalByProvider] CHECK CONSTRAINT [FK_RequestEvalByProvider_Request]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Request]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestPicture]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestPicture_Request]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestPicture]  WITH CHECK ADD  CONSTRAINT [FK_RequestPicture_Request] FOREIGN KEY([RequestId])
	REFERENCES [dbo].[Request] ([Id])

	ALTER TABLE [dbo].[RequestPicture] CHECK CONSTRAINT [FK_RequestPicture_Request]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Request]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestProvider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestProvider_Request]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestProvider]  WITH CHECK ADD  CONSTRAINT [FK_RequestProvider_Request] FOREIGN KEY([RequestId])
	REFERENCES [dbo].[Request] ([Id])

	ALTER TABLE [dbo].[RequestProvider] CHECK CONSTRAINT [FK_RequestProvider_Request]
end


--------------------------------------------------- End Primary Key Referenced by other tables -------------------------------------------


select * from [Request]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_Request_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Request]') AND name = N'IX_Request_1')
DROP INDEX [IX_Request_1] ON [dbo].[Request]
GO




/****** Object:  Index [IX_Request_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_Request_1] ON [dbo].[Request]
(
	[PersonId] ASC,
	[ProviderId] ASC,
	[RequestStatusCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_Request_2]     ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Request]') AND name = N'IX_Request_2')
DROP INDEX [IX_Request_2] ON [dbo].[Request]
GO




/****** Object:  Index [IX_Request_2]    ******/
CREATE NONCLUSTERED INDEX [IX_Request_2] ON [dbo].[Request]
(
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
