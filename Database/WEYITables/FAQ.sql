
/****** Object:  Table [dbo].[FAQ]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAQ]') AND type in (N'U'))
Begin
	/*
	alter table [FAQY] drop constraint [FK_FAQY_FAQ]
	DROP TABLE [dbo].[FAQ]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'FAQ')
	)
	

	declare @TblName as nvarchar(64) = 'FAQ'
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
	print 'you need to manually exec DROP TABLE [dbo].[FAQ] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[FAQ](
	[Id] [int] IDENTITY(1,1) NOT NULL,

	[AppName] [varchar](32) NOT NULL,		-- Client_iPhone, Client_Android, Provider_iPhone, Provider_Android, Provider_Web

	[ItemKey] [varchar](16) NOT NULL,

	[Content] [nvarchar](max) NOT NULL,			
	
	[IsLink] [bit] NOT NULL,
	
	[ParentKey] [varchar](16) NULL,
	[Level] [int] NOT NULL,
	
	[DisplayOrder] [varchar](8) NOT NULL,
	
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_FAQ] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



ALTER TABLE [dbo].[FAQ] ADD  CONSTRAINT [DF_FAQ_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[FAQ] ADD  CONSTRAINT [DF_FAQ_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]


--------------------------------------------------- Begin Primary Key Referenced by other tables -------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAQ]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAQY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_FAQY_FAQ]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[FAQY]  WITH CHECK ADD  CONSTRAINT [FK_FAQY_FAQ] FOREIGN KEY([FAQId])
	REFERENCES [dbo].[FAQ] ([Id])

	ALTER TABLE [dbo].[FAQY] CHECK CONSTRAINT [FK_FAQY_FAQ]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAQ]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CK_FAQ]') AND type in (N'C'))
begin
	ALTER TABLE [dbo].[FAQ]  WITH CHECK ADD  CONSTRAINT [CK_FAQ] CHECK  (([dbo].[sfnSystemFAQConstraint]([AppName], [ParentKey], [IsLink])=(1)))

	ALTER TABLE [dbo].[FAQ] CHECK CONSTRAINT [CK_FAQ]
end

--------------------------------------------------- End Primary Key Referenced by other tables -------------------------------------------

select * from [FAQ]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())



/****** Object:  Index [IX_FAQ_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FAQ]') AND name = N'IX_FAQ_1')
DROP INDEX [IX_FAQ_1] ON [dbo].[FAQ]
GO




/****** Object:  Index [IX_FAQ_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_FAQ_1] ON [dbo].[FAQ]
(
	[ParentKey] ASC,
	[DisplayOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




/****** Object:  Index [IX_FAQ_2]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FAQ]') AND name = N'IX_FAQ_2')
DROP INDEX [IX_FAQ_2] ON [dbo].[FAQ]
GO




/****** Object:  Index [IX_FAQ_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_FAQ_2] ON [dbo].[FAQ]
(
	[AppName] ASC,
	[ItemKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---------------------------------------------------------------End Index------------------------------------------------------------------
