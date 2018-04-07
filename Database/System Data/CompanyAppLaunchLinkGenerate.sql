
declare @pTime datetime = getutcdate()
declare @pApplicationTypeCodeId int = 0
declare @pDeviceTypeCodeId int = 0
declare @pLink nvarchar(128) = ''
Declare @Id int = 0
declare @pCompanyCode nvarchar(64) = 'ServiceHub'
delete from CompanyAppLaunchLink
-- select * from CodeList where Category = 'ApplicationType'
-- select * from CodeList where Category = 'DeviceType'

declare @tbl_companyId table
(
	CompanyId int
)
-- IOS CLIENT
select @pApplicationTypeCodeId = 1
select @pDeviceTypeCodeId = 1
delete from @tbl_companyId
insert into @tbl_companyId
(
	CompanyId
)
select a.Id
from WEYIMgr.dbo.Company a (nolock)
where a.Id not in
(
	select b.Id
	from WEYI.dbo.CompanyAppLaunchLink a(nolock)
		inner join WEYIMgr.dbo.Company b (nolock) on a.CompanyId = b.Id
		
	where a.ApplicationTypeCodeId = @pApplicationTypeCodeId
		and a.DeviceTypeCodeId = @pDeviceTypeCodeId
)

select @Id = 0

While (Select Count(*) From @tbl_companyId) > 0
Begin

    Select Top 1 @Id = CompanyId From @tbl_companyId
	select @pCompanyCode  = ''
	select @pCompanyCode = case when b.PropertyValue = a.CompanyCode then LOWER(a.CompanyCode) else LOWER(B.PropertyValue) END
	from WEYIMgr.dbo.Company (nolock) a
		inner join WEYIMgr.dbo.CompanyProperty b (nolock) on b.CompanyId = a.Id and PropertyType = 'Web' and PropertyName = 'StyleKey'
	where a.Id = @Id
	select @pLink = @pCompanyCode + 'app://www.weyi.co'
    insert into WEYI.dbo.CompanyAppLaunchLink 
	(
		[CompanyId],
		[ApplicationTypeCodeId],
		[DeviceTypeCodeId],
		[LaunchLink],
		[CreateDate],
		[LastUpdate]
	)
	select @Id as [CompanyId],
			@pApplicationTypeCodeId as [ApplicationTypeCodeId],
			@pDeviceTypeCodeId as [DeviceTypeCodeId],
			@pLink as [LaunchLink],
			@pTime as [CreateDate],
			@pTime as [LastUpdate]

    Delete @tbl_companyId Where CompanyId = @Id

End


-- IOS Provider
select @pApplicationTypeCodeId = 2
select @pDeviceTypeCodeId = 1
delete from @tbl_companyId
insert into @tbl_companyId
(
	CompanyId
)
select a.Id
from WEYIMgr.dbo.Company a (nolock)
where a.Id not in
(
	select b.Id
	from WEYI.dbo.CompanyAppLaunchLink a(nolock)
		inner join WEYIMgr.dbo.Company b (nolock) on a.CompanyId = b.Id
	where a.ApplicationTypeCodeId = @pApplicationTypeCodeId
		and a.DeviceTypeCodeId = @pDeviceTypeCodeId
)


select @Id = 0
While (Select Count(*) From @tbl_companyId) > 0
Begin
	
    Select Top 1 @Id = CompanyId From @tbl_companyId
	select @pCompanyCode  = ''
	select @pCompanyCode = case when b.PropertyValue = a.CompanyCode then LOWER(a.CompanyCode) else LOWER(B.PropertyValue) END
	from WEYIMgr.dbo.Company (nolock) a
		inner join WEYIMgr.dbo.CompanyProperty b (nolock) on b.CompanyId = a.Id and PropertyType = 'Web' and PropertyName = 'StyleKey'
	where a.Id = @Id
	select @pLink = @pCompanyCode + 'providerapp://www.weyi.co'
    insert into WEYI.dbo.CompanyAppLaunchLink 
	(
		[CompanyId],
		[ApplicationTypeCodeId],
		[DeviceTypeCodeId],
		[LaunchLink],
		[CreateDate],
		[LastUpdate]
	)
	select @Id as [CompanyId],
			@pApplicationTypeCodeId as [ApplicationTypeCodeId],
			@pDeviceTypeCodeId as [DeviceTypeCodeId],
			@pLink as [LaunchLink],
			@pTime as [CreateDate],
			@pTime as [LastUpdate]

    Delete @tbl_companyId Where CompanyId = @Id

