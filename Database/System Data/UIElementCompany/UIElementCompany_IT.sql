--select * from UIElementCompany where ElementKey = 'WEYIVideo_mainmenu'

declare @Tbl2 as Table
(
	[ApplicationTypeCodeId] [int] NOT NULL,		-- 1	Client, 2	Provider, 3	ManagementTool, 99	Other
												-- select * from CodeList where Category = 'ApplicationType'
	[DeviceTypeCodeId] [int] NOT NULL,			-- 1	iPhone, 2	Android, 5	Web
												-- select * from CodeList where Category = 'DeviceType' where CodeId in (1, 2, 5)

	[ElementKey] [nvarchar](128) NOT NULL,
	[SystemLanguageId] int NOT NULL,			
	[Content] nvarchar(max) NOT NULL		
)

declare @CompanyId int = 0
declare @DeviceTypeCodeId int = 0			-- 0: Default 

select @CompanyId = a.Id
from WEYIMgr.dbo.Company a where a.CompanyCode = 'IT'

select @CompanyId = isnull(@CompanyId, 0)
if( @CompanyId <= 0 )
begin
	RAISERROR (15600,-1,-1, 'No companyId'); 
	return
end

declare @Tbl as Table
(

	[ApplicationTypeCodeId] [int] NOT NULL,		-- 1	Client, 2	Provider, 3	ManagementTool, 99	Other
												-- select * from CodeList where Category = 'ApplicationType'
	[DeviceTypeCodeId] [int] NOT NULL,			-- 1	iPhone, 2	Android, 5	Web
												-- select * from CodeList where Category = 'DeviceType' where CodeId in (1, 2, 5)
	[ElementKey] [nvarchar](128) NOT NULL
)


insert into @Tbl
([ApplicationTypeCodeId], [DeviceTypeCodeId], [ElementKey])
select a.*
from (
	-- 1	Client, 2	Provider, 3	ManagementTool, 99	Other
	select 1 as [ApplicationTypeCodeId], @DeviceTypeCodeId as [DeviceTypeCodeId], N'App_Title' as [ElementKey]

	UNION

	-- 1	Client, 2	Provider, 3	ManagementTool, 99	Other
	select 2 as [ApplicationTypeCodeId], @DeviceTypeCodeId as [DeviceTypeCodeId], N'App_Title' as [ElementKey]

	UNION

	-- 1	Client, 2	Provider, 3	ManagementTool, 99	Other
	select 3 as [ApplicationTypeCodeId], @DeviceTypeCodeId as [DeviceTypeCodeId], N'App_Title' as [ElementKey]
) a 


--select * from SystemLanguage
insert into @Tbl2
([ApplicationTypeCodeId], [DeviceTypeCodeId], ElementKey, [SystemLanguageId], [Content])
select b.ApplicationTypeCodeId, b.DeviceTypeCodeId, b.[ElementKey],
	a.Id as SystemLanguageId,
	case when b.ApplicationTypeCodeId = 1 and b.ElementKey = N'App_Title' then 
											N'Intercultural Translations'
		when b.ApplicationTypeCodeId = 2 and b.ElementKey = N'App_Title' then 
											N'IT Interpreters'
		when b.ApplicationTypeCodeId = 3 and b.ElementKey = N'App_Title' then 
											N'Intercultural Translations VRI Management System'
	else 
		N'!!!System Error!!!'
	end
from SystemLanguage a (nolock)
	inner join @Tbl b on a.Available = 1
where a.Id in ( 1, 2)		-- English, Chinese
order by a.Id


if( exists( select * from @Tbl2 where Content = N'!!!System Error!!!') )
begin
	select * from @Tbl2
	RAISERROR (15600,-1,-1, '!!!System Error!!!'); 
	return
end


--select * from [UIElementCompany]
insert into [UIElementCompany]
(CompanyId,ApplicationTypeCodeId, DeviceTypeCodeId,ElementKey,CreateDate)
select @CompanyId, a.ApplicationTypeCodeId,a.DeviceTypeCodeId,a.ElementKey, GETUTCDATE()
from @Tbl a left join [UIElementCompany] z on z.CompanyId = @CompanyId and a.ApplicationTypeCodeId = z.ApplicationTypeCodeId and a.DeviceTypeCodeId = z.DeviceTypeCodeId and a.ElementKey = z.ElementKey
where z.Id is null



--select * from [UIElementCompanyY]
insert into [UIElementCompanyY]
(UIElementCompanyId,SystemLanguageId,Content, CreateDate)
select c.Id, b.SystemLanguageId, b.Content
	, GETUTCDATE()
--select c.*
from @Tbl a
	inner join @Tbl2 b on a.ApplicationTypeCodeId = b.ApplicationTypeCodeId and a.DeviceTypeCodeId = b.DeviceTypeCodeId and a.ElementKey = b.ElementKey
	inner join [UIElementCompany] c on c.CompanyId = @CompanyId and c.ApplicationTypeCodeId = a.ApplicationTypeCodeId and c.DeviceTypeCodeId = c.DeviceTypeCodeId and c.ElementKey = a.ElementKey
	left join (
		select a.*, c.ElementKey
		from [UIElementCompanyY] a 
			inner join (
				select max(Id) as Id
				from [UIElementCompanyY] 
				group by UIElementCompanyId, SystemLanguageId
			) b on a.Id = b.Id
			inner join UIElementCompany c on a.UIElementCompanyId = c.Id
		where c.CompanyId = @CompanyId
	) z on a.ElementKey = z.ElementKey and b.SystemLanguageId = z.SystemLanguageId and b.Content = z.Content
where z.Id is null

select * from [UIElementCompany] where CompanyId = @CompanyId
select a.* from [UIElementCompanyY] a inner join [UIElementCompany] b on a.UIElementCompanyId = b.Id where b.CompanyId = @CompanyId order by b.Id, a.Id desc
