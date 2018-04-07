IF NOT EXISTS(
    SELECT *
    FROM sys.columns
    WHERE Name      = N'ScheduledRequestProviderId'
      AND Object_ID = Object_ID(N'WEYI.dbo.OpenTaskQueryDetail'))
BEGIN
    -- Column NOT Exists
	ALTER TABLE WEYI.dbo.OpenTaskQueryDetail
	ADD ScheduledRequestProviderId int NULL
	DEFAULT NULL
END

select * from OpenTaskQueryDetail

