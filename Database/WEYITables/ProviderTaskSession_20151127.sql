
if not exists(select * from sys.columns 
            where Name = N'DPTProviderId' and Object_ID = Object_ID(N'ProviderTaskSession'))
begin
	ALTER TABLE ProviderTaskSession
	ADD DPTProviderId int NULL
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DPTProvider]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProviderTaskSession]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProviderTaskSession_DPTProvider]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[ProviderTaskSession]  WITH CHECK ADD  CONSTRAINT [FK_ProviderTaskSession_DPTProvider] FOREIGN KEY([DPTProviderId])
	REFERENCES [dbo].[DPTProvider] ([Id])

	ALTER TABLE [dbo].[ProviderTaskSession] CHECK CONSTRAINT [FK_ProviderTaskSession_DPTProvider]
end

select top 10 * from ProviderTaskSession