
/****** Object:  Table [dbo].[RequestConferenceSession]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestConferenceSession]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[RequestConferenceSession]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'RequestConferenceSession')
	)	
	

	
	declare @TblName as nvarchar(64) = 'RequestConferenceSession'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[RequestConferenceSession] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[RequestConferenceSession](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RequestConferenceId] [int] NOT NULL,
	[RequestConferenceSessionStatusCodeId] [int] NOT NULL,
	[CallTypeCodeId] [int] NOT NULL,		-- CodeList (Category: CallType) Voice, Video
	[ConferenceName] nvarchar(256) NULL,
	[ConferenceSid] nvarchar(256) NULL,
	[StartTime] datetime NOT NULL,
	[EndTime] datetime NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_RequestConferenceSession] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[RequestConferenceSession] ADD  CONSTRAINT [DF_RequestConferenceSession_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
ALTER TABLE [dbo].[RequestConferenceSession] ADD  CONSTRAINT [DF_RequestConferenceSession_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestConference]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestConferenceSession]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestConferenceSession_RequestConference]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestConferenceSession]  WITH CHECK ADD  CONSTRAINT [FK_RequestConferenceSession_RequestConference] FOREIGN KEY([RequestConferenceId])
	REFERENCES [dbo].[RequestConference] ([Id])

	ALTER TABLE [dbo].[RequestConferenceSession] CHECK CONSTRAINT [FK_RequestConferenceSession_RequestConference]
end


-------------------------- End Foreign Key ---------------------------------------------------------------


-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [RequestConferenceSession]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_RequestConferenceSession_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RequestConferenceSession]') AND name = N'IX_RequestConferenceSession_1')
DROP INDEX [IX_RequestConferenceSession_1] ON [dbo].[RequestConferenceSession]
GO




/****** Object:  Index [IX_RequestConferenceSession_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_RequestConferenceSession_1] ON [dbo].[RequestConferenceSession]
(
	[RequestConferenceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
