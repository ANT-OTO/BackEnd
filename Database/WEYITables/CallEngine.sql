
/****** Object:  Table [dbo].[CallEngine]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CallEngine]') AND type in (N'U'))
Begin
	/*
	

alter table [CallEngineProperty] drop constraint [FK_CallEngineProperty_CallEngine]
alter table [InterviewCall] drop constraint [FK_InterviewCall_CallEngine]
alter table [RequestCall] drop constraint [FK_RequestCall_CallEngine]
	
	DROP TABLE [dbo].[CallEngine]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'CallEngine')
	)	
	
	
	declare @TblName as nvarchar(64) = 'CallEngine'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[CallEngine] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[CallEngine](
	[Id] [int] NOT NULL,
	[EngineName] [nvarchar](64) NOT NULL,			-- Twilio
	
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_CallEngine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]




ALTER TABLE [dbo].[CallEngine] ADD  CONSTRAINT [DF_CallEngine_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[CallEngine] ADD  CONSTRAINT [DF_CallEngine_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------


-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CallEngine]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CallEngineProperty]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_CallEngineProperty_CallEngine]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[CallEngineProperty]  WITH CHECK ADD  CONSTRAINT [FK_CallEngineProperty_CallEngine] FOREIGN KEY([CallEngineId])
	REFERENCES [dbo].[CallEngine] ([Id])

	ALTER TABLE [dbo].[CallEngineProperty] CHECK CONSTRAINT [FK_CallEngineProperty_CallEngine]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CallEngine]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewCall]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_InterviewCall_CallEngine]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[InterviewCall]  WITH CHECK ADD  CONSTRAINT [FK_InterviewCall_CallEngine] FOREIGN KEY([CallEngineId])
	REFERENCES [dbo].[CallEngine] ([Id])

	ALTER TABLE [dbo].[InterviewCall] CHECK CONSTRAINT [FK_InterviewCall_CallEngine]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CallEngine]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestCall]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestCall_CallEngine]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestCall]  WITH CHECK ADD  CONSTRAINT [FK_RequestCall_CallEngine] FOREIGN KEY([CallEngineId])
	REFERENCES [dbo].[CallEngine] ([Id])

	ALTER TABLE [dbo].[RequestCall] CHECK CONSTRAINT [FK_RequestCall_CallEngine]
end

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from CallEngine
end

GO

SET ANSI_PADDING OFF
GO

GO




---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())

/****** Object:  Index [IX_CallEngine_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CallEngine]') AND name = N'IX_CallEngine_1')
DROP INDEX [IX_CallEngine_1] ON [dbo].[CallEngine]
GO




/****** Object:  Index [IX_CallEngine_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_CallEngine_1] ON [dbo].[CallEngine]
(
	[EngineName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---------------------------------------------------------------End Index------------------------------------------------------------------

