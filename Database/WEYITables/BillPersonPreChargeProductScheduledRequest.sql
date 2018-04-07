/****** Object:  Table [dbo].[BillPersonPreChargeProductScheduledRequest]    Script Date: Jul 14 2016  4:12PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonPreChargeProductScheduledRequest]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[BillPersonPreChargeProductScheduledRequest]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'BillPersonPreChargeProductScheduledRequest')
	)	
	
	
	declare @TblName as nvarchar(64) = 'BillPersonPreChargeProductScheduledRequest'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[BillPersonPreChargeProductScheduledRequest] ' + convert(varchar, getdate())
	
End
else
begin

	CREATE TABLE [dbo].[BillPersonPreChargeProductScheduledRequest](
		[Id] int IDENTITY(1,1) NOT NULL,
		[BillPersonPreChargeProductId] int NOT NULL,
		[ScheduledRequestId] int NOT NULL,
		[Version] timestamp NOT NULL,
		[CreateDate] datetime NOT NULL CONSTRAINT [DF_BillPersonPreChargeProductScheduledRequest_CreateDate]  DEFAULT (getutcdate()),
		[LastUpdate] datetime NOT NULL CONSTRAINT [DF_BillPersonPreChargeProductScheduledRequest_LastUpdate]  DEFAULT (getutcdate()),
		[LastUpdateBy] int NOT NULL,
		[LastUpdateByType] int NOT NULL,
	 CONSTRAINT [PK_BillPersonPreChargeProductScheduledRequest] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	-------------------------- Begin Foreign Key ---------------------------------------------------------------
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonPreChargeProduct]') AND type in (N'U'))
		and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonPreChargeProductScheduledRequest]') AND type in (N'U'))
		and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_BillPersonPreChargeProductScheduledRequest_BillPersonPreChargeProduct]') AND type in (N'F'))
	begin
		ALTER TABLE [dbo].[BillPersonPreChargeProductScheduledRequest]  WITH CHECK ADD  CONSTRAINT FK_BillPersonPreChargeProductScheduledRequest_BillPersonPreChargeProduct FOREIGN KEY(BillPersonPreChargeProductId)
		REFERENCES [dbo].BillPersonPreChargeProduct ([Id])

		ALTER TABLE [dbo].[BillPersonPreChargeProductScheduledRequest] CHECK CONSTRAINT FK_BillPersonPreChargeProductScheduledRequest_BillPersonPreChargeProduct
	end

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduledRequest]') AND type in (N'U'))
		and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonPreChargeProductScheduledRequest]') AND type in (N'U'))
		and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_BillPersonPreChargeProductScheduledRequest_ScheduledRequest]') AND type in (N'F'))
	begin
		ALTER TABLE [dbo].[BillPersonPreChargeProductScheduledRequest]  WITH CHECK ADD  CONSTRAINT FK_BillBillPersonPreChargeProductPreChargeProductRequest_ScheduledRequest FOREIGN KEY(ScheduledRequestId)
		REFERENCES [dbo].ScheduledRequest ([Id])

		ALTER TABLE [dbo].[BillPersonPreChargeProductScheduledRequest] CHECK CONSTRAINT FK_BillBillPersonPreChargeProductPreChargeProductRequest_ScheduledRequest
	end

	-------------------------- End Foreign Key ---------------------------------------------------------------

select * from [BillPersonPreChargeProductScheduledRequest]
end
GO

SET ANSI_PADDING OFF
GO

print '
Create Index ' + convert(varchar, getdate())


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonPreChargeProductScheduledRequest]') AND name = N'BillPersonPreChargeProductScheduledRequest_1')
DROP INDEX [BillPersonPreChargeProductScheduledRequest_1] ON [dbo].[BillPersonPreChargeProductScheduledRequest]
GO

CREATE NONCLUSTERED INDEX [BillPersonPreChargeProductScheduledRequest_1] ON [dbo].[BillPersonPreChargeProductScheduledRequest]
(
	[BillPersonPreChargeProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonPreChargeProductScheduledRequest]') AND name = N'BillPersonPreChargeProductScheduledRequest_2')
DROP INDEX [BillPersonPreChargeProductScheduledRequest_2] ON [dbo].[BillPersonPreChargeProductScheduledRequest]
GO

CREATE NONCLUSTERED INDEX [BillPersonPreChargeProductScheduledRequest_2] ON [dbo].[BillPersonPreChargeProductScheduledRequest]
(
	[ScheduledRequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
