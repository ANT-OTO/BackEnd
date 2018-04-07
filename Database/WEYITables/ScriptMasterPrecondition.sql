
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptMasterPrecondition]') AND type in (N'U'))
Begin
	/*

alter table [ScriptMasterPreconditionY] drop constraint [FK_ScriptMasterPreconditionY_ScriptMasterPrecondition]
	
	DROP TABLE [dbo].[ScriptMasterPrecondition]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ScriptMasterPrecondition')
	)	
	
	

	declare @TblName as nvarchar(64) = 'ScriptMasterPrecondition'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[ScriptMasterPrecondition] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ScriptMasterPrecondition](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ScriptMasterId] [int] NOT NULL,
	[ActionCondition] nvarchar(max) NOT NULL,
	[GotoScriptStepCode] nvarchar(32) NULL,
	[SortOrder] nvarchar(32) NOT NULL,
	[Available] bit NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_ScriptMasterPrecondition] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



ALTER TABLE [dbo].[ScriptMasterPrecondition] ADD  CONSTRAINT [DF_ScriptMasterPrecondition_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[ScriptMasterPrecondition] ADD  CONSTRAINT [DF_ScriptMasterPrecondition_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptMaster]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptMasterPrecondition]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScriptMasterPrecondition_ScriptMaster]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScriptMasterPrecondition]  WITH CHECK ADD  CONSTRAINT [FK_ScriptMasterPrecondition_ScriptMaster] FOREIGN KEY([ScriptMasterId])
	REFERENCES [dbo].[ScriptMaster] ([Id])

	ALTER TABLE [dbo].[ScriptMasterPrecondition] CHECK CONSTRAINT [FK_ScriptMasterPrecondition_ScriptMaster]
end

-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------




-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [ScriptMasterPrecondition]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScriptMasterPrecondition]') AND name = N'IX_ScriptMasterPrecondition_1')
DROP INDEX [IX_ScriptMasterPrecondition_1] ON [dbo].[ScriptMasterPrecondition]
GO



CREATE NONCLUSTERED INDEX [IX_ScriptMasterPrecondition_1] ON [dbo].[ScriptMasterPrecondition]
(
	[ScriptMasterId] ASC,
	[SortOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




---------------------------------------------------------------End Index------------------------------------------------------------------
