/****** Object:  Table [dbo].[BillPersonInfo]    Script Date: Jul 14 2016  4:12PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonInfo]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[BillPersonInfo]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'BillPersonInfo')
	)	
	
	
	declare @TblName as nvarchar(64) = 'BillPersonInfo'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[BillPersonInfo] ' + convert(varchar, getdate())
	
End
else
begin

	CREATE TABLE [dbo].[BillPersonInfo](
		[Id] int IDENTITY(1,1) NOT NULL,
		[PersonId] [int] NOT NULL,
		[IsIndividualBilling] Bit  NOT NULL,		

		[Balance] decimal (14,2) NOT NULL,				-- negative means the Person needs to pay. positive means the person has credit.
		[RequiredPaymentNow] decimal (14, 2) NOT NULL,	-- >= 0. If greater than 0, the person needs to pay.

		[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_BillPersonInfo_CreateDate]  DEFAULT (getutcdate()),
		[LastUpdate] datetime NOT NULL CONSTRAINT [DF_BillPersonInfo_LastUpdate]  DEFAULT (getutcdate()),
		[LastUpdateBy] int NOT NULL,
		[LastUpdateByType] int NOT NULL,
	 CONSTRAINT [PK_BillPersonInfo] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	-------------------------- Begin Foreign Key ---------------------------------------------------------------
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
		and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonInfo]') AND type in (N'U'))
		and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_BillPersonInfo_Person]') AND type in (N'F'))
	begin
		ALTER TABLE [dbo].[BillPersonInfo]  WITH CHECK ADD  CONSTRAINT FK_BillPersonInfo_Person FOREIGN KEY(PersonId)
		REFERENCES [dbo].Person ([Id])

		ALTER TABLE [dbo].[BillPersonInfo] CHECK CONSTRAINT FK_BillPersonInfo_Person
	end

	-------------------------- End Foreign Key ---------------------------------------------------------------

select * from [BillPersonInfo]
end
GO

SET ANSI_PADDING OFF
GO

print '
Create Index ' + convert(varchar, getdate())


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonInfo]') AND name = N'BillPersonInfo_1')
begin
	print 'DROP INDEX [BillPersonInfo_1] ON [dbo].[BillPersonInfo]'
	DROP INDEX [BillPersonInfo_1] ON [dbo].[BillPersonInfo]
end
GO

print 'CREATE UNIQUE NONCLUSTERED INDEX [BillPersonInfo_1] ON [dbo].[BillPersonInfo]'
CREATE UNIQUE NONCLUSTERED INDEX [BillPersonInfo_1] ON [dbo].[BillPersonInfo]
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

------------------------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonInfo]') AND name = N'BillPersonInfo_2')
begin
	print 'DROP INDEX [BillPersonInfo_2] ON [dbo].[BillPersonInfo]'
	DROP INDEX [BillPersonInfo_2] ON [dbo].[BillPersonInfo]
end
GO

print 'CREATE NONCLUSTERED INDEX [BillPersonInfo_2] ON [dbo].[BillPersonInfo]'
CREATE NONCLUSTERED INDEX [BillPersonInfo_2] ON [dbo].[BillPersonInfo]
(
	IsIndividualBilling ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

------------------------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonInfo]') AND name = N'BillPersonInfo_3')
begin
	print 'DROP INDEX [BillPersonInfo_3] ON [dbo].[BillPersonInfo]'
	DROP INDEX [BillPersonInfo_3] ON [dbo].[BillPersonInfo]
end
GO

print 'CREATE NONCLUSTERED INDEX [BillPersonInfo_3] ON [dbo].[BillPersonInfo]'
CREATE NONCLUSTERED INDEX [BillPersonInfo_3] ON [dbo].[BillPersonInfo]
(
	Balance ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

------------------------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonInfo]') AND name = N'BillPersonInfo_4')
begin
	print 'DROP INDEX [BillPersonInfo_4] ON [dbo].[BillPersonInfo]'
	DROP INDEX [BillPersonInfo_4] ON [dbo].[BillPersonInfo]
end
GO

print 'CREATE NONCLUSTERED INDEX [BillPersonInfo_4] ON [dbo].[BillPersonInfo]'
CREATE NONCLUSTERED INDEX [BillPersonInfo_4] ON [dbo].[BillPersonInfo]
(
	[RequiredPaymentNow] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO