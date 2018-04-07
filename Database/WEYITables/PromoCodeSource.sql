
/****** Object:  Table [dbo].[PromoCodeSource]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PromoCodeSource]') AND type in (N'U'))
Begin
	/*
	
alter table [PersonPromoCode] drop constraint [FK_PersonPromoCode_PromoCodeSource]
alter table [PromoCodeSourceProperty] drop constraint [FK_PromoCodeSourceProperty_PromoCodeSource]
alter table [ProviderPromoCode] drop constraint [FK_ProviderPromoCode_PromoCodeSource]

	DROP TABLE [dbo].[PromoCodeSource]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'PromoCodeSource')
	)	
	


	declare @TblName as nvarchar(64) = 'PromoCodeSource'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[PromoCodeSource] ' + convert(varchar, getdate())
	
End
else
begin

--drop table [PromoCodeSource]
CREATE TABLE [dbo].[PromoCodeSource](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NULL,
	[ProviderId] [int] NULL,
	[OtherSource] nvarchar(32) NULL,					
	[OtherSourceId] nvarchar(32) NULL,					
	[PromoCode] nvarchar(128) NOT NULL,
	
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PromoCodeSource] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[PromoCodeSource] ADD  CONSTRAINT [DF_PromoCodeSource_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]

----------------------------------------- Foreign Key -------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PromoCodeSource]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PromoCodeSource_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PromoCodeSource]  WITH CHECK ADD  CONSTRAINT [FK_PromoCodeSource_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[PromoCodeSource] CHECK CONSTRAINT [FK_PromoCodeSource_Person]
end


----------------------------------------- End Foreign Key -------------------------------------------------------------------

----------------------------------------- Primary Key Referenced by Other Tables -------------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PromoCodeSource]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonPromoCode]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonPromoCode_PromoCodeSource]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonPromoCode]  WITH CHECK ADD  CONSTRAINT [FK_PersonPromoCode_PromoCodeSource] FOREIGN KEY([PromoCodeSourceId])
	REFERENCES [dbo].[PromoCodeSource] ([Id])

	ALTER TABLE [dbo].[PersonPromoCode] CHECK CONSTRAINT [FK_PersonPromoCode_PromoCodeSource]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PromoCodeSource]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PromoCodeSourceProperty]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PromoCodeSourceProperty_PromoCodeSource]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PromoCodeSourceProperty]  WITH CHECK ADD  CONSTRAINT [FK_PromoCodeSourceProperty_PromoCodeSource] FOREIGN KEY([PromoCodeSourceId])
	REFERENCES [dbo].[PromoCodeSource] ([Id])

	ALTER TABLE [dbo].[PromoCodeSourceProperty] CHECK CONSTRAINT [FK_PromoCodeSourceProperty_PromoCodeSource]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PromoCodeSource]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderPromoCode]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderPromoCode_PromoCodeSource]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderPromoCode]  WITH CHECK ADD  CONSTRAINT [FK_ProviderPromoCode_PromoCodeSource] FOREIGN KEY([PromoCodeSourceId])
	REFERENCES [dbo].[PromoCodeSource] ([Id])

	ALTER TABLE [dbo].[ProviderPromoCode] CHECK CONSTRAINT [FK_ProviderPromoCode_PromoCodeSource]
end


----------------------------------------- End Primary Key Referenced by Other Tables -------------------------------------------------------------------

select * from [PromoCodeSource]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())



/****** Object:  Index [IX_PromoCodeSource_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PromoCodeSource]') AND name = N'IX_PromoCodeSource_1')
DROP INDEX [IX_PromoCodeSource_1] ON [dbo].[PromoCodeSource]
GO




/****** Object:  Index [IX_PromoCodeSource_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_PromoCodeSource_1] ON [dbo].[PromoCodeSource]
(
	[PromoCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO





/****** Object:  Index [IX_PromoCodeSource_2]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PromoCodeSource]') AND name = N'IX_PromoCodeSource_2')
DROP INDEX [IX_PromoCodeSource_2] ON [dbo].[PromoCodeSource]
GO




/****** Object:  Index [IX_PromoCodeSource_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_PromoCodeSource_2] ON [dbo].[PromoCodeSource]
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO





/****** Object:  Index [IX_PromoCodeSource_3]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PromoCodeSource]') AND name = N'IX_PromoCodeSource_3')
DROP INDEX [IX_PromoCodeSource_3] ON [dbo].[PromoCodeSource]
GO




/****** Object:  Index [IX_PromoCodeSource_3]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_PromoCodeSource_3] ON [dbo].[PromoCodeSource]
(
	[ProviderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---------------------------------------------------------------End Index------------------------------------------------------------------
