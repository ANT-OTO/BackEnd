
/****** Object:  Table [dbo].[RequestPicture]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestPicture]') AND type in (N'U'))
Begin
	/*
	alter table [RequestPictureThumb] drop constraint [FK_RequestPictureThumb_RequestPicture]
	
	DROP TABLE [dbo].[RequestPicture]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'RequestPicture')
	)	
	
	declare @TblName as nvarchar(64) = 'RequestPicture'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[RequestPicture] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[RequestPicture](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RequestId] [int] NOT NULL,
	[FromProvider] [bit] NOT NULL,
	[OriginalFileName] [nvarchar](128) NOT NULL,
	[FileExtension] [nvarchar](16) NOT NULL,
	[DocumentKey] [nvarchar](64) NOT NULL,
	[Width] [int] NOT NULL,
	[Height] [int] NOT NULL,
	
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_RequestPicture] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[RequestPicture] ADD  CONSTRAINT [DF_RequestPicture_FromProvider]  DEFAULT (1) FOR [FromProvider]
ALTER TABLE [dbo].[RequestPicture] ADD  CONSTRAINT [DF_RequestPicture_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Request]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestPicture]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestPicture_Request]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestPicture]  WITH CHECK ADD  CONSTRAINT [FK_RequestPicture_Request] FOREIGN KEY([RequestId])
	REFERENCES [dbo].[Request] ([Id])

	ALTER TABLE [dbo].[RequestPicture] CHECK CONSTRAINT [FK_RequestPicture_Request]
end



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestPicture]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestPictureThumb]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestPictureThumb_Request]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestPictureThumb]  WITH CHECK ADD  CONSTRAINT [FK_RequestPictureThumb_RequestPicture] FOREIGN KEY([RequestPictureId])
	REFERENCES [dbo].[RequestPicture] ([Id])

	ALTER TABLE [dbo].[RequestPictureThumb] CHECK CONSTRAINT [FK_RequestPictureThumb_RequestPicture]
end


select * from [RequestPicture]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_RequestPicture_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RequestPicture]') AND name = N'IX_RequestPicture_1')
DROP INDEX [IX_RequestPicture_1] ON [dbo].[RequestPicture]
GO




/****** Object:  Index [IX_RequestPicture_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_RequestPicture_1] ON [dbo].[RequestPicture]
(
	[RequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



/****** Object:  Index [IX_RequestPicture_2]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RequestPicture]') AND name = N'IX_RequestPicture_2')
DROP INDEX [IX_RequestPicture_2] ON [dbo].[RequestPicture]
GO




/****** Object:  Index [IX_RequestPicture_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_RequestPicture_2] ON [dbo].[RequestPicture]
(
	[DocumentKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
