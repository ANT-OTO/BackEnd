
/****** Object:  Table [dbo].[Interview]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Interview]') AND type in (N'U'))
Begin
	/*
	
alter table [InterviewEval] drop constraint [FK_InterviewEval_Interview]
alter table [InterviewEvalByInterviewee] drop constraint [FK_InterviewEvalByByInterviewee_Interview]
alter table [InterviewEvalByInterviewee] drop constraint [FK_InterviewEvalByInterviewee_Interview]
alter table [InterviewPicture] drop constraint [FK_InterviewPicture_Interview]
alter table [InterviewProvider] drop constraint [FK_InterviewProvider_Interview]

	DROP TABLE [dbo].[Interview]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'Interview')
	)
	
	

	declare @TblName as nvarchar(64) = 'Interview'
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
	print 'you need to manually exec DROP TABLE [dbo].[Interview] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[Interview](
	[Id] [int] IDENTITY(1,1) NOT NULL,

	[ProviderServiceApplicationId] [int] NULL,			
	
	[InterviewerId] [int] NULL,			-- Provider who was the interviewer and performed the interview

	[InterviewStatusCodeId] [int] NOT NULL,		-- CodeList (Category; InterviewStatus): New, Accepted, In Process, Finished, Cancelled
	
	[InterviewerRate] [money] NULL,		-- Charge per hour
	[Amount] [money] NULL,				-- Total charge amount
	[InterviewerNote] nvarchar(max) NOT NULL,
	
	[TotalTime] Decimal(10, 2) NULL,			-- Total time in seconds

	--[ServiceStartTime] [datetime] NULL,
	--[ServiceEndTime] [datetime] NULL,
	--[CancelledTime] [datetime] NULL,
	
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_Interview] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Interview] ADD  CONSTRAINT [DF_Interview_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
ALTER TABLE [dbo].[Interview] ADD  CONSTRAINT [DF_Interview_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Interview]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_Interview_ProviderServiceApplication]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[Interview]  WITH CHECK ADD  CONSTRAINT [FK_Interview_ProviderServiceApplication] FOREIGN KEY([ProviderServiceApplicationId])
	REFERENCES [dbo].[ProviderServiceApplication] ([Id])

	ALTER TABLE [dbo].[Interview] CHECK CONSTRAINT [FK_Interview_ProviderServiceApplication]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Interview]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_Interview_Interviewer]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[Interview]  WITH CHECK ADD  CONSTRAINT [FK_Interview_Interviewer] FOREIGN KEY([InterviewerId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[Interview] CHECK CONSTRAINT [FK_Interview_Interviewer]
end

-------------------------- End Foreign Key ---------------------------------------------------------------


-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Interview]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewEval]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_InterviewEval_Interview]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[InterviewEval]  WITH CHECK ADD  CONSTRAINT [FK_InterviewEval_Interview] FOREIGN KEY([InterviewId])
	REFERENCES [dbo].[Interview] ([Id])

	ALTER TABLE [dbo].[InterviewEval] CHECK CONSTRAINT [FK_InterviewEval_Interview]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Interview]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewEvalByInterviewee]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_InterviewEvalByByInterviewee_Interview]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[InterviewEvalByInterviewee]  WITH CHECK ADD  CONSTRAINT [FK_InterviewEvalByByInterviewee_Interview] FOREIGN KEY([InterviewId])
	REFERENCES [dbo].[Interview] ([Id])

	ALTER TABLE [dbo].[InterviewEvalByInterviewee] CHECK CONSTRAINT [FK_InterviewEvalByByInterviewee_Interview]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Interview]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewEvalByInterviewee]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_InterviewEvalByInterviewee_Interview]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[InterviewEvalByInterviewee]  WITH CHECK ADD  CONSTRAINT [FK_InterviewEvalByInterviewee_Interview] FOREIGN KEY([InterviewId])
	REFERENCES [dbo].[Interview] ([Id])

	ALTER TABLE [dbo].[InterviewEvalByInterviewee] CHECK CONSTRAINT [FK_InterviewEvalByInterviewee_Interview]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Interview]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewPicture]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_InterviewPicture_Interview]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[InterviewPicture]  WITH CHECK ADD  CONSTRAINT [FK_InterviewPicture_Interview] FOREIGN KEY([InterviewId])
	REFERENCES [dbo].[Interview] ([Id])

	ALTER TABLE [dbo].[InterviewPicture] CHECK CONSTRAINT [FK_InterviewPicture_Interview]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Interview]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewProvider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_InterviewProvider_Interview]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[InterviewProvider]  WITH CHECK ADD  CONSTRAINT [FK_InterviewProvider_Interview] FOREIGN KEY([InterviewId])
	REFERENCES [dbo].[Interview] ([Id])

	ALTER TABLE [dbo].[InterviewProvider] CHECK CONSTRAINT [FK_InterviewProvider_Interview]
end


-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------

select * from [Interview]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_Interview_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Interview]') AND name = N'IX_Interview_1')
DROP INDEX [IX_Interview_1] ON [dbo].[Interview]
GO




/****** Object:  Index [IX_Interview_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_Interview_1] ON [dbo].[Interview]
(
	[InterviewerId] ASC,
	[InterviewStatusCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [IX_Interview_2]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Interview]') AND name = N'IX_Interview_2')
DROP INDEX [IX_Interview_2] ON [dbo].[Interview]
GO




/****** Object:  Index [IX_Interview_2]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_Interview_2] ON [dbo].[Interview]
(
	[ProviderServiceApplicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO





---------------------------------------------------------------End Index------------------------------------------------------------------
