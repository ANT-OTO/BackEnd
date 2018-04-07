
/****** Object:  Table [dbo].[InterviewFeedback]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewFeedback]') AND type in (N'U'))
Begin
	/*
	
	DROP TABLE [dbo].[InterviewFeedback]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'InterviewFeedback')
	)	
	

	declare @TblName as nvarchar(64) = 'InterviewFeedback'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[InterviewFeedback] ' + convert(varchar, getdate())
	
End
else
begin
--drop table [dbo].[InterviewFeedback]

CREATE TABLE [dbo].[InterviewFeedback](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	
	[InterviewId] [int] NOT NULL,
	[InterviewerId] [int] NULL,
	[CandidateId] [int] NULL,
	[Feedback] nvarchar(max) NOT NULL,			
		
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_InterviewFeedback] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[InterviewFeedback] ADD  CONSTRAINT [DF_InterviewFeedback_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]

-------------------------- Begin Foreign Key ---------------------------------------------------------------



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Interview]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewFeedback]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_InterviewFeedback_Interview]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[InterviewFeedback]  WITH CHECK ADD  CONSTRAINT [FK_InterviewFeedback_Interview] FOREIGN KEY([InterviewId])
	REFERENCES [dbo].[Interview] ([Id])

	ALTER TABLE [dbo].[InterviewFeedback] CHECK CONSTRAINT [FK_InterviewFeedback_Interview]
end



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewFeedback]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_InterviewFeedback_Interviewer]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[InterviewFeedback]  WITH CHECK ADD  CONSTRAINT [FK_InterviewFeedback_Interviewer] FOREIGN KEY([CandidateId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[InterviewFeedback] CHECK CONSTRAINT [FK_InterviewFeedback_Interviewer]
end


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewFeedback]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_InterviewFeedback_Candidate]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[InterviewFeedback]  WITH CHECK ADD  CONSTRAINT [FK_InterviewFeedback_Candidate] FOREIGN KEY([InterviewerId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[InterviewFeedback] CHECK CONSTRAINT [FK_InterviewFeedback_Candidate]
end



-------------------------- End Foreign Key ---------------------------------------------------------------


select * from [InterviewFeedback]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_InterviewFeedback_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[InterviewFeedback]') AND name = N'IX_InterviewFeedback_1')
DROP INDEX [IX_InterviewFeedback_1] ON [dbo].[InterviewFeedback]
GO




/****** Object:  Index [IX_InterviewFeedback_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_InterviewFeedback_1] ON [dbo].[InterviewFeedback]
(
	[InterviewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
