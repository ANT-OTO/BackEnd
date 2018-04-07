IF NOT EXISTS(
    SELECT *
    FROM sys.columns
    WHERE Name      = N'QualityLevelCodeId'
      AND Object_ID = Object_ID(N'WEYI.dbo.ProviderService'))
BEGIN
    -- Column NOT Exists
	ALTER TABLE WEYI.dbo.ProviderService
	ADD QualityLevelCodeId int NULL
	DEFAULT NULL
END

--select * from DownloadReport

-- Set default level for every provider in company
update ProviderService
set QualityLevelCodeId = 1
where ProviderId in(
	select ProviderId
	from WEYIMgr.dbo.LSPProvider
)
and (QualityLevelCodeId <> 1 or QualityLevelCodeId is null)

select * from ProviderService
