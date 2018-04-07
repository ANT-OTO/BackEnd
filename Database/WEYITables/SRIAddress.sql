
/****** Object:  Table [dbo].[SRIAddress]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SRIAddress]') AND type in (N'U'))
Begin
	/*
	DROP TABLE [dbo].[SRIAddress]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'SRIAddress')
	)	
	
	
	declare @TblName as nvarchar(64) = 'SRIAddress'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[SRIAddress] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[SRIAddress](
	[Id] [int] IDENTITY(1,1) NOT NULL,

	[SRIAddress1] [nvarchar](256) NOT NULL,
	[SRIAddress2] [nvarchar](256) NULL,
	[City] [nvarchar](128) NOT NULL,
	[District] [nvarchar](128) NULL,
	[State] [nvarchar](128) NOT NULL,
	[Zip] [nvarchar](32) NOT NULL,
	[Country] [nvarchar](32) NOT NULL,

	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,

 CONSTRAINT [PK_SRIAddress] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]




ALTER TABLE [dbo].[SRIAddress] ADD  CONSTRAINT [DF_SRIAddress_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[SRIAddress] ADD  CONSTRAINT [DF_SRIAddress_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------


-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [SRIAddress]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------




---------------------------------------------------------------End Index------------------------------------------------------------------
