
/****** Object:  Table [dbo].[EvalQuestion]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EvalQuestion]') AND type in (N'U'))
Begin
	/*
alter table [EvalQuestionY] drop constraint [FK_EvalQuestionY_EvalQuestion]
alter table [InterviewEval] drop constraint [FK_InterviewEval_EvalQuestion]
alter table [InterviewEvalByInterviewee] drop constraint [FK_InterviewEvalByInterviewee_EvalQuestion]
alter table [RequestEval] drop constraint [FK_RequestEval_EvalQuestion]
alter table [RequestEvalByProvider] drop constraint [FK_RequestEvalByProvider_EvalQuestion]

	DROP TABLE [dbo].[EvalQuestion]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'EvalQuestion')
	)
	

	declare @TblName as nvarchar(64) = 'EvalQuestion'
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
	print 'you need to manually exec DROP TABLE [dbo].[EvalQuestion] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[EvalQuestion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ToType] [nvarchar](32) NOT NULL,	-- Person, Provider, Interviewer, Interviwee
	[QuestionSetNumber] [int] NOT NULL,	-- For each Type, only one QuestionSet is available. The maximum of [QuestionSetNumber] is the current available QuestionSet.
	[QuestionNumber] [int] NOT NULL,
	[Question] [nvarchar](max) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_EvalQuestion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



-------------------------- Begin Foreign Key ---------------------------------------------------------------


-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EvalQuestion]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EvalQuestionY]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_EvalQuestionY_EvalQuestion]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[EvalQuestionY]  WITH CHECK ADD  CONSTRAINT [FK_EvalQuestionY_EvalQuestion] FOREIGN KEY([EvalQuestionId])
	REFERENCES [dbo].[EvalQuestion] ([Id])

	ALTER TABLE [dbo].[EvalQuestionY] CHECK CONSTRAINT [FK_EvalQuestionY_EvalQuestion]
end



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EvalQuestion]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewEval]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_InterviewEval_EvalQuestion]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[InterviewEval]  WITH CHECK ADD  CONSTRAINT [FK_InterviewEval_EvalQuestion] FOREIGN KEY([EvalQuestionId])
	REFERENCES [dbo].[EvalQuestion] ([Id])

	ALTER TABLE [dbo].[InterviewEval] CHECK CONSTRAINT [FK_InterviewEval_EvalQuestion]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EvalQuestion]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewEvalByInterviewee]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_InterviewEvalByInterviewee_EvalQuestion]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[InterviewEvalByInterviewee]  WITH CHECK ADD  CONSTRAINT [FK_InterviewEvalByInterviewee_EvalQuestion] FOREIGN KEY([EvalQuestionId])
	REFERENCES [dbo].[EvalQuestion] ([Id])

	ALTER TABLE [dbo].[InterviewEvalByInterviewee] CHECK CONSTRAINT [FK_InterviewEvalByInterviewee_EvalQuestion]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EvalQuestion]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestEval]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestEval_EvalQuestion]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestEval]  WITH CHECK ADD  CONSTRAINT [FK_RequestEval_EvalQuestion] FOREIGN KEY([EvalQuestionId])
	REFERENCES [dbo].[EvalQuestion] ([Id])

	ALTER TABLE [dbo].[RequestEval] CHECK CONSTRAINT [FK_RequestEval_EvalQuestion]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EvalQuestion]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestEvalByProvider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestEvalByProvider_EvalQuestion]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestEvalByProvider]  WITH CHECK ADD  CONSTRAINT [FK_RequestEvalByProvider_EvalQuestion] FOREIGN KEY([EvalQuestionId])
	REFERENCES [dbo].[EvalQuestion] ([Id])

	ALTER TABLE [dbo].[RequestEvalByProvider] CHECK CONSTRAINT [FK_RequestEvalByProvider_EvalQuestion]
end

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [EvalQuestion]
end

GO

SET ANSI_PADDING OFF
GO

GO




---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())



/****** Object:  Index [IX_EvalQuestion_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EvalQuestion]') AND name = N'IX_EvalQuestion_1')
DROP INDEX [IX_EvalQuestion_1] ON [dbo].[EvalQuestion]
GO




/****** Object:  Index [IX_EvalQuestion_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_EvalQuestion_1] ON [dbo].[EvalQuestion]
(
	[ToType] ASC,
	[QuestionSetNumber] ASC,
	[QuestionNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------