End


-- Android CLIENT
select @pApplicationTypeCodeId = 1
select @pDeviceTypeCodeId = 2
delete from @tbl_companyId
insert into @tbl_companyId
(
	CompanyId
)
select a.Id
from WEYIMgr.dbo.Company a (nolock)
where a.Id not in
(
	select b.Id
	from WEYI.dbo.CompanyAppLaunchLink a(nolock)
		inner join WEYIMgr.dbo.Company b (nolock) on a.CompanyId = b.Id
	where a.ApplicationTypeCodeId = @pApplicationTypeCodeId
		and a.DeviceTypeCodeId = @pDeviceTypeCodeId
)

select @Id = 0

While (Select Count(*) From @tbl_companyId) > 0
Begin

    Select Top 1 @Id = CompanyId From @tbl_companyId
	select @pCompanyCode = ''
	select @pCompanyCode = case when b.PropertyValue = a.CompanyCode then LOWER(a.CompanyCode) else LOWER(B.PropertyValue) END
	from WEYIMgr.dbo.Company (nolock) a
		inner join WEYIMgr.dbo.CompanyProperty b (nolock) on b.CompanyId = a.Id and PropertyType = 'Web' and PropertyName = 'StyleKey'
	where a.Id = @Id
	select @pLink = @pCompanyCode + 'app://www.weyi.co'
    insert into WEYI.dbo.CompanyAppLaunchLink 
	(
		[CompanyId],
		[ApplicationTypeCodeId],
		[DeviceTypeCodeId],
		[LaunchLink],
		[CreateDate],
		[LastUpdate]
	)
	select @Id as [CompanyId],
			@pApplicationTypeCodeId as [ApplicationTypeCodeId],
			@pDeviceTypeCodeId as [DeviceTypeCodeId],
			@pLink as [LaunchLink],
			@pTime as [CreateDate],
			@pTime as [LastUpdate]

    Delete @tbl_companyId Where CompanyId = @Id

End

-- Android Provider
select @pApplicationTypeCodeId = 2
select @pDeviceTypeCodeId = 2
delete from @tbl_companyId
insert into @tbl_companyId
(
	CompanyId
)
select a.Id
from WEYIMgr.dbo.Company a (nolock)
where a.Id not in
(
	select b.Id
	from WEYI.dbo.CompanyAppLaunchLink a(nolock)
		inner join WEYIMgr.dbo.Company b (nolock) on a.CompanyId = b.Id
	where a.ApplicationTypeCodeId = @pApplicationTypeCodeId
		and a.DeviceTypeCodeId = @pDeviceTypeCodeId
)

select @Id = 0

While (Select Count(*) From @tbl_companyId) > 0
Begin

    Select Top 1 @Id = CompanyId From @tbl_companyId
	select @pCompanyCode  = ''
	select @pCompanyCode = case when b.PropertyValue = a.CompanyCode then LOWER(a.CompanyCode) else LOWER(B.PropertyValue) END
	from WEYIMgr.dbo.Company (nolock) a
		inner join WEYIMgr.dbo.CompanyProperty b (nolock) on b.CompanyId = a.Id and PropertyType = 'Web' and PropertyName = 'StyleKey'
	where a.Id = @Id
	select @pLink = @pCompanyCode + 'providerapp://www.weyi.co'
    insert into WEYI.dbo.CompanyAppLaunchLink 
	(
		[CompanyId],
		[ApplicationTypeCodeId],
		[DeviceTypeCodeId],
		[LaunchLink],
		[CreateDate],
		[LastUpdate]
	)
	select @Id as [CompanyId],
			@pApplicationTypeCodeId as [ApplicationTypeCodeId],
			@pDeviceTypeCodeId as [DeviceTypeCodeId],
			@pLink as [LaunchLink],
			@pTime as [CreateDate],
			@pTime as [LastUpdate]

    Delete @tbl_companyId Where CompanyId = @Id

