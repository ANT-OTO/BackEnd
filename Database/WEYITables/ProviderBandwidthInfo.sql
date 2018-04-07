
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderBandwidthInfo]') AND type in (N'U'))
Begin
	/*

alter table [ProviderBandwidthInfoY] drop constraint [FK_ProviderBandwidthInfoY_ProviderBandwidthInfo]
	
	DROP TABLE [dbo].[ProviderBandwidthInfo]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ProviderBandwidthInfo')
	)	
	
	

	declare @TblName as nvarchar(64) = 'ProviderBandwidthInfo'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[ProviderBandwidthInfo] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ProviderBandwidthInfo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProviderId] [int] NOT NULL,
	[UploadSpeed] nvarchar(256) NOT NULL,
	[DownloadSpeed] nvarchar(256) NOT NULL,
	[PingSpeed] nvarchar(256) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProviderBandwidthInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



ALTER TABLE [dbo].[ProviderBandwidthInfo] ADD  CONSTRAINT [DF_ProviderBandwidthInfo_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[ProviderBandwidthInfo] ADD  CONSTRAINT [DF_ProviderBandwidthInfo_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderBandwidthInfo]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderBandwidthInfo_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderBandwidthInfo]  WITH CHECK ADD  CONSTRAINT [FK_ProviderBandwidthInfo_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ProviderBandwidthInfo] CHECK CONSTRAINT [FK_ProviderBandwidthInfo_Provider]
end

-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------




-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [ProviderBandwidthInfo]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProviderBandwidthInfo]') AND name = N'IX_ProviderBandwidthInfo_1')
DROP INDEX [IX_ProviderBandwidthInfo_1] ON [dbo].[ProviderBandwidthInfo]
GO



CREATE NONCLUSTERED INDEX [IX_ProviderBandwidthInfo_1] ON [dbo].[ProviderBandwidthInfo]
(
	[ProviderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




---------------------------------------------------------------End Index------------------------------------------------------------------
