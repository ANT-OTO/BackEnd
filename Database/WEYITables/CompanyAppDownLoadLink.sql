
/****** Object:  Table [dbo].[CompanyAppDownLoadLink]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CompanyAppDownLoadLink]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[CompanyAppDownLoadLink]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'CompanyAppDownLoadLink')
	)	
	


	declare @TblName as nvarchar(64) = 'CompanyAppDownLoadLink'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[CompanyAppDownLoadLink] ' + convert(varchar, getdate())
	
End
else
begin

--drop table [CompanyAppDownLoadLink]
CREATE TABLE [dbo].[CompanyAppDownLoadLink](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CompanyId] [int] NOT NULL,
	[ApplicationTypeCodeId] [int] NOT NULL,
	[DeviceTypeCodeId] [int] NOT NULL,
	[DownLoadLink] nvarchar(256) NOT NULL,
	[LatestVersion] nvarchar(64) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_CompanyAppDownLoadLink] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[CompanyAppDownLoadLink] ADD  CONSTRAINT [DF_CompanyAppDownLoadLink_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]

ALTER TABLE [dbo].[CompanyAppDownLoadLink] ADD  CONSTRAINT [DF_CompanyAppDownLoadLink_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]



select * from [CompanyAppDownLoadLink]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())

/****** Object:  Index [IX_CompanyAppDownLoadLink_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CompanyAppDownLoadLink]') AND name = N'IX_CompanyAppDownLoadLink_1')
DROP INDEX [IX_CompanyAppDownLoadLink_1] ON [dbo].[CompanyAppDownLoadLink]
GO




/****** Object:  Index [IX_CompanyAppDownLoadLink_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_CompanyAppDownLoadLink_1] ON [dbo].[CompanyAppDownLoadLink]
(
	[CompanyId] ASC,
	[ApplicationTypeCodeId] ASC,
	[DeviceTypeCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO





---------------------------------------------------------------End Index------------------------------------------------------------------
