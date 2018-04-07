
/****** Object:  Table [dbo].[ProviderSchedule]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderSchedule]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[ProviderSchedule]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ProviderSchedule')
	)	
	

	declare @TblName as nvarchar(64) = 'ProviderSchedule'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[ProviderSchedule] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ProviderSchedule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProviderId] [int] NOT NULL,			
	[EffBegin] [datetime] NOT NULL,
	[EffEnd] [datetime] NOT NULL,
	[AvailableCodeId] [int] NOT NULL,		-- CodeList (Category: ProviderScheduleAvailable): Not Available, Available, Available as Alternative
	[DaysTypeCodeId] [int] NOT NULL,		-- CodeList (Category: ProviderScheduleDaysType): All Days, Business Days, Non-Business Days
	[HoursTypeCodeId] [int] NOT NULL,		-- CodeList (Category: ProviderScheduleHoursType): Business Hours, Non-Business Hours, 24 Hours a Day, User Defined
	
	[FromTime] [datetime] NULL,
	[ToTime] [datetime] NULL,
	
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProviderSchedule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[ProviderSchedule] ADD  CONSTRAINT [DF_ProviderSchedule_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderSchedule]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderSchedule_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderSchedule]  WITH CHECK ADD  CONSTRAINT [FK_ProviderSchedule_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ProviderSchedule] CHECK CONSTRAINT [FK_ProviderSchedule_Provider]
end

-------------------------- End Foreign Key ---------------------------------------------------------------

-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------



select * from [ProviderSchedule]
end

GO

SET ANSI_PADDING OFF
GO

GO


---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_ProviderSchedule_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProviderSchedule]') AND name = N'IX_ProviderSchedule_1')
DROP INDEX [IX_ProviderSchedule_1] ON [dbo].[ProviderSchedule]
GO




/****** Object:  Index [IX_ProviderSchedule_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ProviderSchedule_1] ON [dbo].[ProviderSchedule]
(
	[ProviderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------

