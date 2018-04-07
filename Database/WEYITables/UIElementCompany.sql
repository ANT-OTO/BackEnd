
/****** Object:  Table [dbo].[UIElementCompany]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UIElementCompany]') AND type in (N'U'))
Begin
	/*
	alter table [UIElementCompanyY] drop constraint [FK_UIElementCompanyY_UIElementCompany]
	DROP TABLE [dbo].[UIElementCompany]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'UIElementCompany')
	)
	
	

	declare @TblName as nvarchar(64) = 'UIElementCompany'
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
	print 'you need to manually exec DROP TABLE [dbo].[UIElementCompany] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[UIElementCompany](
	[Id] [int] IDENTITY(1,1) NOT NULL,

	[CompanyId] int NOT NULL,

	[ApplicationTypeCodeId] [int] NOT NULL,		-- 1	Client, 2	Provider, 3	ManagementTool, 99	Other
												-- select * from CodeList where Category = 'ApplicationType'

	[DeviceTypeCodeId] [int] NOT NULL,			-- 1	iPhone, 2	Android, 5	Web
												-- select * from CodeList where Category = 'DeviceType' where CodeId in (1, 2, 5)

	[ElementKey] [nvarchar](128) NOT NULL,			

	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_UIElementCompany] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



ALTER TABLE [dbo].[UIElementCompany] ADD  CONSTRAINT [DF_UIElementCompany_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

-------------------------- End Foreign Key ---------------------------------------------------------------


--------------------------------------------------- Begin Primary Key Referenced by other tables -------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UIElementCompany]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UIElementCompanyY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_UIElementCompanyY_UIElementCompany]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[UIElementCompanyY]  WITH CHECK ADD  CONSTRAINT [FK_UIElementCompanyY_UIElementCompany] FOREIGN KEY([UIElementCompanyId])
	REFERENCES [dbo].[UIElementCompany] ([Id])

	ALTER TABLE [dbo].[UIElementCompanyY] CHECK CONSTRAINT [FK_UIElementCompanyY_UIElementCompany]
end

--------------------------------------------------- End Primary Key Referenced by other tables -------------------------------------------

select * from [UIElementCompany]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[UIElementCompany]') AND name = N'IX_UIElementCompany_1')
DROP INDEX [IX_UIElementCompany_1] ON [dbo].[UIElementCompany] WITH ( ONLINE = OFF )
GO


CREATE UNIQUE NONCLUSTERED INDEX [IX_UIElementCompany_1] ON [dbo].[UIElementCompany] 
(
	[CompanyId] ASC,
	[ApplicationTypeCodeId] ASC,
	[DeviceTypeCodeId] ASC,
	[ElementKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO




---------------------------------------------------------------End Index------------------------------------------------------------------

