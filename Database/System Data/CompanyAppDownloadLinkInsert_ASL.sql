
-- Company Client App Block
declare @pTime datetime = getutcdate()
declare @pCompanyCode nvarchar(64) = '',
		@pApplicationTypeCodeId int = 0,
		@pDeviceTypeCodeId int = 0,
		@pDownLoadLink nvarchar(256) = '',
		@pLastestVersion nvarchar(128) = '',
		@pCompanyId int = 0
select @pCompanyCode = 'ASL',
		@pApplicationTypeCodeId = 1,
		@pDeviceTypeCodeId = 1,
		@pDownLoadLink = 'https://itunes.apple.com/us/app/aslsinc-vri/id1217067202?mt=8',
		@pLastestVersion = '3.0'
select @pCompanyId = Id
from WEYIMgr.dbo.Company (nolock)
where CompanyCode = @pCompanyCode
if(isnull(@pCompanyId , 0) > 0)
begin
	insert into [dbo].[CompanyAppDownLoadLink]
	(
		[CompanyId],
		[ApplicationTypeCodeId],
		[DeviceTypeCodeId],
		[DownLoadLink],
		[LatestVersion],
		[CreateDate],
		[LastUpdate]
	)
	select a.CompanyId,
		   a.ApplicationTypeCodeId,
		   a.DeviceTypeCodeId,
		   a.DownLoadLink,
		   a.LastestVersion,
		   a.CreateDate,
		   a.LastUpdate
	from ( 
			select @pCompanyId as CompanyId,
				  @pApplicationTypeCodeId as ApplicationTypeCodeId,
				  @pDeviceTypeCodeId as DeviceTypeCodeId,
				  @pDownLoadLink as DownLoadLink,
				  @pLastestVersion as LastestVersion,
				  @pTime as CreateDate,
				  @pTime as LastUpdate
	) a
	left join WEYI.dbo.CompanyAppDownLoadLink z on z.CompanyId = a.CompanyId and z.ApplicationTypeCodeId = a.ApplicationTypeCodeId and z.DeviceTypeCodeId = a.DeviceTypeCodeId
	where z.Id is null

	if(@@ROWCOUNT = 0)
	begin
		update WEYI.dbo.CompanyAppDownLoadLink
		set DownLoadLink = @pDownLoadLink,
			LatestVersion = @pLastestVersion,
			LastUpdate = @pTime
		where CompanyId = @pCompanyId 
			and ApplicationTypeCodeId = @pApplicationTypeCodeId 
			and DeviceTypeCodeId = @pDeviceTypeCodeId
	end
end

GO 

-- Company Provider App Block
declare @pTime datetime = getutcdate()
declare @pCompanyCode nvarchar(64) = '',
		@pApplicationTypeCodeId int = 0,
		@pDeviceTypeCodeId int = 0,
		@pDownLoadLink nvarchar(256) = '',
		@pLastestVersion nvarchar(128) = '',
		@pCompanyId int = 0
select @pCompanyCode = 'ASL',
		@pApplicationTypeCodeId = 2, --select * from CodeList where Category = 'ApplicationType' 
		@pDeviceTypeCodeId = 1,
		@pDownLoadLink = 'https://itunes.apple.com/us/app/asl-provider/id1217069152?mt=8',
		@pLastestVersion = '2.0'
select @pCompanyId = Id
from WEYIMgr.dbo.Company (nolock)
where CompanyCode = @pCompanyCode
if(isnull(@pCompanyId, 0) > 0)
begin
	insert into [dbo].[CompanyAppDownLoadLink]
	(
		[CompanyId],
		[ApplicationTypeCodeId],
		[DeviceTypeCodeId],
		[DownLoadLink],
		[LatestVersion],
		[CreateDate],
		[LastUpdate]
	)
	select a.CompanyId,
		   a.ApplicationTypeCodeId,
		   a.DeviceTypeCodeId,
		   a.DownLoadLink,
		   a.LastestVersion,
		   a.CreateDate,
		   a.LastUpdate
	from ( 
			select @pCompanyId as CompanyId,
				  @pApplicationTypeCodeId as ApplicationTypeCodeId,
				  @pDeviceTypeCodeId as DeviceTypeCodeId,
				  @pDownLoadLink as DownLoadLink,
				  @pLastestVersion as LastestVersion,
				  @pTime as CreateDate,
				  @pTime as LastUpdate
	) a
	left join WEYI.dbo.CompanyAppDownLoadLink z on z.CompanyId = a.CompanyId and z.ApplicationTypeCodeId = a.ApplicationTypeCodeId and z.DeviceTypeCodeId = a.DeviceTypeCodeId
	where z.Id is null

	if(@@ROWCOUNT = 0)
	begin
		update WEYI.dbo.CompanyAppDownLoadLink
		set DownLoadLink = @pDownLoadLink,
			LatestVersion = @pLastestVersion,
			LastUpdate = @pTime
		where CompanyId = @pCompanyId 
			and ApplicationTypeCodeId = @pApplicationTypeCodeId 
			and DeviceTypeCodeId = @pDeviceTypeCodeId
	end
end
GO

