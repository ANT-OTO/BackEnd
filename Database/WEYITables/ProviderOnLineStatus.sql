
/****** Object:  Table [dbo].[ProviderOnLineStatus]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderOnLineStatus]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[ProviderOnLineStatus]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ProviderOnLineStatus')
	)	
	
	
	declare @TblName as nvarchar(64) = 'ProviderOnLineStatus'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[ProviderOnLineStatus] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ProviderOnLineStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProviderId] [int] NOT NULL,
	[ProviderOnlineStatusCodeId] int NOT NULL,				
	[OffLineReasonCodeId] int NULL,  --select * from CodeList where Category = 'ProviderOffReason'
	[OffLineReasonDetail] nvarchar(max) NULL, -- only for other reason
	[EstimateOffTime] int NULL,  -- Unit is Minutes
	[VideoOptionCodeId] int NULL, -- only for Online
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL 
 CONSTRAINT [PK_ProviderOnLineStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[ProviderOnLineStatus] ADD  CONSTRAINT [DF_ProviderOnLineStatus_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderOnLineStatus]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderOnLineStatus_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderOnLineStatus]  WITH CHECK ADD  CONSTRAINT [FK_ProviderOnLineStatus_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ProviderOnLineStatus] CHECK CONSTRAINT [FK_ProviderOnLineStatus_Provider]
end




select * from [ProviderOnLineStatus]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_ProviderOnLineStatus_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProviderOnLineStatus]') AND name = N'IX_ProviderOnLineStatus_1')
DROP INDEX [IX_ProviderOnLineStatus_1] ON [dbo].[ProviderOnLineStatus]
GO




/****** Object:  Index [IX_ProviderOnLineStatus_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ProviderOnLineStatus_1] ON [dbo].[ProviderOnLineStatus]
(
	[ProviderId] ASC,
	[ProviderOnlineStatusCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProviderOnLineStatus]') AND name = N'IX_ProviderOnLineStatus_2')
begin
	print 'DROP INDEX [IX_ProviderOnLineStatus_2] ON [dbo].[ProviderOnLineStatus]'
	DROP INDEX [IX_ProviderOnLineStatus_2] ON [dbo].[ProviderOnLineStatus]
end
GO




CREATE NONCLUSTERED INDEX [IX_ProviderOnLineStatus_2] ON [dbo].[ProviderOnLineStatus]
(
	[ProviderId] ASC,
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---------------------------------------------------------------End Index------------------------------------------------------------------