End



-- Web Client
select @pApplicationTypeCodeId = 1
select @pDeviceTypeCodeId = 5
delete from @tbl_companyId
insert into @tbl_companyId
(
	CompanyId
)
select a.Id
from WEYIMgr.dbo.Company a (nolock)
where a.Id not in
(
	select b.Id
	from WEYI.dbo.CompanyAppLaunchLink a(nolock)
		inner join WEYIMgr.dbo.Company b (nolock) on a.CompanyId = b.Id
	where a.ApplicationTypeCodeId = @pApplicationTypeCodeId
		and a.DeviceTypeCodeId = @pDeviceTypeCodeId
)

select @Id = 0

While (Select Count(*) From @tbl_companyId) > 0
Begin

    Select Top 1 @Id = CompanyId From @tbl_companyId
	select @pCompanyCode  = ''
	select @pCompanyCode = case when b.PropertyValue = a.CompanyCode then LOWER(a.CompanyCode) else LOWER(B.PropertyValue) END
	from WEYIMgr.dbo.Company (nolock) a
		inner join WEYIMgr.dbo.CompanyProperty b (nolock) on b.CompanyId = a.Id and PropertyType = 'Web' and PropertyName = 'StyleKey'
	where a.Id = @Id
	select @pLink = PropertyValue + '?Company='+@pCompanyCode
	from DBServerProperty (nolock)
	where PropertyName = 'WEYIClient'
		and PropertyType = 'WEYIClient'

    insert into WEYI.dbo.CompanyAppLaunchLink 
	(
		[CompanyId],
		[ApplicationTypeCodeId],
		[DeviceTypeCodeId],
		[LaunchLink],
		[CreateDate],
		[LastUpdate]
	)
	select @Id as [CompanyId],
			@pApplicationTypeCodeId as [ApplicationTypeCodeId],
			@pDeviceTypeCodeId as [DeviceTypeCodeId],
			@pLink as [LaunchLink],
			@pTime as [CreateDate],
			@pTime as [LastUpdate]

    Delete @tbl_companyId Where CompanyId = @Id

End



-- Web Provider
select @pApplicationTypeCodeId = 2
select @pDeviceTypeCodeId = 5
delete from @tbl_companyId
insert into @tbl_companyId
(
	CompanyId
)
select a.Id
from WEYIMgr.dbo.Company a (nolock)
where a.Id not in
(
	select b.Id
	from WEYI.dbo.CompanyAppLaunchLink a(nolock)
		inner join WEYIMgr.dbo.Company b (nolock) on a.CompanyId = b.Id
	where a.ApplicationTypeCodeId = @pApplicationTypeCodeId
		and a.DeviceTypeCodeId = @pDeviceTypeCodeId
)

select @Id = 0

While (Select Count(*) From @tbl_companyId) > 0
Begin

    Select Top 1 @Id = CompanyId From @tbl_companyId
	select @pCompanyCode  = ''
	select @pCompanyCode = case when b.PropertyValue = a.CompanyCode then LOWER(a.CompanyCode) else LOWER(B.PropertyValue) END
	from WEYIMgr.dbo.Company (nolock) a
		inner join WEYIMgr.dbo.CompanyProperty b (nolock) on b.CompanyId = a.Id and PropertyType = 'Web' and PropertyName = 'StyleKey'
	where a.Id = @Id
	select @pLink = PropertyValue + '?Company='+@pCompanyCode
	from DBServerProperty (nolock)
	where PropertyName = 'WEYIProvider'
		and PropertyType = 'WEYIProvider'

    insert into WEYI.dbo.CompanyAppLaunchLink 
	(
		[CompanyId],
		[ApplicationTypeCodeId],
		[DeviceTypeCodeId],
		[LaunchLink],
		[CreateDate],
		[LastUpdate]
	)
	select @Id as [CompanyId],
			@pApplicationTypeCodeId as [ApplicationTypeCodeId],
			@pDeviceTypeCodeId as [DeviceTypeCodeId],
			@pLink as [LaunchLink],
			@pTime as [CreateDate],
			@pTime as [LastUpdate]

    Delete @tbl_companyId Where CompanyId = @Id

End


select * from CompanyAppLaunchLink

