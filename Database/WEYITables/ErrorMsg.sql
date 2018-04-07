
/****** Object:  Table [dbo].[ErrorMsg]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ErrorMsg]') AND type in (N'U'))
Begin
	/*
	alter table [ErrorMsgY] drop constraint [FK_ErrorMsgY_ErrorMsg]
	DROP TABLE [dbo].[ErrorMsg]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ErrorMsg')
	)
	
	

	declare @TblName as nvarchar(64) = 'ErrorMsg'
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
	print 'you need to manually exec DROP TABLE [dbo].[ErrorMsg] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ErrorMsg](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Msg] [nvarchar](384) NOT NULL,			

	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ErrorMsg] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



ALTER TABLE [dbo].[ErrorMsg] ADD  CONSTRAINT [DF_ErrorMsg_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

-------------------------- End Foreign Key ---------------------------------------------------------------


--------------------------------------------------- Begin Primary Key Referenced by other tables -------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ErrorMsg]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ErrorMsgY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ErrorMsgY_ErrorMsg]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ErrorMsgY]  WITH CHECK ADD  CONSTRAINT [FK_ErrorMsgY_ErrorMsg] FOREIGN KEY([ErrorMsgId])
	REFERENCES [dbo].[ErrorMsg] ([Id])

	ALTER TABLE [dbo].[ErrorMsgY] CHECK CONSTRAINT [FK_ErrorMsgY_ErrorMsg]
end

--------------------------------------------------- End Primary Key Referenced by other tables -------------------------------------------

select * from [ErrorMsg]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_ErrorMsg_1]    Script Date: 01/16/2015 11:52:42 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ErrorMsg]') AND name = N'IX_ErrorMsg_1')
DROP INDEX [IX_ErrorMsg_1] ON [dbo].[ErrorMsg] WITH ( ONLINE = OFF )
GO


/****** Object:  Index [IX_ErrorMsg_1]    Script Date: 01/16/2015 11:52:37 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ErrorMsg_1] ON [dbo].[ErrorMsg] 
(
	[Msg] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO




---------------------------------------------------------------End Index------------------------------------------------------------------

