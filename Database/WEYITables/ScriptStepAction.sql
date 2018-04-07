
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStepAction]') AND type in (N'U'))
Begin
	/*

alter table [ScriptStepActionY] drop constraint [FK_ScriptStepActionY_ScriptStepAction]
	
	DROP TABLE [dbo].[ScriptStepAction]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ScriptStepAction')
	)	
	
	

	declare @TblName as nvarchar(64) = 'ScriptStepAction'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[ScriptStepAction] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ScriptStepAction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ScriptStepId] [int] NOT NULL,

	[ActionCondition] nvarchar(max) NOT NULL,
	[ActionLabel] nvarchar(128) NOT NULL,
	[ScriptActionTypeCodeId] int NOT NULL,		-- select * from WEYI.dbo.CodeList where Category = 'ScriptActionType'
	[GotoScriptStepCode] nvarchar(32) NULL,
	[SortOrder] nvarchar(32) NOT NULL,

	[Available] bit NOT NULL,

	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_ScriptStepAction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



ALTER TABLE [dbo].[ScriptStepAction] ADD  CONSTRAINT [DF_ScriptStepAction_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[ScriptStepAction] ADD  CONSTRAINT [DF_ScriptStepAction_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStep]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStepAction]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScriptStepAction_ScriptStep]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScriptStepAction]  WITH CHECK ADD  CONSTRAINT [FK_ScriptStepAction_ScriptStep] FOREIGN KEY([ScriptStepId])
	REFERENCES [dbo].[ScriptStep] ([Id])

	ALTER TABLE [dbo].[ScriptStepAction] CHECK CONSTRAINT [FK_ScriptStepAction_ScriptStep]
end

-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStepAction]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStepActionY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScriptStepActionY_ScriptStepAction]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScriptStepActionY]  WITH CHECK ADD  CONSTRAINT [FK_ScriptStepActionY_ScriptStepAction] FOREIGN KEY([ScriptStepActionId])
	REFERENCES [dbo].[ScriptStepAction] ([Id])

	ALTER TABLE [dbo].[ScriptStepActionY] CHECK CONSTRAINT [FK_ScriptStepActionY_ScriptStepAction]
end


-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [ScriptStepAction]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScriptStepAction]') AND name = N'IX_ScriptStepAction_1')
DROP INDEX [IX_ScriptStepAction_1] ON [dbo].[ScriptStepAction]
GO



CREATE NONCLUSTERED INDEX [IX_ScriptStepAction_1] ON [dbo].[ScriptStepAction]
(
	[ScriptStepId] ASC,
	[SortOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




---------------------------------------------------------------End Index------------------------------------------------------------------
