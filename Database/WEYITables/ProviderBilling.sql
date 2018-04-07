
/****** Object:  Table [dbo].[ProviderBilling]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderBilling]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[ProviderBilling]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ProviderBilling')
	)	
	

	declare @TblName as nvarchar(64) = 'ProviderBilling'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[ProviderBilling] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ProviderBilling](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProviderId] [int] NOT NULL,
	[ProviderBillingTypeCodeId] [int] NOT NULL,		-- from CodeList (Category ProviderBillingType): Service Fee, Payment
	
	[Amount] [money] NOT NULL,						-- Payment to the Provider would be negative value
	
	[DescTemplateId] [int] NOT NULL,
	
	[Description1] [nvarchar](16) NOT NULL,
	[Description2] [nvarchar](16) NOT NULL,
	[Description3] [nvarchar](16) NOT NULL,
	[Description4] [nvarchar](16) NOT NULL,
	[Description5] [nvarchar](16) NOT NULL,
	[Description6] [nvarchar](16) NOT NULL,
	[Description7] [nvarchar](16) NOT NULL,
	[Description8] [nvarchar](16) NOT NULL,
	
	[RefTable] [nvarchar](64) NOT NULL,			-- For debugging purposes, the linked record
	[RefId] [int] NOT NULL,

	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProviderBilling] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[ProviderBilling] ADD  CONSTRAINT [DF_ProviderBilling_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderBilling]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderBilling_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderBilling]  WITH CHECK ADD  CONSTRAINT [FK_ProviderBilling_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ProviderBilling] CHECK CONSTRAINT [FK_ProviderBilling_Provider]
end



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DescTemplate]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderBilling]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderBilling_DescTemplate]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderBilling]  WITH CHECK ADD  CONSTRAINT [FK_ProviderBilling_DescTemplate] FOREIGN KEY([DescTemplateId])
	REFERENCES [dbo].[DescTemplate] ([Id])

	ALTER TABLE [dbo].[ProviderBilling] CHECK CONSTRAINT [FK_ProviderBilling_DescTemplate]
end

-------------------------- End Foreign Key ---------------------------------------------------------------

-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [ProviderBilling]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_ProviderBilling_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProviderBilling]') AND name = N'IX_ProviderBilling_1')
DROP INDEX [IX_ProviderBilling_1] ON [dbo].[ProviderBilling]
GO




/****** Object:  Index [IX_ProviderBilling_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ProviderBilling_1] ON [dbo].[ProviderBilling]
(
	[ProviderId] ASC,
	[ProviderBillingTypeCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
