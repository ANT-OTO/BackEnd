
/****** Object:  Table [dbo].[ProviderLanguageCertPicture]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderLanguageCertPicture]') AND type in (N'U'))
Begin
	/*
	
alter table [ProviderLanguageCertPictureThumb] drop constraint [FK_ProviderLanguageCertPictureThumb_ProviderLanguageCertPicture]

	DROP TABLE [dbo].[ProviderLanguageCertPicture]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ProviderLanguageCertPicture')
	)	
	

	declare @TblName as nvarchar(64) = 'ProviderLanguageCertPicture'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[ProviderLanguageCertPicture] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ProviderLanguageCertPicture](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProviderLanguageCertId] [int] NOT NULL,
	[OriginalFileName] [nvarchar](128) NOT NULL,
	[FileExtension] [nvarchar](16) NOT NULL,
	[DocumentKey] [nvarchar](64) NOT NULL,
	[Width] [int] NOT NULL,
	[Height] [int] NOT NULL,
	
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProviderLanguageCertPicture] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[ProviderLanguageCertPicture] ADD  CONSTRAINT [DF_ProviderLanguageCertPicture_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderLanguageCert]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderLanguageCertPicture]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderLanguageCertPicture_ProviderLanguageCert]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderLanguageCertPicture]  WITH CHECK ADD  CONSTRAINT [FK_ProviderLanguageCertPicture_ProviderLanguageCert] FOREIGN KEY([ProviderLanguageCertId])
	REFERENCES [dbo].[ProviderLanguageCert] ([Id])

	ALTER TABLE [dbo].[ProviderLanguageCertPicture] CHECK CONSTRAINT [FK_ProviderLanguageCertPicture_ProviderLanguageCert]
end

-------------------------- End Foreign Key ---------------------------------------------------------------


--------------------------------------------------- Begin Primary Key Referenced by other tables -------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderLanguageCertPicture]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderLanguageCertPictureThumb]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderLanguageCertPictureThumb_ProviderLanguageCertPicture]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderLanguageCertPictureThumb]  WITH CHECK ADD  CONSTRAINT [FK_ProviderLanguageCertPictureThumb_ProviderLanguageCertPicture] FOREIGN KEY([ProviderLanguageCertPictureId])
	REFERENCES [dbo].[ProviderLanguageCertPicture] ([Id])

	ALTER TABLE [dbo].[ProviderLanguageCertPictureThumb] CHECK CONSTRAINT [FK_ProviderLanguageCertPictureThumb_ProviderLanguageCertPicture]
end

--------------------------------------------------- End Primary Key Referenced by other tables -------------------------------------------


select * from [ProviderLanguageCertPicture]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_ProviderLanguageCertPicture_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProviderLanguageCertPicture]') AND name = N'IX_ProviderLanguageCertPicture_1')
DROP INDEX [IX_ProviderLanguageCertPicture_1] ON [dbo].[ProviderLanguageCertPicture]
GO




/****** Object:  Index [IX_ProviderLanguageCertPicture_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ProviderLanguageCertPicture_1] ON [dbo].[ProviderLanguageCertPicture]
(
	[ProviderLanguageCertId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



/****** Object:  Index [IX_ProviderLanguageCertPicture_2]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProviderLanguageCertPicture]') AND name = N'IX_ProviderLanguageCertPicture_2')
DROP INDEX [IX_ProviderLanguageCertPicture_2] ON [dbo].[ProviderLanguageCertPicture]
GO




/****** Object:  Index [IX_ProviderLanguageCertPicture_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ProviderLanguageCertPicture_2] ON [dbo].[ProviderLanguageCertPicture]
(
	[DocumentKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---------------------------------------------------------------End Index------------------------------------------------------------------
