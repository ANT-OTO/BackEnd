declare @pEnabled nvarchar(32) = 'Y'
declare @pDBServerPropertyId int = 0

exec WEYI.[dbo].[sp_DBServerProperty_Set] 'AudioConnection','DownloadEnabled',@pEnabled, @pDBServerPropertyId OUTPUT

SELECT * FROM DBServerProperty