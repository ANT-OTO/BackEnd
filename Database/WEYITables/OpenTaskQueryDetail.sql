
/****** Object:  Table [dbo].[OpenTaskQueryDetail]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenTaskQueryDetail]') AND type in (N'U'))
Begin
	/*
	
alter table [OpenTaskQueryDetailProperty] drop constraint [FK_OpenTaskQueryDetailProperty_OpenTaskQueryDetail]

	DROP TABLE [dbo].[OpenTaskQueryDetail]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'OpenTaskQueryDetail')
	)	
	
	
	declare @TblName as nvarchar(64) = 'OpenTaskQueryDetail'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[OpenTaskQueryDetail] ' + convert(varchar, getdate())
	
End
else
begin

-- This table is the new way (created on 11/25/2015) to manage OpenTaskQueryDetail.

CREATE TABLE [dbo].[OpenTaskQueryDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OpenTaskQueryId] int NOT NULL,

	[RequestProviderId] [int] NULL,				-- Service Request from Person. The provider is the service provider
	[InterviewProviderId] [int] NULL,			-- Interview task from Interviewer. The provider is the interview candidate.
	[InterviewId] [int] NULL,					-- Interview task to Candidate. The provider is the Interviewer.
	[DPTProviderId] [int] NULL,					-- DPT from Person. The provider is the service provider.
	
	[OpenTaskTypeCodeId] int NOT NULL,			-- select * from CodeList where Category = 'OpenTaskType'
	[OpenTaskStatusCodeId] int NOT NULL,		-- select * from CodeList where Category = 'OpenTaskStatus'

	[OtherPartyName] nvarchar(128) NULL,		-- Depending on the type of Task, the other party could be Person, or Provider
	[FromLanguageId] int NOT NULL,
	[ToLanguageId] int NOT NULL,

	[TaskAdditionalInfo] nvarchar(max) NULL,
	
	[Price] decimal(10, 2) NULL,				-- The price quote to be paid to the provider

	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_OpenTaskQueryDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[OpenTaskQueryDetail] ADD  CONSTRAINT [DF_OpenTaskQueryDetail_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenTaskQueryDetail]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenTaskQueryDetailProperty]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_OpenTaskQueryDetailProperty_OpenTaskQueryDetail]') AND type in (N'F'))
begin

	--print 'ALTER TABLE [dbo].[OpenTaskQueryDetailProperty]  WITH CHECK ADD  CONSTRAINT [FK_OpenTaskQueryDetailProperty_OpenTaskQueryDetail] FOREIGN KEY([OpenTaskQueryDetailId])'

	ALTER TABLE [dbo].[OpenTaskQueryDetailProperty]  WITH CHECK ADD  CONSTRAINT [FK_OpenTaskQueryDetailProperty_OpenTaskQueryDetail] FOREIGN KEY([OpenTaskQueryDetailId])
	REFERENCES [dbo].[OpenTaskQueryDetail] ([Id])

	ALTER TABLE [dbo].[OpenTaskQueryDetailProperty] CHECK CONSTRAINT [FK_OpenTaskQueryDetailProperty_OpenTaskQueryDetail]
end



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestProvider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenTaskQueryDetail]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_OpenTaskQueryDetail_RequestProviderId]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[OpenTaskQueryDetail]  WITH CHECK ADD  CONSTRAINT [FK_OpenTaskQueryDetail_RequestProviderId] FOREIGN KEY([RequestProviderId])
	REFERENCES [dbo].[RequestProvider] ([Id])

	ALTER TABLE [dbo].[OpenTaskQueryDetail] CHECK CONSTRAINT [FK_OpenTaskQueryDetail_RequestProviderId]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewProvider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenTaskQueryDetail]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_OpenTaskQueryDetail_InterviewProviderId]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[OpenTaskQueryDetail]  WITH CHECK ADD  CONSTRAINT [FK_OpenTaskQueryDetail_InterviewProviderId] FOREIGN KEY([InterviewProviderId])
	REFERENCES [dbo].[InterviewProvider] ([Id])

	ALTER TABLE [dbo].[OpenTaskQueryDetail] CHECK CONSTRAINT [FK_OpenTaskQueryDetail_InterviewProviderId]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Interview]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenTaskQueryDetail]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_OpenTaskQueryDetail_InterviewId]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[OpenTaskQueryDetail]  WITH CHECK ADD  CONSTRAINT [FK_OpenTaskQueryDetail_InterviewId] FOREIGN KEY([InterviewId])
	REFERENCES [dbo].[Interview] ([Id])

	ALTER TABLE [dbo].[OpenTaskQueryDetail] CHECK CONSTRAINT [FK_OpenTaskQueryDetail_InterviewId]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTProvider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenTaskQueryDetail]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_OpenTaskQueryDetail_DPTProviderId]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[OpenTaskQueryDetail]  WITH CHECK ADD  CONSTRAINT [FK_OpenTaskQueryDetail_DPTProviderId] FOREIGN KEY([DPTProviderId])
	REFERENCES [dbo].[DPTProvider] ([Id])

	ALTER TABLE [dbo].[OpenTaskQueryDetail] CHECK CONSTRAINT [FK_OpenTaskQueryDetail_DPTProviderId]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lauguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenTaskQueryDetail]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_OpenTaskQueryDetail_Lauguage1]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[OpenTaskQueryDetail]  WITH CHECK ADD  CONSTRAINT [FK_OpenTaskQueryDetail_Lauguage1] FOREIGN KEY([FromLanguageId])
	REFERENCES [dbo].[Lauguage] ([Id])

	ALTER TABLE [dbo].[OpenTaskQueryDetail] CHECK CONSTRAINT [FK_OpenTaskQueryDetail_Lauguage1]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lauguage]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenTaskQueryDetail]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_OpenTaskQueryDetail_Lauguage2]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[OpenTaskQueryDetail]  WITH CHECK ADD  CONSTRAINT [FK_OpenTaskQueryDetail_Lauguage2] FOREIGN KEY([ToLanguageId])
	REFERENCES [dbo].[Lauguage] ([Id])

	ALTER TABLE [dbo].[OpenTaskQueryDetail] CHECK CONSTRAINT [FK_OpenTaskQueryDetail_Lauguage2]
end


-------------------------- End Foreign Key ---------------------------------------------------------------

-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenTaskQueryDetail]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenTaskQueryDetailProperty]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_OpenTaskQueryDetailProperty_OpenTaskQueryDetail]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[OpenTaskQueryDetailProperty]  WITH CHECK ADD  CONSTRAINT [FK_OpenTaskQueryDetailProperty_OpenTaskQueryDetail] FOREIGN KEY([OpenTaskQueryDetailId])
	REFERENCES [dbo].[OpenTaskQueryDetail] ([Id])

	ALTER TABLE [dbo].[OpenTaskQueryDetailProperty] CHECK CONSTRAINT [FK_OpenTaskQueryDetailProperty_OpenTaskQueryDetail]
end

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [OpenTaskQueryDetail]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_OpenTaskQueryDetail_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OpenTaskQueryDetail]') AND name = N'IX_OpenTaskQueryDetail_1')
DROP INDEX [IX_OpenTaskQueryDetail_1] ON [dbo].[OpenTaskQueryDetail]
GO




/****** Object:  Index [IX_OpenTaskQueryDetail_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_OpenTaskQueryDetail_1] ON [dbo].[OpenTaskQueryDetail]
(
	[OpenTaskQueryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
