
IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'BillCompanyProductId' AND Object_ID = Object_ID(N'RequestProvider'))
begin
	ALTER TABLE [RequestProvider] ADD BillCompanyProductId int NULL
end

IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'PayRate' AND Object_ID = Object_ID(N'RequestProvider'))
begin
	ALTER TABLE [RequestProvider] ADD PayRate decimal(9, 2) NULL
end

IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'PayMinMinute' AND Object_ID = Object_ID(N'RequestProvider'))
begin
	ALTER TABLE [RequestProvider] ADD PayMinMinute int NULL
end


IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'ExtBillCompanyProductId' AND Object_ID = Object_ID(N'RequestProvider'))
begin
	ALTER TABLE [RequestProvider] ADD ExtBillCompanyProductId int NULL
end

IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'Rate' AND Object_ID = Object_ID(N'RequestProvider'))
begin
	ALTER TABLE [RequestProvider] ADD Rate decimal(9, 2) NULL
end

IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'MinMinute' AND Object_ID = Object_ID(N'RequestProvider'))
begin
	ALTER TABLE [RequestProvider] ADD MinMinute int NULL
end

go


