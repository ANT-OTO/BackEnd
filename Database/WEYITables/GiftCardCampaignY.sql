
/****** Object:  Table [dbo].[GiftCardCampaignY]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GiftCardCampaignY]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[GiftCardCampaignY]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'GiftCardCampaignY')
	)	
	


	declare @TblName as nvarchar(64) = 'GiftCardCampaignY'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[GiftCardCampaignY] ' + convert(varchar, getdate())
	
End
else
begin

--drop table [GiftCardCampaignY]
CREATE TABLE [dbo].[GiftCardCampaignY](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GiftCardCampaignId] [int] NOT NULL,
	[SystemLanguageId] [int] NOT NULL,
	[CampaignDescription1] nvarchar(max) NOT NULL,
	[CampaignDescription2] nvarchar(max) NULL,
	[CampaignDescription3] nvarchar(max) NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_GiftCardCampaignY] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[GiftCardCampaignY] ADD  CONSTRAINT [DF_GiftCardCampaignY_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[GiftCardCampaignY] ADD  CONSTRAINT [DF_GiftCardCampaignY_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemLanguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GiftCardCampaignY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_GiftCardCampaignY_SystemLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[GiftCardCampaignY]  WITH CHECK ADD  CONSTRAINT [FK_GiftCardCampaignY_SystemLanguage] FOREIGN KEY([SystemLanguageId])
	REFERENCES [dbo].[SystemLanguage] ([Id])

	ALTER TABLE [dbo].[GiftCardCampaignY] CHECK CONSTRAINT [FK_GiftCardCampaignY_SystemLanguage]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GiftCardCampaign]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GiftCardCampaignY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_GiftCardCampaignY_GiftCardCampaign]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[GiftCardCampaignY]  WITH CHECK ADD  CONSTRAINT [FK_GiftCardCampaignY_GiftCardCampaign] FOREIGN KEY([GiftCardCampaignId])
	REFERENCES [dbo].[GiftCardCampaign] ([Id])

	ALTER TABLE [dbo].[GiftCardCampaignY] CHECK CONSTRAINT [FK_GiftCardCampaignY_GiftCardCampaign]
end



select * from [GiftCardCampaignY]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_GiftCardCampaignY_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[GiftCardCampaignY]') AND name = N'IX_GiftCardCampaignY_1')
DROP INDEX [IX_GiftCardCampaignY_1] ON [dbo].[GiftCardCampaignY]
GO




/****** Object:  Index [IX_GiftCardCampaignY_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_GiftCardCampaignY_1] ON [dbo].[GiftCardCampaignY]
(
	[GiftCardCampaignId] ASC,
	[SystemLanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---------------------------------------------------------------End Index------------------------------------------------------------------
