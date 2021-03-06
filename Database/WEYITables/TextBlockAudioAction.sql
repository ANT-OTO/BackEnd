
/****** Object:  Table [dbo].[TextBlockAudioAction]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlockAudioAction]') AND type in (N'U'))
Begin
	/*
	
alter table [TextBlockRecvd] drop constraint [FK_TextBlockRecvd_TextBlockAudioAction]

	DROP TABLE [dbo].[TextBlockAudioAction]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'TextBlockAudioAction')
	)	
	
	

	declare @TblName as nvarchar(64) = 'TextBlockAudioAction'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[TextBlockAudioAction] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[TextBlockAudioAction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TextBlockId] [int] NOT NULL,	
	[ActionType] varchar(32) NOT NULL,			-- Add, Delete
	[FromCaller] bit NOT NULL,					-- 1: yes, it is from the caller. 0: No, it is from the listener

	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TextBlockAudioAction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlock]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlockAudioAction]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextBlockAudioAction_TextBlock]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextBlockAudioAction]  WITH CHECK ADD  CONSTRAINT [FK_TextBlockAudioAction_TextBlock] FOREIGN KEY([TextBlockId])
	REFERENCES [dbo].[TextBlock] ([Id])

	ALTER TABLE [dbo].[TextBlockAudioAction] CHECK CONSTRAINT [FK_TextBlockAudioAction_TextBlock]
end



-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlockAudioAction]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlockRecvd]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextBlockRecvd_TextBlockAudioAction]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextBlockRecvd]  WITH CHECK ADD  CONSTRAINT [FK_TextBlockRecvd_TextBlockAudioAction] FOREIGN KEY([TextBlockAudioActionId])
	REFERENCES [dbo].[TextBlockAudioAction] ([Id])

	ALTER TABLE [dbo].[TextBlockRecvd] CHECK CONSTRAINT [FK_TextBlockRecvd_TextBlockAudioAction]
end

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [TextBlockAudioAction]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_TextBlockAudioAction_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TextBlockAudioAction]') AND name = N'IX_TextBlockAudioAction_1')
DROP INDEX [IX_TextBlockAudioAction_1] ON [dbo].[TextBlockAudioAction]
GO




/****** Object:  Index [IX_TextBlockAudioAction_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_TextBlockAudioAction_1] ON [dbo].[TextBlockAudioAction]
(
	[TextBlockId] ASC,
	[FromCaller] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
