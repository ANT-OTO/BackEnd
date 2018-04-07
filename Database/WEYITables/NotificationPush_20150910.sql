
IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'PushEngineId' AND Object_ID = Object_ID(N'NotificationPush'))
begin
	ALTER TABLE [NotificationPush] ADD [PushEngineId] int NULL
end


IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'MsgTypeCodeId' AND Object_ID = Object_ID(N'NotificationPush'))
begin
	ALTER TABLE [NotificationPush] ADD [MsgTypeCodeId] int NULL
end