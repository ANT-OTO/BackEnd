
/****** Object:  Table [dbo].[BillContractTypeTemplate]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillContractTypeTemplate]') AND type in (N'U'))
Begin
	/*
	alter table [BillContractTypeTemplateY] drop constraint [FK_BillContractTypeTemplateY_BillContractTypeTemplate]
	DROP TABLE [dbo].[BillContractTypeTemplate]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'BillContractTypeTemplate')
	)
	
	
	declare @TblName as nvarchar(64) = 'BillContractTypeTemplate'
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
	print 'you need to manually exec DROP TABLE [dbo].[BillContractTypeTemplate] ' + convert(varchar, getdate())
	
End
else
begin
CREATE TABLE [dbo].[BillContractTypeTemplate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BillContractTypeId] [int] NOT NULL,
	[ProviderId] [int] NULL,
	[TemplateName] varchar (256) NOT NULL,
	[TemplateHeader] nvarchar (255) NOT NULL,
	[Template] nvarchar (max) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
	
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_BillContractTypeTemplate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



ALTER TABLE [dbo].[BillContractTypeTemplate] ADD  CONSTRAINT [DF_BillContractTypeTemplate_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillContractTypeTemplate]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillContractType]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_BillContractTypeTemplate_BillContractType]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[BillContractTypeTemplate]  WITH CHECK ADD  CONSTRAINT [FK_BillContractTypeTemplate_BillContractType] FOREIGN KEY([BillContractTypeId])
	REFERENCES [dbo].[BillContractType] ([Id])

	ALTER TABLE [dbo].[BillContractTypeTemplate] CHECK CONSTRAINT [FK_BillContractTypeTemplate_BillContractType]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillContractTypeTemplate]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_BillContractTypeTemplate_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[BillContractTypeTemplate]  WITH CHECK ADD  CONSTRAINT [FK_BillContractTypeTemplate_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[BillContractTypeTemplate] CHECK CONSTRAINT [FK_BillContractTypeTemplate_Provider]
end

-------------------------- End Foreign Key ---------------------------------------------------------------

select * from [BillContractTypeTemplate]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())



/****** Object:  Index [IX_BillContractTypeTemplate_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BillContractTypeTemplate]') AND name = N'IX_BillContractTypeTemplate_1')
DROP INDEX [IX_BillContractTypeTemplate_1] ON [dbo].[BillContractTypeTemplate]
GO




/****** Object:  Index [IX_BillContractTypeTemplate_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_BillContractTypeTemplate_1] ON [dbo].[BillContractTypeTemplate]
(
	[BillContractTypeId] ASC,
	[ProviderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---------------------------------------------------------------End Index------------------------------------------------------------------


