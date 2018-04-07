
/****** Object:  Table [dbo].[Region]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Region]') AND type in (N'U'))
Begin
	/*


alter table [MobileValidation] drop constraint [FK_MobileValidation_Region]
alter table [NotificationText] drop constraint [FK_NotificationText_Region]
alter table [Person] drop constraint [FK_Person_Region]
alter table [Provider] drop constraint [FK_Provider_Region]
alter table [RegionY] drop constraint [FK_RegionY_Region]

	DROP TABLE [dbo].[Region]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'Region')
	)	
	
	declare @TblName as nvarchar(64) = 'Region'
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
	print 'you need to manually exec DROP TABLE [dbo].[Region] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[Region](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RegionCode] [varchar](8) NOT NULL,		-- like Country Code, such as 1 for USA, 86 for China, 852 for Hong Kong, 886 for Taiwan, 44 for United Kindom, 
	[Name] [nvarchar](256) NOT NULL,
	[Abbreviation] [varchar](8) NOT NULL,	-- two letter abbreviation
	[Available] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Region] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



ALTER TABLE [dbo].[Region] ADD  CONSTRAINT [DF_Region_Available]  DEFAULT (1) FOR [Available]

ALTER TABLE [dbo].[Region] ADD  CONSTRAINT [DF_Region_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------



-------------------------- End Foreign Key ---------------------------------------------------------------


-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Region]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MobileValidation]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_MobileValidation_Region]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[MobileValidation]  WITH CHECK ADD  CONSTRAINT [FK_MobileValidation_Region] FOREIGN KEY([RegionId])
	REFERENCES [dbo].[Region] ([Id])

	ALTER TABLE [dbo].[MobileValidation] CHECK CONSTRAINT [FK_MobileValidation_Region]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Region]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NotificationText]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotificationText_Region]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[NotificationText]  WITH CHECK ADD  CONSTRAINT [FK_NotificationText_Region] FOREIGN KEY([RegionId])
	REFERENCES [dbo].[Region] ([Id])

	ALTER TABLE [dbo].[NotificationText] CHECK CONSTRAINT [FK_NotificationText_Region]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Region]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_Person_Region]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_Region] FOREIGN KEY([RegionId])
	REFERENCES [dbo].[Region] ([Id])

	ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Region]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Region]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_Provider_Region]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[Provider]  WITH CHECK ADD  CONSTRAINT [FK_Provider_Region] FOREIGN KEY([RegionId])
	REFERENCES [dbo].[Region] ([Id])

	ALTER TABLE [dbo].[Provider] CHECK CONSTRAINT [FK_Provider_Region]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Region]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RegionY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RegionY_Region]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RegionY]  WITH CHECK ADD  CONSTRAINT [FK_RegionY_Region] FOREIGN KEY([RegionId])
	REFERENCES [dbo].[Region] ([Id])

	ALTER TABLE [dbo].[RegionY] CHECK CONSTRAINT [FK_RegionY_Region]
end


-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------

select * from [Region]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_Region_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Region]') AND name = N'IX_Region_1')
DROP INDEX [IX_Region_1] ON [dbo].[Region]
GO




/****** Object:  Index [IX_Region_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_Region_1] ON [dbo].[Region]
(
	[RegionCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
