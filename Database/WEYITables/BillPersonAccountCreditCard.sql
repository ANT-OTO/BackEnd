/****** Object:  Table [dbo].[BillPersonAccountCreditCard]    Script Date: Jul 14 2016  4:12PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonAccountCreditCard]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[BillPersonAccountCreditCard]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'BillPersonAccountCreditCard')
	)	
	
	
	declare @TblName as nvarchar(64) = 'BillPersonAccountCreditCard'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[BillPersonAccountCreditCard] ' + convert(varchar, getdate())
	
End
else
begin

	CREATE TABLE [dbo].[BillPersonAccountCreditCard](
		[Id] [int] IDENTITY(1,1) NOT NULL,
		[CardNumber] [nvarchar](128) NOT NULL,
		[Last4CardNumber] [varchar](4) NOT NULL,
		[ExpMonth] [varchar](2) NOT NULL,
		[ExpYear] [varchar](4) NOT NULL,
		[NameOnCard] [nvarchar](256) NOT NULL,
		[AddressId] [int] NULL,
		[ZipCode] [nvarchar](50) NULL,
		[Phone] [nvarchar](128) NULL,
		[Default] [bit] NOT NULL,

		[Version] [timestamp] NOT NULL,
		[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_BillPersonAccountCreditCard_CreateDate]  DEFAULT (getutcdate()),
		[LastUpdate] [datetime] NOT NULL,
		[LastUpdateBy] [int] NOT NULL,
		[LastUpdateByType] [int] NOT NULL,
	 CONSTRAINT [PK_BillPersonAccountCreditCard] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

ALTER TABLE [dbo].[BillPersonAccountCreditCard] ADD  CONSTRAINT [DF_BillPersonAccountCreditCard_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------


-------------------------- End Foreign Key ---------------------------------------------------------------


-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------



-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [BillPersonAccountCreditCard]

end
GO

SET ANSI_PADDING OFF
GO


---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonAccountCreditCard]') AND name = N'BillPersonAccountCreditCard_1')
DROP INDEX [BillPersonAccountCreditCard_1] ON [dbo].[BillPersonAccountCreditCard]
GO

CREATE NONCLUSTERED INDEX [BillPersonAccountCreditCard_1] ON [dbo].[BillPersonAccountCreditCard]
(
	[CardNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BillPersonAccountCreditCard]') AND name = N'BillPersonAccountCreditCard_2')
DROP INDEX [BillPersonAccountCreditCard_2] ON [dbo].[BillPersonAccountCreditCard]
GO

CREATE NONCLUSTERED INDEX [BillPersonAccountCreditCard_2] ON [dbo].[BillPersonAccountCreditCard]
(
	[Default] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

---------------------------------------------------------------End Index------------------------------------------------------------------
