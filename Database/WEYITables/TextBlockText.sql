
/****** Object:  Table [dbo].[TextBlockText]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlockText]') AND type in (N'U'))
Begin
	/*
	
alter table [TextBlockRecvd] drop constraint [FK_TextBlockRecvd_TextBlockText]

	DROP TABLE [dbo].[TextBlockText]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'TextBlockText')
	)	
	
	

	declare @TblName as nvarchar(64) = 'TextBlockText'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[TextBlockText] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[TextBlockText](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TextBlockId] [int] NOT NULL,	
	[DeviceTextSendId] [int] NOT NULL,	

	[FromCaller] [bit] NOT NULL,			-- 1 from caller, 0 from listener

	[Msg] nvarchar(max) NOT NULL,

	[Mode] varchar(2) NULL,				-- DT, or GC. DT stands for Directly Translate. GC stands for General Chat.

	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TextBlockText] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlock]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlockText]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextBlockText_TextBlock]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextBlockText]  WITH CHECK ADD  CONSTRAINT [FK_TextBlockText_TextBlock] FOREIGN KEY([TextBlockId])
	REFERENCES [dbo].[TextBlock] ([Id])

	ALTER TABLE [dbo].[TextBlockText] CHECK CONSTRAINT [FK_TextBlockText_TextBlock]
end



-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlockText]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlockRecvd]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextBlockRecvd_TextBlockText]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextBlockRecvd]  WITH CHECK ADD  CONSTRAINT [FK_TextBlockRecvd_TextBlockText] FOREIGN KEY([TextBlockTextId])
	REFERENCES [dbo].[TextBlockText] ([Id])

	ALTER TABLE [dbo].[TextBlockRecvd] CHECK CONSTRAINT [FK_TextBlockRecvd_TextBlockText]
end

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [TextBlockText]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_TextBlockText_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TextBlockText]') AND name = N'IX_TextBlockText_1')
DROP INDEX [IX_TextBlockText_1] ON [dbo].[TextBlockText]
GO




/****** Object:  Index [IX_TextBlockText_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_TextBlockText_1] ON [dbo].[TextBlockText]
(
	[TextBlockId] ASC,
	[DeviceTextSendId] ASC,
	[FromCaller] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


--------------------------------------------------------------------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TextBlockText]') AND name = N'IX_TextBlockText_2')
DROP INDEX [IX_TextBlockText_2] ON [dbo].[TextBlockText]
GO



CREATE NONCLUSTERED INDEX [IX_TextBlockText_2] ON [dbo].[TextBlockText]
(
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




---------------------------------------------------------------End Index------------------------------------------------------------------
