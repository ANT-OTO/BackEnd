
/****** Object:  Table [dbo].[InterviewPicture]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewPicture]') AND type in (N'U'))
Begin
	/*
	
	alter table [InterviewPictureThumb] drop constraint [FK_InterviewPictureThumb_InterviewPicture]
	
	DROP TABLE [dbo].[InterviewPicture]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'InterviewPicture')
	)	
	

	declare @TblName as nvarchar(64) = 'InterviewPicture'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[InterviewPicture] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[InterviewPicture](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InterviewId] [int] NOT NULL,
	[FromProvider] [bit] NOT NULL,	
	[OriginalFileName] [nvarchar](128) NOT NULL,
	[FileExtension] [nvarchar](16) NOT NULL,
	[DocumentKey] [nvarchar](64) NOT NULL,
	[Width] [int] NOT NULL,
	[Height] [int] NOT NULL,
	
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_InterviewPicture] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[InterviewPicture] ADD  CONSTRAINT [DF_InterviewPicture_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Interview]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewPicture]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_InterviewPicture_Interview]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[InterviewPicture]  WITH CHECK ADD  CONSTRAINT [FK_InterviewPicture_Interview] FOREIGN KEY([InterviewId])
	REFERENCES [dbo].[Interview] ([Id])

	ALTER TABLE [dbo].[InterviewPicture] CHECK CONSTRAINT [FK_InterviewPicture_Interview]
end



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewPicture]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewPictureThumb]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_InterviewPictureThumb_Interview]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[InterviewPictureThumb]  WITH CHECK ADD  CONSTRAINT [FK_InterviewPictureThumb_InterviewPicture] FOREIGN KEY([InterviewPictureId])
	REFERENCES [dbo].[InterviewPicture] ([Id])

	ALTER TABLE [dbo].[InterviewPictureThumb] CHECK CONSTRAINT [FK_InterviewPictureThumb_InterviewPicture]
end



select * from [InterviewPicture]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_InterviewPicture_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[InterviewPicture]') AND name = N'IX_InterviewPicture_1')
DROP INDEX [IX_InterviewPicture_1] ON [dbo].[InterviewPicture]
GO




/****** Object:  Index [IX_InterviewPicture_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_InterviewPicture_1] ON [dbo].[InterviewPicture]
(
	[InterviewId] ASC,
	[FromProvider] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



/****** Object:  Index [IX_InterviewPicture_2]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[InterviewPicture]') AND name = N'IX_InterviewPicture_2')
DROP INDEX [IX_InterviewPicture_2] ON [dbo].[InterviewPicture]
GO




/****** Object:  Index [IX_InterviewPicture_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_InterviewPicture_2] ON [dbo].[InterviewPicture]
(
	[DocumentKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---------------------------------------------------------------End Index------------------------------------------------------------------
