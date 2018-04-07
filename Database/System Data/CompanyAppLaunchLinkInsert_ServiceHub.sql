
declare @pTime datetime = getutcdate()
declare @pApplicationTypeCodeId int = 0
declare @pDeviceTypeCodeId int = 0
declare @pLink nvarchar(128) = ''
Declare @Id int = 0
declare @pCompanyCode nvarchar(64) = 'ServiceHub'
declare @pCompanyId int = 0
select @pCompanyId = a.Id
from WEYIMgr.dbo.Company a (nolock)
where a.CompanyCode = @pCompanyCode

if(@pCompanyId > 0)
begin
	delete 
	from CompanyAppLaunchLink 
	where CompanyId = @pCompanyId
	insert into CompanyAppLaunchLink
	(
		[CompanyId],
		[ApplicationTypeCodeId],
		[DeviceTypeCodeId],
		[LaunchLink],
		[CreateDate],
		[LastUpdate]
	)
	select @pCompanyId, 1, 1, 'servicehubapp://www.weyi.co', @pTime, @pTime
	Union
	select @pCompanyId, 1, 2,	'servicehubapp://www.weyi.co', @pTime, @pTime
	Union
	select @pCompanyId, 1, 5,	'https://www.weyivideo.com/Client/?Company=ServiceHub', @pTime, @pTime
	Union
	select @pCompanyId, 2, 1,	'servicehubproviderapp://www.weyi.co', @pTime, @pTime
	Union
	select @pCompanyId, 2, 2,	'servicehubproviderapp://www.weyi.co', @pTime, @pTime
	Union
	select @pCompanyId, 2, 5,	'https://www.weyivideo.com/Provider/?Company=ServiceHub', @pTime, @pTime
end

select * from CompanyAppLaunchLink where CompanyId = @pCompanyId
