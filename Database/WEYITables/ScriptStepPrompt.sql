
/****** Object:  Table [dbo].[ScriptStepPrompt]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStepPrompt]') AND type in (N'U'))
Begin
	/*
	
alter table [ScriptStepPromptY] drop constraint [FK_ScriptStepPromptY_ScriptStepPrompt]

	DROP TABLE [dbo].[ScriptStepPrompt]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ScriptStepPrompt')
	)	
	
	

	declare @TblName as nvarchar(64) = 'ScriptStepPrompt'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[ScriptStepPrompt] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ScriptStepPrompt](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ScriptStepId] [int] NOT NULL,

	[PromptCondition] nvarchar(max) NOT NULL,	-- SQL like conditions, such as $TargetLanguage$ <> 'Operator'
	[Prompt] nvarchar(max) NOT NULL,			-- Prompt for the agent to read to the caller
	[Instruction] nvarchar(max) NOT NULL,		-- Instructions to the agent or interpreter
	[SortOrder] nvarchar(32) NOT NULL,

	[Available] [bit] NOT NULL,

	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_ScriptStepPrompt] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



ALTER TABLE [dbo].[ScriptStepPrompt] ADD  CONSTRAINT [DF_ScriptStepPrompt_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[ScriptStepPrompt] ADD  CONSTRAINT [DF_ScriptStepPrompt_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStep]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStepPrompt]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScriptStepPrompt_ScriptStep]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScriptStepPrompt]  WITH CHECK ADD  CONSTRAINT [FK_ScriptStepPrompt_ScriptStep] FOREIGN KEY([ScriptStepId])
	REFERENCES [dbo].[ScriptStep] ([Id])

	ALTER TABLE [dbo].[ScriptStepPrompt] CHECK CONSTRAINT [FK_ScriptStepPrompt_ScriptStep]
end

-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStepPrompt]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStepPromptY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScriptStepPromptY_ScriptStepPrompt]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScriptStepPromptY]  WITH CHECK ADD  CONSTRAINT [FK_ScriptStepPromptY_ScriptStepPrompt] FOREIGN KEY([ScriptStepPromptId])
	REFERENCES [dbo].[ScriptStepPrompt] ([Id])

	ALTER TABLE [dbo].[ScriptStepPromptY] CHECK CONSTRAINT [FK_ScriptStepPromptY_ScriptStepPrompt]
end


-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [ScriptStepPrompt]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStepPrompt]') AND name = N'IX_ScriptStepPrompt_1')
DROP INDEX [IX_ScriptStepPrompt_1] ON [dbo].[ScriptStepPrompt]
GO



CREATE NONCLUSTERED INDEX [IX_ScriptStepPrompt_1] ON [dbo].[ScriptStepPrompt]
(
	[ScriptStepId] ASC,
	[SortOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




---------------------------------------------------------------End Index------------------------------------------------------------------
