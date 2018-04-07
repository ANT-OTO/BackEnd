
/****** Object:  Table [dbo].[DPT]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPT]') AND type in (N'U'))
Begin
	/*

alter table [DPTListQueryDetail] drop constraint [FK_DPTListQueryDetail_DPTId]
alter table [DPTProperty] drop constraint [FK_DPTProperty_DPT]
alter table [DPTProvider] drop constraint [FK_DPTProvider_DPT]
alter table [DPTRouteLog] drop constraint [FK_DPTRouteLog_DPT]
	
	DROP TABLE [dbo].[DPT]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'DPT')
	)
	
	
	declare @TblName as nvarchar(64) = 'DPT'
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
	print 'you need to manually exec DROP TABLE [dbo].[DPT] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[DPT](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NULL,				-- 
	[FromLanguageId] [int] NOT NULL,		
	[ToLanguageId] [int] NOT NULL,		

	[TextBlockId] [int] NOT NULL,	
	[Note] nvarchar(max) NOT NULL,		

	[DPTStatusCodeId] [int] NOT NULL,		
										-- CodeList (Category: DPTStatus): New, Sent To Provider, Accepted by Provider, Translation In Process, Finished, 
										--			Cancelled By User, Cancelled by System, Escallated by Provider, Denied by Provider, Denied by System
	

	[ProviderId] [int] NULL,			-- Provider who performed service
	[FinishTime] [datetime] NULL,
	
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_DPT] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]




ALTER TABLE [dbo].[DPT] ADD  CONSTRAINT [DF_DPT_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[DPT] ADD  CONSTRAINT [DF_DPT_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPT]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPT_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPT]  WITH CHECK ADD  CONSTRAINT [FK_DPT_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[DPT] CHECK CONSTRAINT [FK_DPT_Person]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPT]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPT_Language1]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPT]  WITH CHECK ADD  CONSTRAINT [FK_DPT_Language1] FOREIGN KEY([FromLanguageId])
	REFERENCES [dbo].[Language] ([Id])

	ALTER TABLE [dbo].[DPT] CHECK CONSTRAINT [FK_DPT_Language1]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPT]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPT_Language2]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPT]  WITH CHECK ADD  CONSTRAINT [FK_DPT_Language2] FOREIGN KEY([ToLanguageId])
	REFERENCES [dbo].[Language] ([Id])

	ALTER TABLE [dbo].[DPT] CHECK CONSTRAINT [FK_DPT_Language2]
end



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPT]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPT_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPT]  WITH CHECK ADD  CONSTRAINT [FK_DPT_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[DPT] CHECK CONSTRAINT [FK_DPT_Provider]
end

-------------------------- End Foreign Key ---------------------------------------------------------------

--------------------------------------------------- Begin Primary Key Referenced by other tables -------------------------------------------



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPT]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTListQueryDetail]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPTListQueryDetail_DPTId]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPTListQueryDetail]  WITH CHECK ADD  CONSTRAINT [FK_DPTListQueryDetail_DPTId] FOREIGN KEY([DPTId])
	REFERENCES [dbo].[DPT] ([Id])

	ALTER TABLE [dbo].[DPTListQueryDetail] CHECK CONSTRAINT [FK_DPTListQueryDetail_DPTId]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPT]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTProperty]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPTProperty_DPT]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPTProperty]  WITH CHECK ADD  CONSTRAINT [FK_DPTProperty_DPT] FOREIGN KEY([DPTId])
	REFERENCES [dbo].[DPT] ([Id])

	ALTER TABLE [dbo].[DPTProperty] CHECK CONSTRAINT [FK_DPTProperty_DPT]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPT]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTProvider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPTProvider_DPT]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPTProvider]  WITH CHECK ADD  CONSTRAINT [FK_DPTProvider_DPT] FOREIGN KEY([DPTId])
	REFERENCES [dbo].[DPT] ([Id])

	ALTER TABLE [dbo].[DPTProvider] CHECK CONSTRAINT [FK_DPTProvider_DPT]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPT]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTRouteLog]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_DPTRouteLog_DPT]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[DPTRouteLog]  WITH CHECK ADD  CONSTRAINT [FK_DPTRouteLog_DPT] FOREIGN KEY([DPTId])
	REFERENCES [dbo].[DPT] ([Id])

	ALTER TABLE [dbo].[DPTRouteLog] CHECK CONSTRAINT [FK_DPTRouteLog_DPT]
end

--------------------------------------------------- End Primary Key Referenced by other tables -------------------------------------------


select * from [DPT]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_DPT_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DPT]') AND name = N'IX_DPT_1')
DROP INDEX [IX_DPT_1] ON [dbo].[DPT]
GO




/****** Object:  Index [IX_DPT_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_DPT_1] ON [dbo].[DPT]
(
	[PersonId] ASC,
	[FromLanguageId] ASC,
	[ToLanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



/****** Object:  Index [IX_DPT_2]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DPT]') AND name = N'IX_DPT_2')
DROP INDEX [IX_DPT_2] ON [dbo].[DPT]
GO




/****** Object:  Index [IX_DPT_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_DPT_2] ON [dbo].[DPT]
(
	[TextBlockId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


-----------------------------------------------------

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DPT]') AND name = N'IX_DPT_3')
DROP INDEX [IX_DPT_3] ON [dbo].[DPT]
GO



CREATE NONCLUSTERED INDEX [IX_DPT_3] ON [dbo].[DPT]
(
	[DPTStatusCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

-----------------------------------------------------

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DPT]') AND name = N'IX_DPT_4')
begin
print 'DROP INDEX [IX_DPT_4] ON [dbo].[DPT]'
DROP INDEX [IX_DPT_4] ON [dbo].[DPT]
end
GO



CREATE NONCLUSTERED INDEX [IX_DPT_4] ON [dbo].[DPT]
(
	[FinishTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
---------------------------------------------------------------End Index------------------------------------------------------------------
