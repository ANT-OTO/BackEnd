
/****** Object:  Table [dbo].[ScriptStep]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStep]') AND type in (N'U'))
Begin
	/*
	
alter table [ScriptStepAction] drop constraint [FK_ScriptStepAction_ScriptStep]
alter table [ScriptStepInput] drop constraint [FK_ScriptStepInput_ScriptStep]
alter table [ScriptStepPrompt] drop constraint [FK_ScriptStepPrompt_ScriptStep]

	DROP TABLE [dbo].[ScriptStep]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ScriptStep')
	)	
	
	

	declare @TblName as nvarchar(64) = 'ScriptStep'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[ScriptStep] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ScriptStep](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ScriptMasterId] [int] NOT NULL,

	[StepCode] nvarchar(32) NOT NULL,
	[StepName] nvarchar(128) NOT NULL,
	[Available] [bit] NOT NULL,

	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_ScriptStep] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



ALTER TABLE [dbo].[ScriptStep] ADD  CONSTRAINT [DF_ScriptStep_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[ScriptStep] ADD  CONSTRAINT [DF_ScriptStep_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptMaster]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStep]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScriptStep_ScriptMaster]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScriptStep]  WITH CHECK ADD  CONSTRAINT [FK_ScriptStep_ScriptMaster] FOREIGN KEY([ScriptMasterId])
	REFERENCES [dbo].[ScriptMaster] ([Id])

	ALTER TABLE [dbo].[ScriptStep] CHECK CONSTRAINT [FK_ScriptStep_ScriptMaster]
end

-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStep]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStepAction]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScriptStepAction_ScriptStep]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScriptStepAction]  WITH CHECK ADD  CONSTRAINT [FK_ScriptStepAction_ScriptStep] FOREIGN KEY([ScriptStepId])
	REFERENCES [dbo].[ScriptStep] ([Id])

	ALTER TABLE [dbo].[ScriptStepAction] CHECK CONSTRAINT [FK_ScriptStepAction_ScriptStep]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStep]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStepInput]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScriptStepInput_ScriptStep]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScriptStepInput]  WITH CHECK ADD  CONSTRAINT [FK_ScriptStepInput_ScriptStep] FOREIGN KEY([ScriptStepId])
	REFERENCES [dbo].[ScriptStep] ([Id])

	ALTER TABLE [dbo].[ScriptStepInput] CHECK CONSTRAINT [FK_ScriptStepInput_ScriptStep]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStep]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStepPrompt]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScriptStepPrompt_ScriptStep]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScriptStepPrompt]  WITH CHECK ADD  CONSTRAINT [FK_ScriptStepPrompt_ScriptStep] FOREIGN KEY([ScriptStepId])
	REFERENCES [dbo].[ScriptStep] ([Id])

	ALTER TABLE [dbo].[ScriptStepPrompt] CHECK CONSTRAINT [FK_ScriptStepPrompt_ScriptStep]
end


-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [ScriptStep]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStep]') AND name = N'IX_ScriptStep_1')
DROP INDEX [IX_ScriptStep_1] ON [dbo].[ScriptStep]
GO



CREATE UNIQUE NONCLUSTERED INDEX [IX_ScriptStep_1] ON [dbo].[ScriptStep]
(
	[ScriptMasterId] ASC,
	[StepCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




---------------------------------------------------------------End Index------------------------------------------------------------------
