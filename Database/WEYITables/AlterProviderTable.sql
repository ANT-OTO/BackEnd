IF NOT EXISTS(
    SELECT *
    FROM sys.columns
    WHERE Name      = N'ProviderSpecialTypeCodeId'
      AND Object_ID = Object_ID(N'WEYI.dbo.Provider'))
BEGIN
    -- Column NOT Exists
	ALTER TABLE WEYI.dbo.Provider
	ADD ProviderSpecialTypeCodeId int NULL
	DEFAULT NULL
END

go


--select * from DownloadReport
-- select * from CodeList where Category = 'ProviderSpecialType' order by SortOrder
-- Set default level for every provider in company
update Provider
set ProviderSpecialTypeCodeId = 1
where Id in(
	select ProviderId
	from WEYIMgr.dbo.LSPProvider
)
and (ProviderSpecialTypeCodeId <> 1 or ProviderSpecialTypeCodeId is null)

select * from Provider

