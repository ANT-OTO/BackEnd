
/****** Object:  Table [dbo].[Provider]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
Begin
	/*
	

alter table [Interview] drop constraint [FK_Interview_Interviewer]
alter table [InterviewProvider] drop constraint [FK_InterviewProvider_Provider]
alter table [ProviderBilling] drop constraint [FK_ProviderBilling_Provider]
alter table [ProviderBusinessDay] drop constraint [FK_ProviderBusinessDay_Provider]
alter table [ProviderBusinessHour] drop constraint [FK_ProviderBusinessHour_Provider]
alter table [ProviderDevice] drop constraint [FK_ProviderDevice_Provider]
alter table [ProviderFeedback] drop constraint [FK_ProviderFeedback_Provider]
alter table [ProviderInterviewTime] drop constraint [FK_ProviderInterviewTime_Provider]
alter table [ProviderLanguage] drop constraint [FK_ProviderLanguage_Provider]
alter table [ProviderNonBusinessDay] drop constraint [FK_ProviderNonBusinessDay_Provider]
alter table [ProviderPayment] drop constraint [FK_ProviderPayment_Provider]
alter table [ProviderPicture] drop constraint [FK_ProviderPicture_Provider]
alter table [ProviderProperty] drop constraint [FK_ProviderProperty_Provider]
alter table [ProviderSchedule] drop constraint [FK_ProviderSchedule_Provider]
alter table [ProviderService] drop constraint [FK_ProviderService_Provider]
alter table [RequestEvalByProvider] drop constraint [FK_RequestEvalByProvider_Provider]
alter table [RequestProvider] drop constraint [FK_RequestProvider_Provider]

	DROP TABLE [dbo].[Provider]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'Provider')
	)	
	
	declare @TblName as nvarchar(64) = 'Provider'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[Provider] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[Provider](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](128) NOT NULL,
	[RegionId] int NOT NULL,
	[MobilePhone] [varchar](32) NOT NULL,
	[Pwd] [nvarchar](128) NOT NULL,
	
	[PromoCode] [nvarchar](16) NOT NULL,
	
	[AdditionalInfo] [nvarchar](max) NOT NULL,
	
	[Available] [bit] NOT NULL,
	
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_Provider] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[Provider] ADD  CONSTRAINT [DF_Provider_AdditionalInfo]  DEFAULT ('') FOR [AdditionalInfo]

ALTER TABLE [dbo].[Provider] ADD  CONSTRAINT [DF_Provider_Available]  DEFAULT (1) FOR [Available]

--ALTER TABLE [dbo].[Provider] ADD  CONSTRAINT [DF_Provider_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]

--ALTER TABLE [dbo].[Provider] ADD  CONSTRAINT [DF_Provider_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Region]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_Provider_Region]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[Provider]  WITH CHECK ADD  CONSTRAINT [FK_Provider_Region] FOREIGN KEY([RegionId])
	REFERENCES [dbo].[Region] ([Id])

	ALTER TABLE [dbo].[Provider] CHECK CONSTRAINT [FK_Provider_Region]
end

-------------------------- End Foreign Key ---------------------------------------------------------------


--------------------------------------------------- Begin Primary Key Referenced by other tables -------------------------------------------



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Interview]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_Interview_Interviewer]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[Interview]  WITH CHECK ADD  CONSTRAINT [FK_Interview_Interviewer] FOREIGN KEY([InterviewerId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[Interview] CHECK CONSTRAINT [FK_Interview_Interviewer]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InterviewProvider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_InterviewProvider_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[InterviewProvider]  WITH CHECK ADD  CONSTRAINT [FK_InterviewProvider_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[InterviewProvider] CHECK CONSTRAINT [FK_InterviewProvider_Provider]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderBilling]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderBilling_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderBilling]  WITH CHECK ADD  CONSTRAINT [FK_ProviderBilling_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ProviderBilling] CHECK CONSTRAINT [FK_ProviderBilling_Provider]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderBusinessDay]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderBusinessDay_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderBusinessDay]  WITH CHECK ADD  CONSTRAINT [FK_ProviderBusinessDay_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ProviderBusinessDay] CHECK CONSTRAINT [FK_ProviderBusinessDay_Provider]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderBusinessHour]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderBusinessHour_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderBusinessHour]  WITH CHECK ADD  CONSTRAINT [FK_ProviderBusinessHour_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ProviderBusinessHour] CHECK CONSTRAINT [FK_ProviderBusinessHour_Provider]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderDevice]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderDevice_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderDevice]  WITH CHECK ADD  CONSTRAINT [FK_ProviderDevice_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ProviderDevice] CHECK CONSTRAINT [FK_ProviderDevice_Provider]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderFeedback]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderFeedback_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderFeedback]  WITH CHECK ADD  CONSTRAINT [FK_ProviderFeedback_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ProviderFeedback] CHECK CONSTRAINT [FK_ProviderFeedback_Provider]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderInterviewTime]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderInterviewTime_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderInterviewTime]  WITH CHECK ADD  CONSTRAINT [FK_ProviderInterviewTime_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ProviderInterviewTime] CHECK CONSTRAINT [FK_ProviderInterviewTime_Provider]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderLanguage]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderLanguage_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderLanguage]  WITH CHECK ADD  CONSTRAINT [FK_ProviderLanguage_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ProviderLanguage] CHECK CONSTRAINT [FK_ProviderLanguage_Provider]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderNonBusinessDay]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderNonBusinessDay_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderNonBusinessDay]  WITH CHECK ADD  CONSTRAINT [FK_ProviderNonBusinessDay_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ProviderNonBusinessDay] CHECK CONSTRAINT [FK_ProviderNonBusinessDay_Provider]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderPayment]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderPayment_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderPayment]  WITH CHECK ADD  CONSTRAINT [FK_ProviderPayment_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ProviderPayment] CHECK CONSTRAINT [FK_ProviderPayment_Provider]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderPicture]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderPicture_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderPicture]  WITH CHECK ADD  CONSTRAINT [FK_ProviderPicture_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ProviderPicture] CHECK CONSTRAINT [FK_ProviderPicture_Provider]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderProperty]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderProperty_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderProperty]  WITH CHECK ADD  CONSTRAINT [FK_ProviderProperty_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ProviderProperty] CHECK CONSTRAINT [FK_ProviderProperty_Provider]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderSchedule]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderSchedule_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderSchedule]  WITH CHECK ADD  CONSTRAINT [FK_ProviderSchedule_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ProviderSchedule] CHECK CONSTRAINT [FK_ProviderSchedule_Provider]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderService]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderService_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderService]  WITH CHECK ADD  CONSTRAINT [FK_ProviderService_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[ProviderService] CHECK CONSTRAINT [FK_ProviderService_Provider]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestEvalByProvider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestEvalByProvider_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestEvalByProvider]  WITH CHECK ADD  CONSTRAINT [FK_RequestEvalByProvider_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[RequestEvalByProvider] CHECK CONSTRAINT [FK_RequestEvalByProvider_Provider]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RequestProvider]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_RequestProvider_Provider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[RequestProvider]  WITH CHECK ADD  CONSTRAINT [FK_RequestProvider_Provider] FOREIGN KEY([ProviderId])
	REFERENCES [dbo].[Provider] ([Id])

	ALTER TABLE [dbo].[RequestProvider] CHECK CONSTRAINT [FK_RequestProvider_Provider]
end

--------------------------------------------------- End Primary Key Referenced by other tables -------------------------------------------

select * from Provider
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_Provider_Email]    Script Date: 01/16/2015 11:52:42 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND name = N'IX_Provider_Email')
DROP INDEX [IX_Provider_Email] ON [dbo].[Provider] WITH ( ONLINE = OFF )
GO


/****** Object:  Index [IX_Provider_Email]    Script Date: 01/16/2015 11:52:37 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Provider_Email] ON [dbo].[Provider] 
(
	[Email] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


--------------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Provider]') AND name = N'IX_Provider_MobilePhone')
DROP INDEX [IX_Provider_MobilePhone] ON [dbo].[Provider] WITH ( ONLINE = OFF )
GO


/****** Object:  Index [IX_Provider_MobilePhone]    Script Date: 1/30/2015 5:08:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_Provider_MobilePhone] ON [dbo].[Provider]
(
	[RegionId] ASC,
	[MobilePhone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


---------------------------------------------------------------End Index------------------------------------------------------------------
