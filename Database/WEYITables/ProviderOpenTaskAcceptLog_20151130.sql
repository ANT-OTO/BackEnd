
if not exists(select * from sys.columns 
            where Name = N'DPTProviderId' and Object_ID = Object_ID(N'ProviderOpenTaskAcceptLog'))
begin
	ALTER TABLE ProviderOpenTaskAcceptLog
	ADD DPTProviderId int NULL
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTProvider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderOpenTaskAcceptLog]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderOpenTaskAcceptLog_DPTProvider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderOpenTaskAcceptLog]  WITH CHECK ADD  CONSTRAINT [FK_ProviderOpenTaskAcceptLog_DPTProvider] FOREIGN KEY([DPTProviderId])
	REFERENCES [dbo].[DPTProvider] ([Id])

	ALTER TABLE [dbo].[ProviderOpenTaskAcceptLog] CHECK CONSTRAINT [FK_ProviderOpenTaskAcceptLog_DPTProvider]
end

select top 10 * from ProviderOpenTaskAcceptLog