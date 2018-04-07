
/****** Object:  Table [dbo].[ScriptListDetailY]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptListDetailY]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[ScriptListDetailY]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ScriptListDetailY')
	)	
	

	declare @TblName as nvarchar(64) = 'ScriptListDetailY'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[ScriptListDetailY] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ScriptListDetailY](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ScriptListDetailId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[ItemContent] [nvarchar](1024) NOT NULL,

	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_ScriptListDetailY] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[ScriptListDetailY] ADD  CONSTRAINT [DF_ScriptListDetailY_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[ScriptListDetailY] ADD  CONSTRAINT [DF_ScriptListDetailY_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptListDetail]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptListDetailY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScriptListDetailY_ScriptListDetail]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScriptListDetailY]  WITH CHECK ADD  CONSTRAINT [FK_ScriptListDetailY_ScriptListDetail] FOREIGN KEY([ScriptListDetailId])
	REFERENCES [dbo].[ScriptListDetail] ([Id])

	ALTER TABLE [dbo].[ScriptListDetailY] CHECK CONSTRAINT [FK_ScriptListDetailY_ScriptListDetail]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScriptListDetailY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ScriptListDetailY_Language]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ScriptListDetailY]  WITH CHECK ADD  CONSTRAINT [FK_ScriptListDetailY_Language] FOREIGN KEY([LanguageId])
	REFERENCES [dbo].[Language] ([Id])

	ALTER TABLE [dbo].[ScriptListDetailY] CHECK CONSTRAINT [FK_ScriptListDetailY_Language]
end
-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------




-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------







select * from [ScriptListDetailY]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScriptListDetailY]') AND name = N'IX_ScriptListDetailY_1')
DROP INDEX [IX_ScriptListDetailY_1] ON [dbo].[ScriptListDetailY]
GO



CREATE UNIQUE NONCLUSTERED INDEX [IX_ScriptListDetailY_1] ON [dbo].[ScriptListDetailY]
(
	[ScriptListDetailId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




---------------------------------------------------------------End Index------------------------------------------------------------------
