
/****** Object:  Table [dbo].[PersonDownloadReportValidation]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonDownloadReportValidation]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[PersonDownloadReportValidation]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'PersonDownloadReportValidation')
	)	
	

	
	declare @TblName as nvarchar(64) = 'PersonDownloadReportValidation'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[PersonDownloadReportValidation] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[PersonDownloadReportValidation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] int NOT NULL,
	[DownloadReportId] int NOT NULL,
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_PersonDownloadReportValidation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[PersonDownloadReportValidation] ADD  CONSTRAINT [DF_PersonDownloadReportValidation_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[PersonDownloadReportValidation] ADD  CONSTRAINT [DF_PersonDownloadReportValidation_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonDownloadReportReportValidation]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonDownloadReportReportValidation_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonDownloadReportValidation]  WITH CHECK ADD  CONSTRAINT [FK_PersonDownloadReportReportValidation_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[PersonDownloadReportValidation] CHECK CONSTRAINT [FK_PersonDownloadReportReportValidation_Person]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DownloadReport]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonDownloadReportReportValidation]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonDownloadReportReportValidation_DownloadReport]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonDownloadReportValidation]  WITH CHECK ADD  CONSTRAINT [FK_PersonDownloadReportReportValidation_DownloadReport] FOREIGN KEY([DownloadReportId])
	REFERENCES [dbo].[DownloadReport] ([Id])

	ALTER TABLE [dbo].[PersonDownloadReportValidation] CHECK CONSTRAINT [FK_PersonDownloadReportReportValidation_DownloadReport]
end

-------------------------- End Foreign Key ---------------------------------------------------------------


-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [PersonDownloadReportValidation]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [PersonDownloadReportValidation_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PersonDownloadReportValidation]') AND name = N'PersonDownloadReportValidation_1')
DROP INDEX [PersonDownloadReportValidation_1] ON [dbo].[PersonDownloadReportValidation]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PersonDownloadReportValidation]') AND name = N'PersonDownloadReportValidation_2')
DROP INDEX [PersonDownloadReportValidation_2] ON [dbo].[PersonDownloadReportValidation]
GO


/****** Object:  Index [PersonDownloadReportValidation_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [PersonDownloadReportValidation_1] ON [dbo].[PersonDownloadReportValidation]
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
