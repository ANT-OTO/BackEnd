--select * from [MsgTemplate]
--select * from [MsgTemplateY]
--select * from SystemLanguage


declare @SystemLanguageId int
select @SystemLanguageId = Id
--select *
from SystemLanguage where [Name] = N'繁體中文'

declare @TblTemplateY as Table
(
	[MsgTemplateId] [int] NOT NULL,
	[SystemLanguageId] [int] NOT NULL,
	[Template] [nvarchar](max) NOT NULL
)

delete @TblTemplateY

insert into @TblTemplateY
(MsgTemplateId, SystemLanguageId, [Template])

select a.MsgTemplateId, @SystemLanguageId, a.Template
from (
select a.Id as MsgTemplateId,
	case when MsgDeliveryMethodCodeId = 4 and TemplateName = 'PhoneValidation' then N'驗證碼是 $Code$'
		 when MsgDeliveryMethodCodeId = 1 and TemplateName = 'NewTaskNotification' then N'新任務 $AdditionalInfo$'
	else N''
	end as [Template]
--select *
from [MsgTemplate] a
) a where a.[Template] <> ''

--select * from @TblTemplateY
--select * from MsgTemplateY where SystemLanguageId = @SystemLanguageId 

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
where (SystemLanguageId = @SystemLanguageId and MsgTemplateId not in (select MsgTemplateId from @TblTemplateY))
  or ( MsgTemplateId in (select MsgTemplateId from @TblTemplateY) and SystemLanguageId = 1)

select * from [MsgTemplateY] where SystemLanguageId = @SystemLanguageId
order by [Template]