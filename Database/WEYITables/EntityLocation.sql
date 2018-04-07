
/****** Object:  Table [dbo].[EntityLocation]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EntityLocation]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[EntityLocation]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'EntityLocation')
	)	
	
	

	declare @TblName as nvarchar(64) = 'EntityLocation'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[EntityLocation] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[EntityLocation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NULL,	
	[ProviderId] [int] NULL,

	[Latitude] decimal(18, 10) NULL,			-- decimal degrees	
	[Longitude] decimal(18, 10) NULL,			-- decimal degrees
	[Altitude] decimal(18, 3) NULL,				-- meters above the reference ellipsoid
	[Accuracy] decimal(18, 3) NULL,				-- meters
	[AltitudeAccuracy] decimal(18, 3) NULL,		-- meters
	[Heading] decimal(18, 10) NULL,				-- degrees clockwise from true north
	[Speed] decimal(18, 3) NULL,				-- meters/second

	[CountryCode] [nvarchar](16) NOT NULL,		-- ISO-3166 Country Codes 


	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_EntityLocation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[EntityLocation] ADD  CONSTRAINT [DF_EntityLocation_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EntityLocation]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_EntityLocation_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[EntityLocation]  WITH CHECK ADD  CONSTRAINT [FK_EntityLocation_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[EntityLocation] CHECK CONSTRAINT [FK_EntityLocation_Person]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EntityLocation]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_EntityLocation_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[EntityLocation]  WITH CHECK ADD  CONSTRAINT [FK_EntityLocation_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[EntityLocation] CHECK CONSTRAINT [FK_EntityLocation_Provider]
end


-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [EntityLocation]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_EntityLocation_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EntityLocation]') AND name = N'IX_EntityLocation_1')
DROP INDEX [IX_EntityLocation_1] ON [dbo].[EntityLocation]
GO




/****** Object:  Index [IX_EntityLocation_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_EntityLocation_1] ON [dbo].[EntityLocation]
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




/****** Object:  Index [IX_EntityLocation_2]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EntityLocation]') AND name = N'IX_EntityLocation_2')
DROP INDEX [IX_EntityLocation_2] ON [dbo].[EntityLocation]
GO




/****** Object:  Index [IX_EntityLocation_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_EntityLocation_2] ON [dbo].[EntityLocation]
(
	[ProviderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---------------------------------------------------------------End Index------------------------------------------------------------------
