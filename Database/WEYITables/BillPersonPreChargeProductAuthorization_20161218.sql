
IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'AuthorizationStatusCodeId' AND Object_ID = Object_ID(N'BillPersonPreChargeProductAuthorization'))
begin
	ALTER TABLE [BillPersonPreChargeProductAuthorization] ADD [AuthorizationStatusCodeId] int NULL
end


select * from [BillPersonPreChargeProductAuthorization]

go

