insert MsgTemplate (
MsgDeliveryMethodCodeId,
TemplateName,
Template,
CreateDate
)
select 4, 'WebSendLink', 'Get the WEYI app: $Link$', getdate()
go

insert MsgTemplateY
(MsgTemplateId,	SystemLanguageId,	Template,	CreateDate)
select Id,	2,	N'获取维译: $Link$' , getdate()
from MsgTemplate where TemplateName = 'WebSendLink'
go

insert MsgTemplate (
MsgDeliveryMethodCodeId,
TemplateName,
Template,
CreateDate
)
select 4, 'WebSendProviderLink', 'Get the WEYI Provider app: $Link$', getdate()
go

insert MsgTemplateY
(MsgTemplateId,	SystemLanguageId,	Template,	CreateDate)
select Id,	2,	N'获取维译译者: $Link$' , getdate()
from MsgTemplate where TemplateName = 'WebSendProviderLink'

select top 10 * from MsgTemplate a inner join MsgTemplateY b on a.Id = b.MsgTemplateId
order by a.Id desc