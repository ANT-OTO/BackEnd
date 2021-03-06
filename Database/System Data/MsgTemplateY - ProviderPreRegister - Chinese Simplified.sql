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

--select * from MsgTemplate where TemplateName = 'ProviderPreRegister'

insert into @TblTemplateY
(MsgTemplateId, SystemLanguageId, [Template])
select a.MsgTemplateId, @SystemLanguageId, a.[Template]
from (
	select a.*
	from (
	select a.Id as MsgTemplateId,
		case when MsgDeliveryMethodCodeId = 31 and TemplateName = 'ProviderPreRegister' then N'维译译者应用'
			when MsgDeliveryMethodCodeId = 4 and TemplateName = 'ProviderPreRegister' then N'感谢您对加入维译译者团队的兴趣！点击下载维译译者应用: $Link$'
			when MsgDeliveryMethodCodeId = 3 and TemplateName = 'ProviderPreRegister' then N'<p>您好 --</p>

<p>感谢您对加入维译译者团队的兴趣! 我们这个团队致力于服务这个社会, 让语言不再是沟通的障碍。</p>

<p>您可以 点击这里下载免费的维译译者应用：<a href=''$Link$''>$Link$</a></p>

<p>马上下载和注册吧！ 我们期待着您的加入！

<p>维译译者团队</p>'
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
	where a.SystemLanguageId = @SystemLanguageId and b.TemplateName = 'ProviderPreRegister'
) and ( MsgTemplateId not in (select MsgTemplateId from @TblTemplateY)
	or ( MsgTemplateId in (select MsgTemplateId from @TblTemplateY) and SystemLanguageId = 1)
 )
  

delete [MsgTemplateY] 
where SystemLanguageId = 1

select * from [MsgTemplateY] a inner join [MsgTemplate] b on a.MsgTemplateId = b.Id
where a.SystemLanguageId = @SystemLanguageId
and b.TemplateName = 'ProviderPreRegister'
order by b.[Template]

------------------------------------------------- What is missing ------------------------------------------
select *
from MsgTemplate a inner join SystemLanguage b on b.Available = 1 and b.Id <> 1
	left join MsgTemplateY z on a.Id = z.MsgTemplateId and b.Id = z.SystemLanguageId
where z.Id is null