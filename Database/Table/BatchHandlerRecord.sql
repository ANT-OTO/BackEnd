
/****** Object:  Table [dbo].[BatchHandlerRecord]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO 



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BatchHandlerRecord]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[BatchHandlerRecord]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'BatchHandlerRecord')
	)	
	
	

	declare @TblName as nvarchar(64) = 'BatchHandlerRecord'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[BatchHandlerRecord] ' + convert(varchar, getdate())
	
End
else
begin 
 
CREATE TABLE [dbo].[BatchHandlerRecord](
	[Id] [int] IDENTITY(1001,1) NOT NULL,
	[BatchHandlerId] int NOT NULL,
	[RecordNumber] nvarchar(256) NOT NULL,
	[BatchHandlerRecordStatusCodeId] int NOT NULL, --select * from CodeList where Category = 'BatchHandlerRecordStatus'
	[Reason] nvarchar(256) NULL,
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[LastUpdateBy] [int] NOT NULL,
	[LastUpdateByType] [smallint] NOT NULL,
 CONSTRAINT [PK_BatchHandlerRecord] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[BatchHandlerRecord] ADD  CONSTRAINT [DF_BatchHandlerRecord_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[BatchHandlerRecord] ADD  CONSTRAINT [DF_BatchHandlerRecord_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]







select * from [BatchHandlerRecord]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_BatchHandlerRecord_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BatchHandlerRecord]') AND name = N'IX_BatchHandlerRecord_1')
DROP INDEX [IX_BatchHandlerRecord_1] ON [dbo].[BatchHandlerRecord]
GO




/****** Object:  Index [IX_BatchHandlerRecord_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_BatchHandlerRecord_1] ON [dbo].[BatchHandlerRecord]
(
	[BatchHandlerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
