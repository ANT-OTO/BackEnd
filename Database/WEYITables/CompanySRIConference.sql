/****** Object:  Table [dbo].[CompanySRIConference]    Script Date: Jul 14 2016  4:12PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CompanySRIConference]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[CompanySRIConference]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'CompanySRIConference')
	)	
	
	
	declare @TblName as nvarchar(64) = 'CompanySRIConference'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[CompanySRIConference] ' + convert(varchar, getdate())
	
End
else
begin

	CREATE TABLE [dbo].[CompanySRIConference](
		[Id] int IDENTITY(1,1) NOT NULL,
		[CompanyId] int NULL,
		[SRIConferenceName] nvarchar(256) NOT NULL,
		[SRIAddressId] int NOT NULL,
		[SRIConferenceStatusCodeId] int NOT NULL, --select * from CodeList where Category = 'SRIConferenceStatus'
		[StartUTCDate] [datetime] NOT NULL,
		[RehearsalUTCDate] [datetime] NOT NULL,
		[EstimatedFinishUTCDate] [datetime] NOT NULL,
		[SRIConferenceUId] nvarchar(10) NOT NULL,
		[RelatedSubjectCodeId] int NULL,
		[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_CompanySRIConference_CreateDate]  DEFAULT (getutcdate()),
		[CreateByAgentId] int NOT NULL
	 CONSTRAINT [PK_CompanySRIConference] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	-------------------------- Begin Foreign Key ---------------------------------------------------------------
	

	-------------------------- End Foreign Key ---------------------------------------------------------------

select * from [CompanySRIConference]
end
GO

SET ANSI_PADDING OFF
GO

print '
Create Index ' + convert(varchar, getdate())


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CompanySRIConference]') AND name = N'CompanySRIConference_1')
DROP INDEX [CompanySRIConference_1] ON [dbo].[CompanySRIConference]
GO

CREATE NONCLUSTERED INDEX [CompanySRIConference_1] ON [dbo].[CompanySRIConference]
(
	[SRIConferenceUId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CompanySRIConference]') AND name = N'CompanySRIConference_2')
DROP INDEX [CompanySRIConference_2] ON [dbo].[CompanySRIConference]
GO

CREATE NONCLUSTERED INDEX [CompanySRIConference_2] ON [dbo].[CompanySRIConference]
(
	[CreateByAgentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CompanySRIConference]') AND name = N'CompanySRIConference_3')
DROP INDEX [CompanySRIConference_3] ON [dbo].[CompanySRIConference]
GO

CREATE NONCLUSTERED INDEX [CompanySRIConference_3] ON [dbo].[CompanySRIConference]
(
	[RelatedSubjectCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO