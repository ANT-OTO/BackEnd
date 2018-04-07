
/****** Object:  Table [dbo].[DPTListQueryDetail]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTListQueryDetail]') AND type in (N'U'))
Begin
	/*
	
alter table [DPTListQueryDetailProperty] drop constraint [FK_DPTListQueryDetailProperty_DPTListQueryDetail]

	DROP TABLE [dbo].[DPTListQueryDetail]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'DPTListQueryDetail')
	)	
	
	
	declare @TblName as nvarchar(64) = 'DPTListQueryDetail'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[DPTListQueryDetail] ' + convert(varchar, getdate())
	
End
else
begin


CREATE TABLE [dbo].[DPTListQueryDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DPTListQueryId] int NOT NULL,

	[DPTId] [int] NULL,				-- DPT from Person. 
	
	[DPTStatusCodeId] int NULL,		-- select * from CodeList where Category = 'DPTStatus'

	[FromLanguageId] int NULL,
	[ToLanguageId] int NULL,
	[DPTTypeCodeId] int NULL,		-- select * from CodeList where Category = 'DPTType'

	[Info] nvarchar(max) NULL,

	[FinishTime] [datetime] NULL,

	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DPTListQueryDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[DPTListQueryDetail] ADD  CONSTRAINT [DF_DPTListQueryDetail_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTListQuery]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTListQueryDetail]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPTListQueryDetail_DPTListQuery]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPTListQueryDetail]  WITH CHECK ADD  CONSTRAINT [FK_DPTListQueryDetail_DPTListQuery] FOREIGN KEY([DPTListQueryId])
	REFERENCES [dbo].[DPTListQuery] ([Id])

	ALTER TABLE [dbo].[DPTListQueryDetail] CHECK CONSTRAINT [FK_DPTListQueryDetail_DPTListQuery]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPT]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTListQueryDetail]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPTListQueryDetail_DPTId]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPTListQueryDetail]  WITH CHECK ADD  CONSTRAINT [FK_DPTListQueryDetail_DPTId] FOREIGN KEY([DPTId])
	REFERENCES [dbo].[DPT] ([Id])

	ALTER TABLE [dbo].[DPTListQueryDetail] CHECK CONSTRAINT [FK_DPTListQueryDetail_DPTId]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lauguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTListQueryDetail]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPTListQueryDetail_Lauguage1]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPTListQueryDetail]  WITH CHECK ADD  CONSTRAINT [FK_DPTListQueryDetail_Lauguage1] FOREIGN KEY([FromLanguageId])
	REFERENCES [dbo].[Lauguage] ([Id])

	ALTER TABLE [dbo].[DPTListQueryDetail] CHECK CONSTRAINT [FK_DPTListQueryDetail_Lauguage1]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lauguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTListQueryDetail]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPTListQueryDetail_Lauguage2]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPTListQueryDetail]  WITH CHECK ADD  CONSTRAINT [FK_DPTListQueryDetail_Lauguage2] FOREIGN KEY([ToLanguageId])
	REFERENCES [dbo].[Lauguage] ([Id])

	ALTER TABLE [dbo].[DPTListQueryDetail] CHECK CONSTRAINT [FK_DPTListQueryDetail_Lauguage2]
end


-------------------------- End Foreign Key ---------------------------------------------------------------

-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTListQueryDetail]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTListQueryDetailProperty]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPTListQueryDetailProperty_DPTListQueryDetail]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPTListQueryDetailProperty]  WITH CHECK ADD  CONSTRAINT [FK_DPTListQueryDetailProperty_DPTListQueryDetail] FOREIGN KEY([DPTListQueryDetailId])
	REFERENCES [dbo].[DPTListQueryDetail] ([Id])

	ALTER TABLE [dbo].[DPTListQueryDetailProperty] CHECK CONSTRAINT [FK_DPTListQueryDetailProperty_DPTListQueryDetail]
end

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [DPTListQueryDetail]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_DPTListQueryDetail_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DPTListQueryDetail]') AND name = N'IX_DPTListQueryDetail_1')
DROP INDEX [IX_DPTListQueryDetail_1] ON [dbo].[DPTListQueryDetail]
GO




/****** Object:  Index [IX_DPTListQueryDetail_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_DPTListQueryDetail_1] ON [dbo].[DPTListQueryDetail]
(
	[DPTListQueryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
