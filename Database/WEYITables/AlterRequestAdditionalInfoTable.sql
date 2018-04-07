IF NOT EXISTS(
    SELECT *
    FROM sys.columns
    WHERE Name      = N'RequestRelatedVersionCode'
      AND Object_ID = Object_ID(N'WEYI.dbo.RequestAdditionalInfo'))
BEGIN
    -- Column NOT Exists
	ALTER TABLE WEYI.dbo.RequestAdditionalInfo
	ADD RequestRelatedVersionCode nvarchar(32) NULL
	DEFAULT NULL

END

IF NOT EXISTS(
    SELECT *
    FROM sys.columns
    WHERE Name      = N'ApplicationCompanyCode'
      AND Object_ID = Object_ID(N'WEYI.dbo.RequestAdditionalInfo'))
BEGIN
    -- Column NOT Exists
	ALTER TABLE WEYI.dbo.RequestAdditionalInfo
	ADD ApplicationCompanyCode nvarchar(32) NULL
	DEFAULT NULL

END

IF NOT EXISTS(
    SELECT *
    FROM sys.columns
    WHERE Name      = N'DeviceTypeCodeId'
      AND Object_ID = Object_ID(N'WEYI.dbo.RequestAdditionalInfo'))
BEGIN
    -- Column NOT Exists
	ALTER TABLE WEYI.dbo.RequestAdditionalInfo
	ADD DeviceTypeCodeId int NULL
	DEFAULT NULL

END

IF NOT EXISTS(
    SELECT *
    FROM sys.columns
    WHERE Name      = N'ApplicationTypeCodeId'
      AND Object_ID = Object_ID(N'WEYI.dbo.RequestAdditionalInfo'))
BEGIN
    -- Column NOT Exists
	ALTER TABLE WEYI.dbo.RequestAdditionalInfo
	ADD ApplicationTypeCodeId int NULL
	DEFAULT NULL

END

SELECT * FROM RequestAdditionalInfo
