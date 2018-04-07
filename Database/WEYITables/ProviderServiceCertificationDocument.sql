
/****** Object:  Table [dbo].[ProviderServiceCertificationDocument]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderServiceCertificationDocument]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[ProviderServiceCertificationDocument]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ProviderServiceCertificationDocument')
	)	
	

	declare @TblName as nvarchar(64) = 'ProviderServiceCertificationDocument'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[ProviderServiceCertificationDocument] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ProviderServiceCertificationDocument](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProviderServiceCertificationId] [int] NOT NULL,
	[OriginalFileName] [nvarchar](128) NOT NULL,
	[FileExtension] [nvarchar](16) NOT NULL,
	[DocumentKey] [nvarchar](64) NOT NULL,
	[Note] [nvarchar](max) NOT NULL,
	
	[Deleted] [bit] NOT NULL,

	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[LastUpdateBy] [int] NOT NULL,
	[LastUpdateByType] [int] NOT NULL,
 CONSTRAINT [PK_ProviderServiceCertificationDocument] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[ProviderServiceCertificationDocument] ADD  CONSTRAINT [DF_ProviderServiceCertificationDocument_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[ProviderServiceCertificationDocument] ADD  CONSTRAINT [DF_ProviderServiceCertificationDocument_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderServiceCertification]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderServiceCertificationDocument]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderServiceCertificationDocument_ProviderServiceCertification]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderServiceCertificationDocument]  WITH CHECK ADD  CONSTRAINT [FK_ProviderServiceCertificationDocument_ProviderServiceCertification] FOREIGN KEY([ProviderServiceCertificationId])
	REFERENCES [dbo].[ProviderServiceCertification] ([Id])

	ALTER TABLE [dbo].[ProviderServiceCertificationDocument] CHECK CONSTRAINT [FK_ProviderServiceCertificationDocument_ProviderServiceCertification]
end

-------------------------- End Foreign Key ---------------------------------------------------------------


--------------------------------------------------- Begin Primary Key Referenced by other tables -------------------------------------------

--------------------------------------------------- End Primary Key Referenced by other tables -------------------------------------------


select * from [ProviderServiceCertificationDocument]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProviderServiceCertificationDocument]') AND name = N'IX_ProviderServiceCertificationDocument_1')
DROP INDEX [IX_ProviderServiceCertificationDocument_1] ON [dbo].[ProviderServiceCertificationDocument]
GO




CREATE NONCLUSTERED INDEX [IX_ProviderServiceCertificationDocument_1] ON [dbo].[ProviderServiceCertificationDocument]
(
	[ProviderServiceCertificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProviderServiceCertificationDocument]') AND name = N'IX_ProviderServiceCertificationDocument_2')
DROP INDEX [IX_ProviderServiceCertificationDocument_2] ON [dbo].[ProviderServiceCertificationDocument]
GO



CREATE UNIQUE NONCLUSTERED INDEX [IX_ProviderServiceCertificationDocument_2] ON [dbo].[ProviderServiceCertificationDocument]
(
	[DocumentKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---------------------------------------------------------------End Index------------------------------------------------------------------
