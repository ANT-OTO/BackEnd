--select * from UIElement where ElementKey = 'companycode_input_hint'

declare @Tbl2 as Table
(
	UIElementId int NOT NULl,
	[SystemLanguageId] int NOT NULL,			
	[Content] nvarchar(max) NOT NULL		
)


declare @AppName [nvarchar](64) = N'Client'
declare @ElementKey nvarchar(128) = N'payment'

--select * from SystemLanguage
insert into @Tbl2
(UIElementId, [SystemLanguageId], [Content])
select 0 as UIElementId,
	a.Id as SystemLanguageId,
	case when a.Id = 2 then N'支付方式'		-- 2	简体中文	zh-CN
		else N'Payment Method'
	end
from SystemLanguage a (nolock)
where a.Available = 1
order by a.Id


declare @UIElementId int = 0

declare @Tbl as Table
(
	[AppName] [nvarchar](64) NOT NULL,			-- Provider, Provider, CompanySite 
	[DeviceType] [nvarchar](32) NOT NULL,		-- iPhone, Android, Web, EmptyString is applicable to all devices if no specific device is defined for the ElementKey
	[ElementKey] [nvarchar](128) NOT NULL
)

insert into @Tbl
([AppName], [DeviceType], [ElementKey])
select a.[AppName], a.[DeviceType], a.[ElementKey]
from (
	select @AppName as [AppName], '' as [DeviceType], @ElementKey as [ElementKey], 1 as SortOrder
) a 

--select * from [UIElement]
insert into [UIElement]
(AppName,DeviceType,ElementKey,CreateDate)
select a.AppName,a.DeviceType,a.ElementKey, GETUTCDATE()
from @Tbl a left join [UIElement] z on a.AppName = z.AppName and a.DeviceType = z.DeviceType and a.ElementKey = z.ElementKey
where z.Id is null

if( @@ROWCOUNT = 0 )
begin
	select @UIElementId = a.Id
	from UIElement a 
	where a.[AppName] = @AppName and a.[DeviceType] = '' and a.[ElementKey] = @ElementKey
end
else
begin
	select @UIElementId = SCOPE_IDENTITY()
end

update @Tbl2 set UIElementId = @UIElementId


--select * from [UIElementY]
insert into [UIElementY]
(UIElementId,SystemLanguageId,Content, CreateDate)
select a.UIElementId, a.SystemLanguageId, a.Content
	, GETUTCDATE()
--select c.*
from @Tbl2 a
	left join (
		select a.*
		from [UIElementY] a inner join (
				select max(Id) as Id
				from [UIElementY] 
				where UIElementId = @UIElementId
				group by SystemLanguageId
			) b on a.Id = b.Id
	) z on a.UIElementId = z.UIElementId and a.SystemLanguageId = z.SystemLanguageId and a.Content = z.Content
where z.Id is null

select * from [UIElement] where Id = @UIElementId
select * from [UIElementY] where UIElementId = @UIElementId
