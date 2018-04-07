
/****** Object:  Table [dbo].[TextBlock]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlock]') AND type in (N'U'))
Begin
	/*
	
alter table [TextBlockAudio] drop constraint [FK_TextBlockAudio_TextBlock]
alter table [TextBlockAudioAction] drop constraint [FK_TextBlockAudioAction_TextBlock]
alter table [TextBlockImage] drop constraint [FK_TextBlockImage_TextBlock]
alter table [TextBlockImageAction] drop constraint [FK_TextBlockImageAction_TextBlock]
alter table [TextBlockRecvd] drop constraint [FK_TextBlockRecvd_TextBlock]
alter table [TextBlockText] drop constraint [FK_TextBlockText_TextBlock]

	DROP TABLE [dbo].[TextBlock]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'TextBlock')
	)	
	
	

	declare @TblName as nvarchar(64) = 'TextBlock'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[TextBlock] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[TextBlock](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TextSessionId] [int] NULL,	

	[CallerStartTime] [datetime] NULL,
	[CallerEndTime] [datetime] NULL,
	
	[ListenerStartTime] [datetime] NULL,
	[ListenerEndTime] [datetime] NULL,

	[Deleted] [bit] NOT NULL,

	[FromLanguageId] int NULL,
	[ToLanguageId] int NULL,

	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_TextBlock] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextSession]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlock]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextBlock_TextSession]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextBlock]  WITH CHECK ADD  CONSTRAINT [FK_TextBlock_TextSession] FOREIGN KEY([TextSessionId])
	REFERENCES [dbo].[TextSession] ([Id])

	ALTER TABLE [dbo].[TextBlock] CHECK CONSTRAINT [FK_TextBlock_TextSession]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlock]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextBlock_FromLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextBlock]  WITH CHECK ADD  CONSTRAINT [FK_TextBlock_FromLanguage] FOREIGN KEY([FromLanguageId])
	REFERENCES [dbo].[Language] ([Id])

	ALTER TABLE [dbo].[TextBlock] CHECK CONSTRAINT [FK_TextBlock_FromLanguage]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlock]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextBlock_ToLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextBlock]  WITH CHECK ADD  CONSTRAINT [FK_TextBlock_ToLanguage] FOREIGN KEY([ToLanguageId])
	REFERENCES [dbo].[Language] ([Id])

	ALTER TABLE [dbo].[TextBlock] CHECK CONSTRAINT [FK_TextBlock_ToLanguage]
end


-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlock]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlockAudio]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextBlockAudio_TextBlock]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextBlockAudio]  WITH CHECK ADD  CONSTRAINT [FK_TextBlockAudio_TextBlock] FOREIGN KEY([TextBlockId])
	REFERENCES [dbo].[TextBlock] ([Id])

	ALTER TABLE [dbo].[TextBlockAudio] CHECK CONSTRAINT [FK_TextBlockAudio_TextBlock]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlock]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlockAudioAction]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextBlockAudioAction_TextBlock]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextBlockAudioAction]  WITH CHECK ADD  CONSTRAINT [FK_TextBlockAudioAction_TextBlock] FOREIGN KEY([TextBlockId])
	REFERENCES [dbo].[TextBlock] ([Id])

	ALTER TABLE [dbo].[TextBlockAudioAction] CHECK CONSTRAINT [FK_TextBlockAudioAction_TextBlock]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlock]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlockImage]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextBlockImage_TextBlock]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextBlockImage]  WITH CHECK ADD  CONSTRAINT [FK_TextBlockImage_TextBlock] FOREIGN KEY([TextBlockId])
	REFERENCES [dbo].[TextBlock] ([Id])

	ALTER TABLE [dbo].[TextBlockImage] CHECK CONSTRAINT [FK_TextBlockImage_TextBlock]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlock]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlockImageAction]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextBlockImageAction_TextBlock]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextBlockImageAction]  WITH CHECK ADD  CONSTRAINT [FK_TextBlockImageAction_TextBlock] FOREIGN KEY([TextBlockId])
	REFERENCES [dbo].[TextBlock] ([Id])

	ALTER TABLE [dbo].[TextBlockImageAction] CHECK CONSTRAINT [FK_TextBlockImageAction_TextBlock]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlock]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlockRecvd]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextBlockRecvd_TextBlock]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextBlockRecvd]  WITH CHECK ADD  CONSTRAINT [FK_TextBlockRecvd_TextBlock] FOREIGN KEY([TextBlockId])
	REFERENCES [dbo].[TextBlock] ([Id])

	ALTER TABLE [dbo].[TextBlockRecvd] CHECK CONSTRAINT [FK_TextBlockRecvd_TextBlock]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlock]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlockText]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextBlockText_TextBlock]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextBlockText]  WITH CHECK ADD  CONSTRAINT [FK_TextBlockText_TextBlock] FOREIGN KEY([TextBlockId])
	REFERENCES [dbo].[TextBlock] ([Id])

	ALTER TABLE [dbo].[TextBlockText] CHECK CONSTRAINT [FK_TextBlockText_TextBlock]
end


-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [TextBlock]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_TextBlock_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TextBlock]') AND name = N'IX_TextBlock_1')
DROP INDEX [IX_TextBlock_1] ON [dbo].[TextBlock]
GO




/****** Object:  Index [IX_TextBlock_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_TextBlock_1] ON [dbo].[TextBlock]
(
	[TextSessionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


--------------------------------------------------------------------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TextBlock]') AND name = N'IX_TextBlock_2')
DROP INDEX [IX_TextBlock_2] ON [dbo].[TextBlock]
GO



CREATE NONCLUSTERED INDEX [IX_TextBlock_2] ON [dbo].[TextBlock]
(
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---------------------------------------------------------------End Index------------------------------------------------------------------
