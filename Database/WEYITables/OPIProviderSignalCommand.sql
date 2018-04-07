/****** Object:  Table [dbo].[OPIProviderSignalCommand]    Script Date: Jul 14 2016  4:12PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OPIProviderSignalCommand]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[OPIProviderSignalCommand]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'OPIProviderSignalCommand')
	)	
	
	
	declare @TblName as nvarchar(64) = 'OPIProviderSignalCommand'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[OPIProviderSignalCommand] ' + convert(varchar, getdate())
	
End
else
begin
--select * from CodeList
	CREATE TABLE [dbo].[OPIProviderSignalCommand](
		[Id] [int] IDENTITY(1,1) NOT NULL,
		[ProviderId] [int] NOT NULL,
		[SortOrder] [int] NOT NULL,
		[SignalCommand] nvarchar(128) NOT NULL, -- '0-9 , #,*,+' or use command elements to replace '#FromLanguage#' 
		[WaitingTime] [int] NOT NULL,  -- Seconds Unit
		[Version] [timestamp] NOT NULL,
		[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_OPIProviderSignalCommand_CreateDate]  DEFAULT (getutcdate()),
		[LastUpdate] [datetime] NOT NULL,
		[LastUpdateBy] [int] NOT NULL,
		[LastUpdateByType] [int] NOT NULL,
	 CONSTRAINT [PK_OPIProviderSignalCommand] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]


	-------------------------- Begin Foreign Key ---------------------------------------------------------------

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
		and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OPIProviderSignalCommand]') AND type in (N'U'))
		and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_OPIProviderSignalCommand_Provider]') AND type in (N'F'))
	begin
		ALTER TABLE [dbo].[OPIProviderSignalCommand]  WITH CHECK ADD  CONSTRAINT FK_OPIProviderSignalCommand_Provider FOREIGN KEY(ProviderId)
		REFERENCES [dbo].Provider ([Id])

		ALTER TABLE [dbo].[OPIProviderSignalCommand] CHECK CONSTRAINT FK_OPIProviderSignalCommand_Provider
	end

	-------------------------- End Foreign Key ---------------------------------------------------------------


	-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



	-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------

	
	select * from [OPIProviderSignalCommand]

end
GO

SET ANSI_PADDING OFF
GO
---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OPIProviderSignalCommand]') AND name = N'OPIProviderSignalCommand_1')
DROP INDEX [OPIProviderSignalCommand_1] ON [dbo].[OPIProviderSignalCommand]
GO

CREATE NONCLUSTERED INDEX [OPIProviderSignalCommand_1] ON [dbo].[OPIProviderSignalCommand]
(
	[ProviderId] ASC,
	[SortOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------

