
/****** Object:  Table [dbo].[PersonPictureThumb]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonPictureThumb]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[PersonPictureThumb]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'PersonPictureThumb')
	)	
	

	declare @TblName as nvarchar(64) = 'PersonPictureThumb'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[PersonPictureThumb] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[PersonPictureThumb](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonPictureId] [int] NOT NULL,
	[FileExtension] [nvarchar](16) NOT NULL,
	[DocumentKey] [nvarchar](64) NOT NULL,
	[Width] [int] NOT NULL,
	[Height] [int] NOT NULL,
	
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_PersonPictureThumb] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


--ALTER TABLE [dbo].[PersonPictureThumb] ADD  CONSTRAINT [DF_PersonPictureThumb_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonPicture]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonPictureThumb]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonPictureThumb_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonPictureThumb]  WITH CHECK ADD  CONSTRAINT [FK_PersonPictureThumb_PersonPicture] FOREIGN KEY([PersonPictureId])
	REFERENCES [dbo].[PersonPicture] ([Id])

	ALTER TABLE [dbo].[PersonPictureThumb] CHECK CONSTRAINT [FK_PersonPictureThumb_PersonPicture]
end



select * from [PersonPictureThumb]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_PersonPictureThumb_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PersonPictureThumb]') AND name = N'IX_PersonPictureThumb_1')
DROP INDEX [IX_PersonPictureThumb_1] ON [dbo].[PersonPictureThumb]
GO




/****** Object:  Index [IX_PersonPictureThumb_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_PersonPictureThumb_1] ON [dbo].[PersonPictureThumb]
(
	[PersonPictureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
