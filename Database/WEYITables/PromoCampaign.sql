
/****** Object:  Table [dbo].[PromoCampaign]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PromoCampaign]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[PromoCampaign]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'PromoCampaign')
	)	
	


	declare @TblName as nvarchar(64) = 'PromoCampaign'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[PromoCampaign] ' + convert(varchar, getdate())
	
End
else
begin

--drop table [PromoCampaign]
CREATE TABLE [dbo].[PromoCampaign](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] datetime NOT NULL,
	[EndDate] datetime NOT NULL,
	[CampaignDescription] nvarchar(max) NOT NULL,
	[CampaignDescription2] nvarchar(max) NULL,
	[CampaignDescription3] nvarchar(max) NULL,
	[CompanyId] int NULL,
	[PromoTypeCodeId] int NOT NULL,   -- select * from CodeList where Category = 'PromoType'
	[PromoBenefitTypeCodeId] int NOT NULL,-- select * from CodeList where Category = 'PromoBenefitType'
	[PromoBenefitPara1] varchar(32) NULL,
	[PromoBenefitPara2] varchar(32) NULL,
	[PromoBenefitPara3] varchar(32) NULL,
	[PromoBenefitPara4] varchar(32) NULL,
	[PromoBenefitPara5] varchar(32) NULL,
	[PromoBenefitPara6] varchar(32) NULL,
	[PromoBenefitPara7] varchar(32) NULL,
	[PromoBenefitPara8] varchar(32) NULL,
	[PromoBenefitPara9] varchar(32) NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PromoCampaign] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[PromoCampaign] ADD  CONSTRAINT [DF_PromoCampaign_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Company]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PromoCampaign]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PromoCampaign_Company]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PromoCampaign]  WITH CHECK ADD  CONSTRAINT [FK_PromoCampaign_Company] FOREIGN KEY([CompanyId])
	REFERENCES [dbo].[Company] ([Id])

	ALTER TABLE [dbo].[PromoCampaign] CHECK CONSTRAINT [FK_PromoCampaign_Company]
end




select * from [PromoCampaign]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_PromoCampaign_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PromoCampaign]') AND name = N'IX_PromoCampaign_1')
DROP INDEX [IX_PromoCampaign_1] ON [dbo].[PromoCampaign]
GO




/****** Object:  Index [IX_PromoCampaign_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_PromoCampaign_1] ON [dbo].[PromoCampaign]
(
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---------------------------------------------------------------End Index------------------------------------------------------------------
