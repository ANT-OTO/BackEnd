
/****** Object:  Table [dbo].[UIElement]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UIElement]') AND type in (N'U'))
Begin
	/*
	alter table [UIElementY] drop constraint [FK_UIElementY_UIElement]
	DROP TABLE [dbo].[UIElement]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'UIElement')
	)
	
	

	declare @TblName as nvarchar(64) = 'UIElement'
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
	print 'you need to manually exec DROP TABLE [dbo].[UIElement] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[UIElement](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppName] [nvarchar](64) NOT NULL,			-- Client, Provider, CompanySite 

	[DeviceType] [nvarchar](32) NOT NULL,		-- iPhone, Android, Web, EmptyString is applicable to all devices if no specific device is defined for the ElementKey

	[ElementKey] [nvarchar](128) NOT NULL,			

	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_UIElement] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



ALTER TABLE [dbo].[UIElement] ADD  CONSTRAINT [DF_UIElement_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

-------------------------- End Foreign Key ---------------------------------------------------------------


--------------------------------------------------- Begin Primary Key Referenced by other tables -------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UIElement]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UIElementY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_UIElementY_UIElement]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[UIElementY]  WITH CHECK ADD  CONSTRAINT [FK_UIElementY_UIElement] FOREIGN KEY([UIElementId])
	REFERENCES [dbo].[UIElement] ([Id])

	ALTER TABLE [dbo].[UIElementY] CHECK CONSTRAINT [FK_UIElementY_UIElement]
end

--------------------------------------------------- End Primary Key Referenced by other tables -------------------------------------------

select * from [UIElement]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_UIElement_1]    Script Date: 01/16/2015 11:52:42 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[UIElement]') AND name = N'IX_UIElement_1')
DROP INDEX [IX_UIElement_1] ON [dbo].[UIElement] WITH ( ONLINE = OFF )
GO


/****** Object:  Index [IX_UIElement_1]    Script Date: 01/16/2015 11:52:37 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_UIElement_1] ON [dbo].[UIElement] 
(
	[AppName] ASC,
	[DeviceType] ASC,
	[ElementKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO




---------------------------------------------------------------End Index------------------------------------------------------------------

