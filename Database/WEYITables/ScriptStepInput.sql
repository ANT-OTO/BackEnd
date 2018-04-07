
/****** Object:  Table [dbo].[ScriptStepInput]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStepInput]') AND type in (N'U'))
Begin
	/*
	
	alter table [ScriptStepInputY] drop constraint [FK_ScriptStepInputY_ScriptStepInput]
	DROP TABLE [dbo].[ScriptStepInput]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ScriptStepInput')
	)	
	
	

	declare @TblName as nvarchar(64) = 'ScriptStepInput'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[ScriptStepInput] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ScriptStepInput](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ScriptStepId] [int] NOT NULL,

	[ScriptInputTypeCodeId] int NOT NULL,		-- select * from WEYI.dbo.CodeList where Category = 'ScriptInputType'

	[InputLabel] nvarchar(1024) NOT NULL,
	[InputReportName] nvarchar(1024) NOT NULL,	-- Column name for the transaction report
	[ScriptListId] int NULL,					-- Associated ScriptList. It is used to display the dropdown list, or to validate a text input
	[ScriptListValidationFailedMsg] nvarchar(max) NULL,		-- If Required is true and the input is not entered, then display the failed message
	[Required] bit NOT NULL,
	[RequiredFailedMsg] nvarchar(max) NULL,		-- If Required is true and the input is not entered, then display the failed message
	[InputScriptVariableId] int NULL,			-- Initial value of the input (associated ScriptVariable)
	[AdditionalValidationRegularEx] nvarchar(max) NULL,			-- Regular Expression
	[AdditionalValidationFailedMsg] nvarchar(max) NULL,			-- if the additional validation rule (regular expression) fails, the message to be displayed

	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,

	[AllowCache] bit NULL,

 CONSTRAINT [PK_ScriptStepInput] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



ALTER TABLE [dbo].[ScriptStepInput] ADD  CONSTRAINT [DF_ScriptStepInput_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[ScriptStepInput] ADD  CONSTRAINT [DF_ScriptStepInput_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStep]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStepInput]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScriptStepInput_ScriptStep]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScriptStepInput]  WITH CHECK ADD  CONSTRAINT [FK_ScriptStepInput_ScriptStep] FOREIGN KEY([ScriptStepId])
	REFERENCES [dbo].[ScriptStep] ([Id])

	ALTER TABLE [dbo].[ScriptStepInput] CHECK CONSTRAINT [FK_ScriptStepInput_ScriptStep]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptVariable]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStepInput]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScriptStepInput_ScriptVariable1]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScriptStepInput]  WITH CHECK ADD  CONSTRAINT [FK_ScriptStepInput_ScriptVariable1] FOREIGN KEY([InputScriptVariableId])
	REFERENCES [dbo].[ScriptVariable] ([Id])

	ALTER TABLE [dbo].[ScriptStepInput] CHECK CONSTRAINT [FK_ScriptStepInput_ScriptVariable1]
end

-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStepInput]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStepInputY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScriptStepInputY_ScriptStepInput]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScriptStepInputY]  WITH CHECK ADD  CONSTRAINT [FK_ScriptStepInputY_ScriptStepInput] FOREIGN KEY([ScriptStepInputId])
	REFERENCES [dbo].[ScriptStepInput] ([Id])

	ALTER TABLE [dbo].[ScriptStepInputY] CHECK CONSTRAINT [FK_ScriptStepInputY_ScriptStepInput]
end


-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [ScriptStepInput]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStepInput]') AND name = N'IX_ScriptStepInput_1')
DROP INDEX [IX_ScriptStepInput_1] ON [dbo].[ScriptStepInput]
GO



CREATE UNIQUE NONCLUSTERED INDEX [IX_ScriptStepInput_1] ON [dbo].[ScriptStepInput]
(
	[ScriptStepId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




---------------------------------------------------------------End Index------------------------------------------------------------------