-- Company Client App Block
declare @pTime datetime = getutcdate()
declare @pCompanyCode nvarchar(64) = '',
		@pApplicationTypeCodeId int = 0,
		@pDeviceTypeCodeId int = 0,
		@pDownLoadLink nvarchar(256) = '',
		@pLastestVersion nvarchar(128) = '',
		@pCompanyId int = 0
select @pCompanyCode = 'ASL',
		@pApplicationTypeCodeId = 1,
		@pDeviceTypeCodeId = 2,
		@pDownLoadLink = 'https://play.google.com/store/apps/details?id=com.weyimobile.weyiandroid.aslclient',
		@pLastestVersion = '3.0'
select @pCompanyId = Id
from WEYIMgr.dbo.Company (nolock)
where CompanyCode = @pCompanyCode
if(isnull(@pCompanyId , 0) > 0)
begin
	insert into [dbo].[CompanyAppDownLoadLink]
	(
		[CompanyId],
		[ApplicationTypeCodeId],
		[DeviceTypeCodeId],
		[DownLoadLink],
		[LatestVersion],
		[CreateDate],
		[LastUpdate]
	)
	select a.CompanyId,
		   a.ApplicationTypeCodeId,
		   a.DeviceTypeCodeId,
		   a.DownLoadLink,
		   a.LastestVersion,
		   a.CreateDate,
		   a.LastUpdate
	from ( 
			select @pCompanyId as CompanyId,
				  @pApplicationTypeCodeId as ApplicationTypeCodeId,
				  @pDeviceTypeCodeId as DeviceTypeCodeId,
				  @pDownLoadLink as DownLoadLink,
				  @pLastestVersion as LastestVersion,
				  @pTime as CreateDate,
				  @pTime as LastUpdate
	) a
	left join WEYI.dbo.CompanyAppDownLoadLink z on z.CompanyId = a.CompanyId and z.ApplicationTypeCodeId = a.ApplicationTypeCodeId and z.DeviceTypeCodeId = a.DeviceTypeCodeId
	where z.Id is null

	if(@@ROWCOUNT = 0)
	begin
		update WEYI.dbo.CompanyAppDownLoadLink
		set DownLoadLink = @pDownLoadLink,
			LatestVersion = @pLastestVersion,
			LastUpdate = @pTime
		where CompanyId = @pCompanyId 
			and ApplicationTypeCodeId = @pApplicationTypeCodeId 
			and DeviceTypeCodeId = @pDeviceTypeCodeId
	end
end

GO 

-- Company Provider App Block
declare @pTime datetime = getutcdate()
declare @pCompanyCode nvarchar(64) = '',
		@pApplicationTypeCodeId int = 0,
		@pDeviceTypeCodeId int = 0,
		@pDownLoadLink nvarchar(256) = '',
		@pLastestVersion nvarchar(128) = '',
		@pCompanyId int = 0
select @pCompanyCode = 'ASL',
		@pApplicationTypeCodeId = 2, --select * from CodeList where Category = 'ApplicationType' 
		@pDeviceTypeCodeId = 2,
		@pDownLoadLink = 'https://play.google.com/store/apps/details?id=com.weyimobile.weyiandroid.aslappprovider',
		@pLastestVersion = '2.0'
select @pCompanyId = Id
from WEYIMgr.dbo.Company (nolock)
where CompanyCode = @pCompanyCode
if(isnull(@pCompanyId, 0) > 0)
begin
	insert into [dbo].[CompanyAppDownLoadLink]
	(
		[CompanyId],
		[ApplicationTypeCodeId],
		[DeviceTypeCodeId],
		[DownLoadLink],
		[LatestVersion],
		[CreateDate],
		[LastUpdate]
	)
	select a.CompanyId,
		   a.ApplicationTypeCodeId,
		   a.DeviceTypeCodeId,
		   a.DownLoadLink,
		   a.LastestVersion,
		   a.CreateDate,
		   a.LastUpdate
	from ( 
			select @pCompanyId as CompanyId,
				  @pApplicationTypeCodeId as ApplicationTypeCodeId,
				  @pDeviceTypeCodeId as DeviceTypeCodeId,
				  @pDownLoadLink as DownLoadLink,
				  @pLastestVersion as LastestVersion,
				  @pTime as CreateDate,
				  @pTime as LastUpdate
	) a
	left join WEYI.dbo.CompanyAppDownLoadLink z on z.CompanyId = a.CompanyId and z.ApplicationTypeCodeId = a.ApplicationTypeCodeId and z.DeviceTypeCodeId = a.DeviceTypeCodeId
	where z.Id is null

	if(@@ROWCOUNT = 0)
	begin
		update WEYI.dbo.CompanyAppDownLoadLink
		set DownLoadLink = @pDownLoadLink,
			LatestVersion = @pLastestVersion,
			LastUpdate = @pTime
		where CompanyId = @pCompanyId 
			and ApplicationTypeCodeId = @pApplicationTypeCodeId 
			and DeviceTypeCodeId = @pDeviceTypeCodeId
	end
end
GO
select * from WEYI.dbo.CompanyAppDownLoadLink a (nolock)
	inner join WEYIMgr.dbo.Company b (nolock) on a.CompanyId = b.Id
	where b.CompanyCode = 'ASL'
