IF NOT EXISTS(
    SELECT *
    FROM sys.columns
    WHERE Name      = N'DownloadHostIP'
      AND Object_ID = Object_ID(N'WEYI.dbo.DownloadReport'))
BEGIN
    -- Column NOT Exists
	ALTER TABLE WEYI.dbo.DownloadReport
	ADD DownloadHostIP nvarchar(64) NULL
	DEFAULT NULL
END

--select * from DownloadReport

