
/****** Object:  Table [dbo].[ScheduledRequest]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduledRequest]') AND type in (N'U'))
Begin
	/*
	
alter table [ScheduledRequestCall] drop constraint [FK_ScheduledRequestCall_ScheduledRequest]
alter table [ScheduledRequestEval] drop constraint [FK_ScheduledRequestEval_ScheduledRequest]
alter table [ScheduledRequestEvalByProvider] drop constraint [FK_ScheduledRequestEvalByProvider_ScheduledRequest]
alter table [ScheduledRequestPicture] drop constraint [FK_ScheduledRequestPicture_ScheduledRequest]
alter table [ScheduledRequestProvider] drop constraint [FK_ScheduledRequestProvider_ScheduledRequest]
	
	DROP TABLE [dbo].[ScheduledRequest]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ScheduledRequest')
	)
	
	
	declare @TblName as nvarchar(64) = 'ScheduledRequest'
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
	print 'you need to manually exec DROP TABLE [dbo].[ScheduledRequest] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ScheduledRequest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NULL,				-- 
	[ToLanguageId] [int] NOT NULL,		-- ScheduledRequest Help on
	[FromLanguageId] [int] NOT NULL,
	[ScheduledRequestStatusCodeId] [int] NOT NULL,		
										-- CodeList (Category; ScheduledRequestStatus): New, In Service, Serviced, Cancelled, Cancelled After Failed Service
	[ProviderId] [int] NULL,			-- Provider who performed service
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_ScheduledRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]




--ALTER TABLE [dbo].[ScheduledRequest] ADD  CONSTRAINT [DF_ScheduledRequest_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
--ALTER TABLE [dbo].[ScheduledRequest] ADD  CONSTRAINT [DF_ScheduledRequest_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduledRequest]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScheduledRequest_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScheduledRequest]  WITH CHECK ADD  CONSTRAINT [FK_ScheduledRequest_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[ScheduledRequest] CHECK CONSTRAINT [FK_ScheduledRequest_Person]
end

-------------------------- End Foreign Key ---------------------------------------------------------------

--------------------------------------------------- Begin Primary Key Referenced by other tables -------------------------------------------



--------------------------------------------------- End Primary Key Referenced by other tables -------------------------------------------


select * from [ScheduledRequest]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_ScheduledRequest_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduledRequest]') AND name = N'IX_ScheduledRequest_1')
DROP INDEX [IX_ScheduledRequest_1] ON [dbo].[ScheduledRequest]
GO




/****** Object:  Index [IX_ScheduledRequest_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ScheduledRequest_1] ON [dbo].[ScheduledRequest]
(
	[PersonId] ASC,
	[ProviderId] ASC,
	[ScheduledRequestStatusCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_ScheduledRequest_2]     ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduledRequest]') AND name = N'IX_ScheduledRequest_2')
DROP INDEX [IX_ScheduledRequest_2] ON [dbo].[ScheduledRequest]
GO




/****** Object:  Index [IX_ScheduledRequest_2]    ******/
CREATE NONCLUSTERED INDEX [IX_ScheduledRequest_2] ON [dbo].[ScheduledRequest]
(
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_ScheduledRequest_3]     ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduledRequest]') AND name = N'IX_ScheduledRequest_3')
DROP INDEX [IX_ScheduledRequest_3] ON [dbo].[ScheduledRequest]
GO




/****** Object:  Index [IX_ScheduledRequest_3]    ******/
CREATE NONCLUSTERED INDEX [IX_ScheduledRequest_3] ON [dbo].[ScheduledRequest]
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
---------------------------------------------------------------End Index------------------------------------------------------------------
