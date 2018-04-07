--select * from BillPayTerm
-- drop table [BillPayTerm]
-- alter table [BillPayTerm] add  [ProviderProductCodeId] int NOT NULL DEFAULT (1)
-- alter table [BillPayTerm] add  [BillActionTimeCodeId] [int] NOT NULL DEFAULT (1)


/****** Object:  Table [dbo].[BillPayTerm]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillPayTerm]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[BillPayTerm]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'BillPayTerm')
	)	
	
	
	declare @TblName as nvarchar(64) = 'BillPayTerm'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[BillPayTerm] ' + convert(varchar, getdate())
	
End
else
begin

	CREATE TABLE [dbo].[BillPayTerm](
		[Id] [int] IDENTITY(1,1) NOT NULL,
		[ProviderProductCodeId] int NOT NULL,
		[Name] [varchar](10) NOT NULL,
		[Description] [nvarchar](100) NOT NULL,
		[BillActionTimeCodeId] [int] NOT NULL, -- 1 Run time, 2 Statement
		[RelatedId] [int] NULL,
		[RelatedTable] [nvarchar](100) NULL,
		[CurrentlyOffered] [bit] NOT NULL,
		[StartTime] [datetime] NOT NULL,
		[EndTime] [datetime] NULL,
		[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_BillPayTerm_CreateDate]  DEFAULT (getutcdate()),
		[LastUpdated] [datetime] NOT NULL,
	 CONSTRAINT [PK_BillPayTerm] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
end
GO

SET ANSI_PADDING OFF
GO


