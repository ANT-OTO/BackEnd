
/****** Object:  Table [dbo].[Device]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Device]') AND type in (N'U'))
Begin
	/*

alter table [DeviceProperty] drop constraint [FK_DeviceProperty_Device]
alter table [PersonDevice] drop constraint [FK_PersonDevice_Device]
alter table [ProviderDevice] drop constraint [FK_ProviderDevice_Device]

	DROP TABLE [dbo].[Device]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'Device')
	)	
	

	declare @TblName as nvarchar(64) = 'Device'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[Device] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[Device](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DeviceTypeCodeId] [nvarchar](32) NOT NULL,		-- CodeList (Category; DeviceType): iPhone, Android, Windows Phone
	[SubType] [nvarchar](256) NOT NULL,				-- Additional Info about the device
	
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Device] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]




ALTER TABLE [dbo].[Device] ADD  CONSTRAINT [DF_Device_SubType]  DEFAULT ('') FOR [SubType]
ALTER TABLE [dbo].[Device] ADD  CONSTRAINT [DF_Device_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

-------------------------- End Foreign Key ---------------------------------------------------------------

--------------------------------------------------- Begin Primary Key Referenced by other tables -------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Device]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeviceProperty]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DeviceProperty_Device]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DeviceProperty]  WITH CHECK ADD  CONSTRAINT [FK_DeviceProperty_Device] FOREIGN KEY([DeviceId])
	REFERENCES [dbo].[Device] ([Id])

	ALTER TABLE [dbo].[DeviceProperty] CHECK CONSTRAINT [FK_DeviceProperty_Device]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Device]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonDevice]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonDevice_Device]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonDevice]  WITH CHECK ADD  CONSTRAINT [FK_PersonDevice_Device] FOREIGN KEY([DeviceId])
	REFERENCES [dbo].[Device] ([Id])

	ALTER TABLE [dbo].[PersonDevice] CHECK CONSTRAINT [FK_PersonDevice_Device]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Device]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderDevice]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderDevice_Device]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderDevice]  WITH CHECK ADD  CONSTRAINT [FK_ProviderDevice_Device] FOREIGN KEY([DeviceId])
	REFERENCES [dbo].[Device] ([Id])

	ALTER TABLE [dbo].[ProviderDevice] CHECK CONSTRAINT [FK_ProviderDevice_Device]
end


--------------------------------------------------- End Primary Key Referenced by other tables -------------------------------------------



select * from Device
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------


---------------------------------------------------------------End Index------------------------------------------------------------------

