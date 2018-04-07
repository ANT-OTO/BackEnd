IF NOT EXISTS(
    SELECT *
    FROM sys.columns
    WHERE Name      = N'Name'
      AND Object_ID = Object_ID(N'WEYI.dbo.VideoParticipant'))
BEGIN
    -- Column NOT Exists
	ALTER TABLE WEYI.dbo.VideoParticipant
	ADD Name nvarchar(64) NULL
	DEFAULT NULL
END

--select * from VideoParticipant

