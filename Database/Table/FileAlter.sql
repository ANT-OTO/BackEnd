IF NOT EXISTS(
    SELECT *
    FROM sys.columns
    WHERE Name      = N'MFilePublicUrl'
      AND Object_ID = Object_ID(N'ANTOTO.dbo.File'))
BEGIN
    -- Column NOT Exists
	ALTER TABLE ANTOTO.dbo.[File]
	ADD MFilePublicUrl nvarchar(512) NULL
	DEFAULT NULL
END

IF NOT EXISTS(
    SELECT *
    FROM sys.columns
    WHERE Name      = N'SFilePublicUrl'
      AND Object_ID = Object_ID(N'ANTOTO.dbo.File'))
BEGIN
    -- Column NOT Exists
	ALTER TABLE ANTOTO.dbo.[File]
	ADD SFilePublicUrl nvarchar(512) NULL
	DEFAULT NULL
END

--select * from [File]