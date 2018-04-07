
/****** Object:  Table [dbo].[ProviderTwilioVideoAccount]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderTwilioVideoAccount]') AND type in (N'U'))
Begin
	/*

alter table [InterviewProviderTwilioVideoAccount] drop constraint [FK_InterviewProviderTwilioVideoAccount_ProviderTwilioVideoAccount]
alter table [RequestProviderTwilioVideoAccount] drop constraint [FK_RequestProviderTwilioVideoAccount_ProviderTwilioVideoAccount]
	
	DROP TABLE [dbo].[ProviderTwilioVideoAccount]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ProviderTwilioVideoAccount')
	)	
	
	

	declare @TblName as nvarchar(64) = 'ProviderTwilioVideoAccount'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[ProviderTwilioVideoAccount] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ProviderTwilioVideoAccount](
	[Id] [int] IDENTITY(10000000,1) NOT NULL,
	[ProviderId] [int] NOT NULL,				
	[AccountNumber] [nvarchar](64) NOT NULL,
	[ExpirationSeconds] [int] NOT NULL,
	[Purpose] [varchar](8) NOT NULL,			-- C: Caller, L: Listener

	
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProviderTwilioVideoAccount] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[ProviderTwilioVideoAccount] ADD  CONSTRAINT [DF_ProviderTwilioVideoAccount_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[ProviderTwilioVideoAccount] ADD  CONSTRAINT [DF_ProviderTwilioVideoAccount_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderTwilioVideoAccount]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderTwilioVideoAccount_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderTwilioVideoAccount]  WITH CHECK ADD  CONSTRAINT [FK_ProviderTwilioVideoAccount_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ProviderTwilioVideoAccount] CHECK CONSTRAINT [FK_ProviderTwilioVideoAccount_Provider]
end


-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [ProviderTwilioVideoAccount]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_ProviderTwilioVideoAccount_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProviderTwilioVideoAccount]') AND name = N'IX_ProviderTwilioVideoAccount_1')
DROP INDEX [IX_ProviderTwilioVideoAccount_1] ON [dbo].[ProviderTwilioVideoAccount]
GO




/****** Object:  Index [IX_ProviderTwilioVideoAccount_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ProviderTwilioVideoAccount_1] ON [dbo].[ProviderTwilioVideoAccount]
(
	[ProviderId] ASC,
	[Purpose] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
