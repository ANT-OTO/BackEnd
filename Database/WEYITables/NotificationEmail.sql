
/****** Object:  Table [dbo].[NotificationEmail]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NotificationEmail]') AND type in (N'U'))
Begin
	/*

	DROP TABLE [dbo].[NotificationEmail]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'NotificationEmail')
	)	
	
	declare @TblName as nvarchar(64) = 'NotificationEmail'
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
	print 'you need to manually exec DROP TABLE [dbo].[NotificationEmail] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[NotificationEmail](
	[Id] [int] IDENTITY(1,1) NOT NULL,

	[EmailEngineId] [int] NOT NULL,
	
	[ToEmail] [nvarchar](256) NOT NULL,

	[FromDisplayName] [nvarchar](128) NOT NULL,
	[FromEmail] [nvarchar](256) NOT NULL,
	[CCEmail] [nvarchar](256) NOT NULL,
	
	[SystemLanguageId] [int] NOT NULL,		

	[SubjectMsgTemplateId] [int] NOT NULL,		
	[Subject] [nvarchar](max) NOT NULL,
	
	[MsgTemplateId] [int] NOT NULL,		
	[Msg] [nvarchar](max) NOT NULL,
	
	[Sent] [bit] NOT NULL,				-- Indicating whether the message was sent to the EmailEngine  
	[SentTime] [datetime] NULL,			-- When the message was sent to the EmailEngine 
	
	[DeliveryConfirmed] [bit] NULL,
	[DeliveryTime] [datetime] NULL,			
	
	[RefTable] [nvarchar](64) NULL,	-- can be used for debugging purposes, or control of request
	[RefId] [int] NULL,			
	
	[Status] [nvarchar](64) NOT NULL,	-- New, In Process, Sent, Failed
	
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_NotificationEmail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]




ALTER TABLE [dbo].[NotificationEmail] ADD  CONSTRAINT [DF_NotificationEmail_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[NotificationEmail] ADD  CONSTRAINT [DF_NotificationEmail_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]




-------------------------- Begin Foreign Key ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsgTemplate]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NotificationEmail]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotificationEmail_MsgTemplate]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[NotificationEmail]  WITH CHECK ADD  CONSTRAINT [FK_NotificationEmail_MsgTemplate] FOREIGN KEY([MsgTemplateId])
	REFERENCES [dbo].[MsgTemplate] ([Id])

	ALTER TABLE [dbo].[NotificationEmail] CHECK CONSTRAINT [FK_NotificationEmail_MsgTemplate]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MsgTemplate]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NotificationEmail]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotificationEmail_SubjectMsgTemplate]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[NotificationEmail]  WITH CHECK ADD  CONSTRAINT [FK_NotificationEmail_SubjectMsgTemplate] FOREIGN KEY([SubjectMsgTemplateId])
	REFERENCES [dbo].[MsgTemplate] ([Id])

	ALTER TABLE [dbo].[NotificationEmail] CHECK CONSTRAINT [FK_NotificationEmail_SubjectMsgTemplate]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailEngine]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NotificationEmail]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotificationEmail_EmailEngine]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[NotificationEmail]  WITH CHECK ADD  CONSTRAINT [FK_NotificationEmail_EmailEngine] FOREIGN KEY([EmailEngineId])
	REFERENCES [dbo].[EmailEngine] ([Id])

	ALTER TABLE [dbo].[NotificationEmail] CHECK CONSTRAINT [FK_NotificationEmail_EmailEngine]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemLanguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NotificationEmail]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotificationEmail_SystemLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[NotificationEmail]  WITH CHECK ADD  CONSTRAINT [FK_NotificationEmail_SystemLanguage] FOREIGN KEY([SystemLanguageId])
	REFERENCES [dbo].[SystemLanguage] ([Id])

	ALTER TABLE [dbo].[NotificationEmail] CHECK CONSTRAINT [FK_NotificationEmail_SystemLanguage]
end

-------------------------- End Foreign Key ---------------------------------------------------------------


-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------

select * from [NotificationEmail]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())



/****** Object:  Index [IX_NotificationEmail_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[NotificationEmail]') AND name = N'IX_NotificationEmail_1')
DROP INDEX [IX_NotificationEmail_1] ON [dbo].[NotificationEmail]
GO




/****** Object:  Index [IX_NotificationEmail_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_NotificationEmail_1] ON [dbo].[NotificationEmail]
(
	[RefTable] ASC,
	[RefId] ASC,
	[Sent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---------------------------------------------------------------End Index------------------------------------------------------------------

