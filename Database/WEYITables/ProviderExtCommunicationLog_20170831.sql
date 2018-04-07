
if not exists(select * from sys.columns 
            where Name = N'RequestProviderId' and Object_ID = Object_ID(N'ProviderExtCommunicationLog'))
begin
	ALTER TABLE ProviderExtCommunicationLog
	ADD  RequestProviderId int NULL
end

select top 100 * from ProviderExtCommunicationLog order by Id desc

go
