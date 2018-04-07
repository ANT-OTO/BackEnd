
/****** Object:  Table [dbo].[PersonReferralAction]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonReferralAction]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[PersonReferralAction]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'PersonReferralAction')
	)	
	


	declare @TblName as nvarchar(64) = 'PersonReferralAction'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[PersonReferralAction] ' + convert(varchar, getdate())
	
End
else
begin
--drop table [dbo].[PersonReferralAction]
CREATE TABLE [dbo].[PersonReferralAction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] int NOT NULL,					
	[ProviderPreRegisterId] int NULL,
	[PersonPreRegisterId] int NULL,
	
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PersonReferralAction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[PersonReferralAction] ADD  CONSTRAINT [DF_PersonReferralAction_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]


---------------------------------------------- Foreign Keys -------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonReferralAction]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonReferralAction_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonReferralAction]  WITH CHECK ADD  CONSTRAINT [FK_PersonReferralAction_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[PersonReferralAction] CHECK CONSTRAINT [FK_PersonReferralAction_Person]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonPreRegister]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonReferralAction]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonReferralAction_PersonPreRegister]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonReferralAction]  WITH CHECK ADD  CONSTRAINT [FK_PersonReferralAction_PersonPreRegister] FOREIGN KEY([PersonPreRegisterId])
	REFERENCES [dbo].[PersonPreRegister] ([Id])

	ALTER TABLE [dbo].[PersonReferralAction] CHECK CONSTRAINT [FK_PersonReferralAction_PersonPreRegister]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonPreRegister]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonReferralAction]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_PersonReferralAction_PersonPreRegister]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[PersonReferralAction]  WITH CHECK ADD  CONSTRAINT [FK_PersonReferralAction_PersonPreRegister] FOREIGN KEY([PersonPreRegisterId])
	REFERENCES [dbo].[PersonPreRegister] ([Id])

	ALTER TABLE [dbo].[PersonReferralAction] CHECK CONSTRAINT [FK_PersonReferralAction_PersonPreRegister]
end

---------------------------------------------- End Foreign Keys -------------------------------------------------------------------

select * from [PersonReferralAction]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_PersonReferralAction_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PersonReferralAction]') AND name = N'IX_PersonReferralAction_1')
DROP INDEX [IX_PersonReferralAction_1] ON [dbo].[PersonReferralAction]
GO




/****** Object:  Index [IX_PersonReferralAction_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_PersonReferralAction_1] ON [dbo].[PersonReferralAction]
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




---------------------------------------------------------------End Index------------------------------------------------------------------
