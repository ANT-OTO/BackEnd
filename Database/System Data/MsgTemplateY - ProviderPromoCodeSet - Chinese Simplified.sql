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

--select * from MsgTemplate where TemplateName = 'ProviderPromoCodeSet'

insert into @TblTemplateY
(MsgTemplateId, SystemLanguageId, [Template])
select a.MsgTemplateId, @SystemLanguageId, a.[Template]
from (
	select a.*
	from (
	select a.Id as MsgTemplateId,
		case when MsgDeliveryMethodCodeId = 5 and TemplateName = 'ProviderPromoCodeSet' then N'促销代码已被接受'
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
	where a.SystemLanguageId = @SystemLanguageId and b.TemplateName = 'ProviderPromoCodeSet'
) and ( MsgTemplateId not in (select MsgTemplateId from @TblTemplateY)
	or ( MsgTemplateId in (select MsgTemplateId from @TblTemplateY) and SystemLanguageId = 1)
 )
  

delete [MsgTemplateY] 
where SystemLanguageId = 1

select * from [MsgTemplateY] a inner join [MsgTemplate] b on a.MsgTemplateId = b.Id
where a.SystemLanguageId = @SystemLanguageId
and b.TemplateName = 'ProviderPromoCodeSet'
order by b.[Template]

------------------------------------------------- What is missing ------------------------------------------
select *
from MsgTemplate a inner join SystemLanguage b on b.Available = 1 and b.Id <> 1
	left join MsgTemplateY z on a.Id = z.MsgTemplateId and b.Id = z.SystemLanguageId
where z.Id is null