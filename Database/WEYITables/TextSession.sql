
/****** Object:  Table [dbo].[TextSession]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextSession]') AND type in (N'U'))
Begin
	/*
	
alter table [TextBlock] drop constraint [FK_TextBlock_TextSession]
alter table [TextBlockRecvd] drop constraint [FK_TextBlockRecvd_TextSession]

	DROP TABLE [dbo].[TextSession]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'TextSession')
	)	
	
	

	declare @TblName as nvarchar(64) = 'TextSession'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[TextSession] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[TextSession](
	[Id] [int] IDENTITY(1,1) NOT NULL,

	[RequestId] [int] NULL,				-- If RequestId is not null, it means the caller is the Person (Client)
	[InterviewId] [int] NULL,			-- If InterviewId is not null, it means the caller is the Interviewer (Provider)

	[ListenerProviderId] [int] NULL,

	[PersonId] [int] NULL,				-- If PersonId is not null, it means it is machine translation


	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_TextSession] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Request]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextSession]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextSession_Request]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextSession]  WITH CHECK ADD  CONSTRAINT [FK_TextSession_Request] FOREIGN KEY([RequestId])
	REFERENCES [dbo].[Request] ([Id])

	ALTER TABLE [dbo].[TextSession] CHECK CONSTRAINT [FK_TextSession_Request]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextSession]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextSession_Interview]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextSession]  WITH CHECK ADD  CONSTRAINT [FK_TextSession_Interview] FOREIGN KEY([InterviewId])
	REFERENCES [dbo].[Interview] ([Id])

	ALTER TABLE [dbo].[TextSession] CHECK CONSTRAINT [FK_TextSession_Interview]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextSession]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextSession_ListenerProvider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextSession]  WITH CHECK ADD  CONSTRAINT [FK_TextSession_ListenerProvider] FOREIGN KEY([ListenerProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[TextSession] CHECK CONSTRAINT [FK_TextSession_ListenerProvider]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextSession]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextSession_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextSession]  WITH CHECK ADD  CONSTRAINT [FK_TextSession_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[TextSession] CHECK CONSTRAINT [FK_TextSession_Person]
end

-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextSession]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlock]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextBlock_TextSession]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextBlock]  WITH CHECK ADD  CONSTRAINT [FK_TextBlock_TextSession] FOREIGN KEY([TextSessionId])
	REFERENCES [dbo].[TextSession] ([Id])

	ALTER TABLE [dbo].[TextBlock] CHECK CONSTRAINT [FK_TextBlock_TextSession]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextSession]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlockRecvd]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextBlockRecvd_TextSession]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextBlockRecvd]  WITH CHECK ADD  CONSTRAINT [FK_TextBlockRecvd_TextSession] FOREIGN KEY([TextSessionId])
	REFERENCES [dbo].[TextSession] ([Id])

	ALTER TABLE [dbo].[TextBlockRecvd] CHECK CONSTRAINT [FK_TextBlockRecvd_TextSession]
end

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [TextSession]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_TextSession_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TextSession]') AND name = N'IX_TextSession_1')
DROP INDEX [IX_TextSession_1] ON [dbo].[TextSession]
GO




/****** Object:  Index [IX_TextSession_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_TextSession_1] ON [dbo].[TextSession]
(
	[RequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



/****** Object:  Index [IX_TextSession_2]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TextSession]') AND name = N'IX_TextSession_2')
DROP INDEX [IX_TextSession_2] ON [dbo].[TextSession]
GO




/****** Object:  Index [IX_TextSession_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_TextSession_2] ON [dbo].[TextSession]
(
	[InterviewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



/****** Object:  Index [IX_TextSession_3]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TextSession]') AND name = N'IX_TextSession_3')
DROP INDEX [IX_TextSession_3] ON [dbo].[TextSession]
GO




/****** Object:  Index [IX_TextSession_3]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_TextSession_3] ON [dbo].[TextSession]
(
	[ListenerProviderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---------------------------------------------------------------End Index------------------------------------------------------------------
