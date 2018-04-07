
IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'x_amount' AND Object_ID = Object_ID(N'BillPersonTransactionPaymentAuthorizeNet'))
begin
	ALTER TABLE [BillPersonTransactionPaymentAuthorizeNet] ADD [x_amount] varchar(15) NULL
end

IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'x_account_number' AND Object_ID = Object_ID(N'BillPersonTransactionPaymentAuthorizeNet'))
begin
	ALTER TABLE [BillPersonTransactionPaymentAuthorizeNet] ADD [x_account_number] varchar(15) NULL
end

IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'x_first_name' AND Object_ID = Object_ID(N'BillPersonTransactionPaymentAuthorizeNet'))
begin
	ALTER TABLE [BillPersonTransactionPaymentAuthorizeNet] ADD [x_first_name] varchar(50) NULL
end

IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'x_last_name' AND Object_ID = Object_ID(N'BillPersonTransactionPaymentAuthorizeNet'))
begin
	ALTER TABLE [BillPersonTransactionPaymentAuthorizeNet] ADD [x_last_name] varchar(50) NULL
end

IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'x_zip' AND Object_ID = Object_ID(N'BillPersonTransactionPaymentAuthorizeNet'))
begin
	ALTER TABLE [BillPersonTransactionPaymentAuthorizeNet] ADD [x_zip] varchar(20) NULL
end

IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'x_po_num' AND Object_ID = Object_ID(N'BillPersonTransactionPaymentAuthorizeNet'))
begin
	ALTER TABLE [BillPersonTransactionPaymentAuthorizeNet] ADD [x_po_num] varchar(25) NULL
end

IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'x_MD5_Hash' AND Object_ID = Object_ID(N'BillPersonTransactionPaymentAuthorizeNet'))
begin
	ALTER TABLE [BillPersonTransactionPaymentAuthorizeNet] ADD [x_MD5_Hash] varchar(128) NULL
end


IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'x_cvv2_resp_code' AND Object_ID = Object_ID(N'BillPersonTransactionPaymentAuthorizeNet'))
begin
	ALTER TABLE [BillPersonTransactionPaymentAuthorizeNet] ADD [x_cvv2_resp_code] varchar(10) NULL
end

select * from [BillPersonTransactionPaymentAuthorizeNet]