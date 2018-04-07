
/****** Object:  Table [dbo].[ProviderOpenTaskAcceptLog]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderOpenTaskAcceptLog]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[ProviderOpenTaskAcceptLog]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'ProviderOpenTaskAcceptLog')
	)	
	
	
	declare @TblName as nvarchar(64) = 'ProviderOpenTaskAcceptLog'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[ProviderOpenTaskAcceptLog] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ProviderOpenTaskAcceptLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProviderId] int NOT NULL,

	[RequestProviderId] [int] NULL,				-- Service Request from Person. The provider is the service provider
	[InterviewProviderId] [int] NULL,			-- Interview task from Interviewer. The provider is the interview candidate.
	[InterviewId] [int] NULL,					-- Interview task to Candidate. The provider is the Interviewer.

	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProviderOpenTaskAcceptLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



-------------------------- Begin Foreign Key ---------------------------------------------------------------



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestProvider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderOpenTaskAcceptLog]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderOpenTaskAcceptLog_RequestProviderId]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderOpenTaskAcceptLog]  WITH CHECK ADD  CONSTRAINT [FK_ProviderOpenTaskAcceptLog_RequestProviderId] FOREIGN KEY([RequestProviderId])
	REFERENCES [dbo].[RequestProvider] ([Id])

	ALTER TABLE [dbo].[ProviderOpenTaskAcceptLog] CHECK CONSTRAINT [FK_ProviderOpenTaskAcceptLog_RequestProviderId]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewProvider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderOpenTaskAcceptLog]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderOpenTaskAcceptLog_InterviewProviderId]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderOpenTaskAcceptLog]  WITH CHECK ADD  CONSTRAINT [FK_ProviderOpenTaskAcceptLog_InterviewProviderId] FOREIGN KEY([InterviewProviderId])
	REFERENCES [dbo].[InterviewProvider] ([Id])

	ALTER TABLE [dbo].[ProviderOpenTaskAcceptLog] CHECK CONSTRAINT [FK_ProviderOpenTaskAcceptLog_InterviewProviderId]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Interview]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderOpenTaskAcceptLog]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderOpenTaskAcceptLog_InterviewId]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderOpenTaskAcceptLog]  WITH CHECK ADD  CONSTRAINT [FK_ProviderOpenTaskAcceptLog_InterviewId] FOREIGN KEY([InterviewId])
	REFERENCES [dbo].[Interview] ([Id])

	ALTER TABLE [dbo].[ProviderOpenTaskAcceptLog] CHECK CONSTRAINT [FK_ProviderOpenTaskAcceptLog_InterviewId]
end

-------------------------- End Foreign Key ---------------------------------------------------------------

-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [ProviderOpenTaskAcceptLog]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_ProviderOpenTaskAcceptLog_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProviderOpenTaskAcceptLog]') AND name = N'IX_ProviderOpenTaskAcceptLog_1')
DROP INDEX [IX_ProviderOpenTaskAcceptLog_1] ON [dbo].[ProviderOpenTaskAcceptLog]
GO




/****** Object:  Index [IX_ProviderOpenTaskAcceptLog_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ProviderOpenTaskAcceptLog_1] ON [dbo].[ProviderOpenTaskAcceptLog]
(
	[ProviderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProviderOpenTaskAcceptLog]') AND name = N'IX_ProviderOpenTaskAcceptLog_2')
DROP INDEX [IX_ProviderOpenTaskAcceptLog_2] ON [dbo].[ProviderOpenTaskAcceptLog]
GO




CREATE NONCLUSTERED INDEX [IX_ProviderOpenTaskAcceptLog_2] ON [dbo].[ProviderOpenTaskAcceptLog]
(
	[ProviderId] ASC,
	[RequestProviderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO










---------------------------------------------------------------End Index------------------------------------------------------------------
