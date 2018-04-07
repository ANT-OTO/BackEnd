
/****** Object:  Table [dbo].[NotificationText]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NotificationText]') AND type in (N'U'))
Begin
	/*

	DROP TABLE [dbo].[NotificationText]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'NotificationText')
	)	
	
	declare @TblName as nvarchar(64) = 'NotificationText'
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
	print 'you need to manually exec DROP TABLE [dbo].[NotificationText] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[NotificationText](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	
	[MsgTemplateId] [int] NOT NULL,		
	[SystemLanguageId] [int] NOT NULL,		
	
	[RegionId] int NOT NULL,
	[MobilePhone] [varchar](32) NOT NULL,
	
	[Msg] [nvarchar](max) NOT NULL,
	
	[Sent] [bit] NOT NULL,				-- Indicating whether the text message was sent to the TextEngine  
	[SentTime] [datetime] NULL,			-- When the text message was sent to the TextEngine 
	
	[DeliveryConfirmed] [bit] NULL,
	[DeliveryTime] [datetime] NULL,			
	
	[RefTable] [nvarchar](64) NULL,		-- can be used for debugging purposes, or control of request
	[RefId] [int] NULL,			
	
	[Status] [nvarchar](64) NOT NULL,	-- New, In Process, Sent, Failed

	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_NotificationText] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]




ALTER TABLE [dbo].[NotificationText] ADD  CONSTRAINT [DF_NotificationText_CreateDate]  DEFAULT (GETUTCDATE()) FOR [CreateDate]
ALTER TABLE [dbo].[NotificationText] ADD  CONSTRAINT [DF_NotificationText_LastUpdate]  DEFAULT (GETUTCDATE()) FOR [LastUpdate]



-------------------------- Begin Foreign Key ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsgTemplate]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NotificationText]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotificationText_MsgTemplate]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[NotificationText]  WITH CHECK ADD  CONSTRAINT [FK_NotificationText_MsgTemplate] FOREIGN KEY([MsgTemplateId])
	REFERENCES [dbo].[MsgTemplate] ([Id])

	ALTER TABLE [dbo].[NotificationText] CHECK CONSTRAINT [FK_NotificationText_MsgTemplate]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemLanguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NotificationText]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotificationText_SystemLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[NotificationText]  WITH CHECK ADD  CONSTRAINT [FK_NotificationText_SystemLanguage] FOREIGN KEY([SystemLanguageId])
	REFERENCES [dbo].[SystemLanguage] ([Id])

	ALTER TABLE [dbo].[NotificationText] CHECK CONSTRAINT [FK_NotificationText_SystemLanguage]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Region]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NotificationText]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotificationText_Region]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[NotificationText]  WITH CHECK ADD  CONSTRAINT [FK_NotificationText_Region] FOREIGN KEY([RegionId])
	REFERENCES [dbo].[Region] ([Id])

	ALTER TABLE [dbo].[NotificationText] CHECK CONSTRAINT [FK_NotificationText_Region]
end


-------------------------- End Foreign Key ---------------------------------------------------------------


-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------

select * from [NotificationText]
end

GO

SET ANSI_PADDING OFF
GO

GO





---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())

/****** Object:  Index [IX_NotificationText_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[NotificationText]') AND name = N'IX_NotificationText_1')
DROP INDEX [IX_NotificationText_1] ON [dbo].[NotificationText]
GO




/****** Object:  Index [IX_NotificationText_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_NotificationText_1] ON [dbo].[NotificationText]
(
	[RefTable] ASC,
	[RefId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_NotificationText_2]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[NotificationText]') AND name = N'IX_NotificationText_2')
DROP INDEX [IX_NotificationText_2] ON [dbo].[NotificationText]
GO




/****** Object:  Index [IX_NotificationText_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_NotificationText_2] ON [dbo].[NotificationText]
(
	[Status] ASC,
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------

