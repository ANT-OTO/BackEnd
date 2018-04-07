
/****** Object:  Table [dbo].[SpecialRouting]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SpecialRouting]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[SpecialRouting]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'SpecialRouting')
	)	
	


	declare @TblName as nvarchar(64) = 'SpecialRouting'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[SpecialRouting] ' + convert(varchar, getdate())
	
End
else
begin
--drop table [dbo].[SpecialRouting]
CREATE TABLE [dbo].[SpecialRouting](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Purpose] nvarchar(128) NOT NULL,				
	[PersonId] int NOT NULL,					
	[ProviderId] int NOT NULL,

	[SpecialRoutingTypeCodeId] int NOT NULL,		-- 1	All requests from PersonId will only be routed to ProviderId 
													--		(If multiple ProviderId is associated with PersonId in this type, then requests from PersonId may be routed to multiple ProvideId)
													-- 2	ProviderId will only accept requests from PersonId
													--		(If multiple PersonId is associated with ProviderId in this type, then ProviderId may get requests from multiple PersonId)
													-- 3	Both			

	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SpecialRouting] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[SpecialRouting] ADD  CONSTRAINT [DF_SpecialRouting_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]


----------------------------------------- Foreign Key -------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SpecialRouting]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_SpecialRouting_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[SpecialRouting]  WITH CHECK ADD  CONSTRAINT [FK_SpecialRouting_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[SpecialRouting] CHECK CONSTRAINT [FK_SpecialRouting_Person]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SpecialRouting]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_SpecialRouting_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[SpecialRouting]  WITH CHECK ADD  CONSTRAINT [FK_SpecialRouting_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[SpecialRouting] CHECK CONSTRAINT [FK_SpecialRouting_Provider]
end
----------------------------------------- End Foreign Key -------------------------------------------------------------------

----------------------------------------- Primary Key Referenced by Other Tables -------------------------------------------------------------------



----------------------------------------- End Primary Key Referenced by Other Tables -------------------------------------------------------------------

select * from [SpecialRouting]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_SpecialRouting_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SpecialRouting]') AND name = N'IX_SpecialRouting_1')
DROP INDEX [IX_SpecialRouting_1] ON [dbo].[SpecialRouting]
GO




/****** Object:  Index [IX_SpecialRouting_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_SpecialRouting_1] ON [dbo].[SpecialRouting]
(
	[PersonId] ASC,
	[ProviderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO





---------------------------------------------------------------End Index------------------------------------------------------------------
