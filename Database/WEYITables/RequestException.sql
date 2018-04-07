
/****** Object:  Table [dbo].[RequestException]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestException]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[RequestException]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'RequestException')
	)	
	

	
	declare @TblName as nvarchar(64) = 'RequestException'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[RequestException] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[RequestException](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RequestId] [int] NOT NULL,
	[CompanyId] [int] NOT NULL,

	[ExceptionStatusCodeId] [int] NOT NULL,		-- CodeList (Category: ExceptionStatus) 
												-- select * from CodeList where Category = 'ExceptionStatus'
	[AgentId] [int] NULL,						-- Foreign key to WEYIMgr.dbo.Agent	
												-- select * from WEYIMgr.dbo.Agent	
												-- select * from WEYIMgr.dbo.CompanyAgent	
	[ExceptionPMScheduleId] [int] NULL,			-- Foreign key to WEYIMgr.ExceptionPMSchedule. Based on this Id, we should be able to get the Phone Number.
	[ExceptionBackupScheduleId] [int] NULL,		-- Foreign key to WEYIMgr.ExceptionBackupSchedule. Based on this Id, we should be able to get the Phone Number.
	[ProviderId] [int] NULL,
	[ChannelNumber] [int] NULL,

	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_RequestException] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[RequestException] ADD  CONSTRAINT [DF_RequestException_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[RequestException] ADD  CONSTRAINT [DF_RequestException_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Request]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestException]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestException_Request]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestException]  WITH CHECK ADD  CONSTRAINT [FK_RequestException_Request] FOREIGN KEY([RequestId])
	REFERENCES [dbo].[Request] ([Id])

	ALTER TABLE [dbo].[RequestException] CHECK CONSTRAINT [FK_RequestException_Request]
end


-------------------------- End Foreign Key ---------------------------------------------------------------


-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [RequestException]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RequestException]') AND name = N'IX_RequestException_1')
DROP INDEX [IX_RequestException_1] ON [dbo].[RequestException]
GO




CREATE UNIQUE NONCLUSTERED INDEX [IX_RequestException_1] ON [dbo].[RequestException]
(
	[RequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RequestException]') AND name = N'IX_RequestException_2')
DROP INDEX [IX_RequestException_2] ON [dbo].[RequestException]
GO




CREATE NONCLUSTERED INDEX [IX_RequestException_2] ON [dbo].[RequestException]
(
	[CompanyId] ASC,
	[ExceptionStatusCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

---------------------------------------------------------------End Index------------------------------------------------------------------
