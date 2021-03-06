
/****** Object:  Table [dbo].[RequestExceptionBackupCall]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestExceptionBackupCall]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[RequestExceptionBackupCall]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'RequestExceptionBackupCall')
	)	
	

	
	declare @TblName as nvarchar(64) = 'RequestExceptionBackupCall'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[RequestExceptionBackupCall] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[RequestExceptionBackupCall](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RequestExceptionId] [int] NOT NULL,
	[CallId] nvarchar(64) NULL,				-- CallId in Twilio
	[CallTypeCodeId] [int] NOT NULL,		-- CodeList (Category: CallType) Voice, Video
	[Connected] [bit] NULL,					
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[ParentStartTime] [datetime] NULL,
	[ParentEndTime] [datetime] NULL,
	[TotalSeconds] decimal(10, 2) NULL,
	[ParentTotalSeconds] decimal(10, 2) NULL,
	[Retrieved] [bit] NOT NULL,

	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_RequestExceptionBackupCall] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[RequestExceptionBackupCall] ADD  CONSTRAINT [DF_RequestBackupCall_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[RequestExceptionBackupCall] ADD  CONSTRAINT [DF_RequestBackupCall_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestException]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestExceptionBackupCall]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestExceptionBackupCall_RequestException]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestExceptionBackupCall]  WITH CHECK ADD  CONSTRAINT [FK_RequestExceptionBackupCall_RequestException] FOREIGN KEY([RequestExceptionId])
	REFERENCES [dbo].[RequestException] ([Id])

	ALTER TABLE [dbo].[RequestExceptionBackupCall] CHECK CONSTRAINT [FK_RequestExceptionBackupCall_RequestException]
end

-------------------------- End Foreign Key ---------------------------------------------------------------


-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [RequestExceptionBackupCall]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [RequestExceptionBackupCall_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RequestExceptionBackupCall]') AND name = N'RequestExceptionBackupCall_1')
DROP INDEX [RequestExceptionBackupCall_1] ON [dbo].[RequestExceptionBackupCall]
GO




/****** Object:  Index [RequestExceptionBackupCall_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [RequestExceptionBackupCall_1] ON [dbo].[RequestExceptionBackupCall]
(
	[RequestExceptionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [RequestExceptionBackupCall_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [RequestExceptionBackupCall_2] ON [dbo].[RequestExceptionBackupCall]
(
	[CallId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

---------------------------------------------------------------End Index------------------------------------------------------------------


/*

Use this to update 05/07/2016


  sp_rename 'RequestExceptionBackupCall.PackageData', 'Retrieved', 'COLUMN';
  GO


ALTER TABLE [dbo].[RequestExceptionBackupCall] drop CONSTRAINT [DF_RequestBackupCall_CreateDate]
ALTER TABLE [dbo].[RequestExceptionBackupCall] ADD  CONSTRAINT [DF_RequestBackupCall_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[RequestExceptionBackupCall] drop CONSTRAINT [DF_RequestBackupCall_LastUpdate]
ALTER TABLE [dbo].[RequestExceptionBackupCall] ADD  CONSTRAINT [DF_RequestBackupCall_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]

*/

