--select * from [MsgTemplate]
--select * from [MsgTemplateY]
--select * from SystemLanguage


declare @SystemLanguageId int
select @SystemLanguageId = Id
--select *
from SystemLanguage where [Name] = N'简体中文'

declare @TblTemplateY as Table
(
	[MsgTemplateId] [int] NOT NULL,
	[SystemLanguageId] [int] NOT NULL,
	[Template] [nvarchar](max) NOT NULL
)

delete @TblTemplateY

--select * from MsgTemplate where TemplateName = 'ProviderStatusPage'

insert into @TblTemplateY
(MsgTemplateId, SystemLanguageId, [Template])
select a.MsgTemplateId, @SystemLanguageId, a.[Template]
from (
	select a.*
	from (
	select a.Id as MsgTemplateId,
		case when MsgDeliveryMethodCodeId = 5 and TemplateName = 'ProviderStatusPage' then N'<strong>欢迎！</strong>
<div style="display:$DisplayApproved$;">
<p>您获得批准给维译客户提供以下翻译服务：</p>
<ul>$ApprovedItemList$
</ul>
<p>请根据您的时间安排设定您在维译的服务时间。</p>
</div>
<div style="display:$DisplayPending$;">
<p>您对维译客户以下翻译服务在被批准之前需要经过面试和培训：</p>
<ul>$PendingItemList$
</ul>
<p>在您设定的工作服务时间，维译会跟您联系。</p>
</div>
<div>
<div style="display:$DisplayNotActive$;">
<p>您现在没有可以给维译提供的翻译服务。</p>
</div>
<div>
如果有什么问题，请打电话: +1 (855) 568-6509 或电子邮件给 pm@weyimobile.com
</div>'
		else N''
		end as [Template]
	--select *
	from [MsgTemplate] a
	) a where a.[Template] <> ''

	
) a 

select * from @TblTemplateY



insert into [MsgTemplateY]
(MsgTemplateId, SystemLanguageId, [Template])
select a.* 
from @TblTemplateY a left join [MsgTemplateY] z on a.MsgTemplateId = z.MsgTemplateId and z.SystemLanguageId = @SystemLanguageId 
where z.Id is null

update a
set a.Template = b.Template
from [MsgTemplateY] a inner join @TblTemplateY b on a.MsgTemplateId = b.MsgTemplateId and a.SystemLanguageId = b.SystemLanguageId
where a.SystemLanguageId = @SystemLanguageId 

--select * from @TblTemplateY
--select * from MsgTemplateY where SystemLanguageId = @SystemLanguageId 


delete [MsgTemplateY] 
where Id in (
	select a.Id from MsgTemplateY a inner join MsgTemplate b on a.MsgTemplateId = b.Id
	where a.SystemLanguageId = @SystemLanguageId and b.TemplateName = 'ProviderStatusPage'
) and ( MsgTemplateId not in (select MsgTemplateId from @TblTemplateY)
	or ( MsgTemplateId in (select MsgTemplateId from @TblTemplateY) and SystemLanguageId = 1)
 )
  

delete [MsgTemplateY] 
where SystemLanguageId = 1

select * from [MsgTemplateY] a inner join [MsgTemplate] b on a.MsgTemplateId = b.Id
where a.SystemLanguageId = @SystemLanguageId
and b.TemplateName = 'ProviderStatusPage'
order by b.[Template]

------------------------------------------------- What is missing ------------------------------------------
select *
from MsgTemplate a inner join SystemLanguage b on b.Available = 1 and b.Id <> 1
	left join MsgTemplateY z on a.Id = z.MsgTemplateId and b.Id = z.SystemLanguageId
where z.Id is null