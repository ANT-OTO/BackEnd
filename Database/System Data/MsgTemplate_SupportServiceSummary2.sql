--select * from MsgTemplate
--select * from CodeList where Category = 'MsgDeliveryMethod'

declare @TblCode as Table
(
	[MsgDeliveryMethodCodeId] int NOT NULL,			-- CodeList (Category MsgDeliveryMethod) Mobile Push, Email, Text
	[TemplateName] [varchar](256) NOT NULL,		-- New_Request, New_Interview, Mobile_Phone_Validation
	[Template] [nvarchar](max) NOT NULL
)	


declare @TemplateName [varchar](256) = ''

declare @MsgDeliveryMethodCodeId int = 0
select @MsgDeliveryMethodCodeId = a.CodeId
--select *
from CodeList a where Category = 'MsgDeliveryMethod' and a.CodeShort = 'Application'

select @TemplateName = 'SupportServiceSummary2'




--select * from CodeList where Category = 'MsgDeliveryMethod' order by SortOrder
--select * from MsgTemplate

delete @TblCode



insert into @TblCode	
([MsgDeliveryMethodCodeId], [TemplateName], [Template])
select a.*
from (
	select @MsgDeliveryMethodCodeId as [MsgDeliveryMethodCodeId], @TemplateName as [TemplateName], 
		'Request ID' as [Template]
) a 

insert into [MsgTemplate]
([MsgDeliveryMethodCodeId], [TemplateName], [Template], CreateDate)
select a.*, GETUTCDATE()
from @TblCode a left join  [MsgTemplate] z on a.[MsgDeliveryMethodCodeId] = z.[MsgDeliveryMethodCodeId] and a.TemplateName = z.TemplateName
where z.Id is null

update a
set a.[Template] = b.[Template]
from [MsgTemplate] a inner join  @TblCode b on a.[MsgDeliveryMethodCodeId] = b.[MsgDeliveryMethodCodeId] and a.TemplateName = b.TemplateName

delete 
--select * from
[MsgTemplateY] where MsgTemplateId in (
	select a.Id
	from [MsgTemplate] a left join @TblCode z on a.[MsgDeliveryMethodCodeId] = z.[MsgDeliveryMethodCodeId] and a.TemplateName = z.TemplateName
	where a.[TemplateName] = @TemplateName and z.[MsgDeliveryMethodCodeId] is null
)

delete 
--select * from
[MsgTemplate] where Id in (
	select a.Id
	from [MsgTemplate] a left join @TblCode z on a.[MsgDeliveryMethodCodeId] = z.[MsgDeliveryMethodCodeId] and a.TemplateName = z.TemplateName
	where a.[TemplateName] = @TemplateName and z.[MsgDeliveryMethodCodeId] is null
)




select * from MsgTemplate where TemplateName = 'SupportServiceSummary2'

go

-----------------------------------------------------------System Language Id: 2 Begin ---------------------------------------------------------------------------------------------------

--select * from [MsgTemplate]
--select * from [MsgTemplateY]
--select * from SystemLanguage


declare @SystemLanguageId int
select @SystemLanguageId = Id
--select *
from SystemLanguage where Id = 2 --[Name] = N'简体中文'

declare @TemplateName [varchar](256) = ''

declare @MsgDeliveryMethodCodeId int = 0
select @MsgDeliveryMethodCodeId = a.CodeId
--select *
from CodeList a where Category = 'MsgDeliveryMethod' and a.CodeShort = 'Application'

select @TemplateName = 'SupportServiceSummary2'




declare @TblTemplateY as Table
(
	[MsgTemplateId] [int] NOT NULL,
	[SystemLanguageId] [int] NOT NULL,
	[Template] [nvarchar](max) NOT NULL
)

delete @TblTemplateY

insert into @TblTemplateY
(MsgTemplateId, SystemLanguageId, [Template])
select a.MsgTemplateId, @SystemLanguageId, a.[Template]
from (
	select a.*
	from (
	select a.Id as MsgTemplateId,
		case when MsgDeliveryMethodCodeId = @MsgDeliveryMethodCodeId and TemplateName = @TemplateName then N'服务序号'
		else N''
		end as [Template]
	--select *
	from [MsgTemplate] a
	) a where a.[Template] <> ''

	
) a 

--select * from @TblTemplateY

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

delete 
--select * from
[MsgTemplateY] 
where Id in (
	select a.Id from MsgTemplateY a inner join MsgTemplate b on a.MsgTemplateId = b.Id
	where a.SystemLanguageId = @SystemLanguageId and b.MsgDeliveryMethodCodeId = @MsgDeliveryMethodCodeId and b.TemplateName = @TemplateName
) and ( MsgTemplateId not in (select MsgTemplateId from @TblTemplateY)
 )
  

delete 
--select * from
[MsgTemplateY] 
where SystemLanguageId = 1

select * from [MsgTemplateY] a inner join [MsgTemplate] b on a.MsgTemplateId = b.Id
where a.SystemLanguageId = @SystemLanguageId
	and b.MsgDeliveryMethodCodeId = @MsgDeliveryMethodCodeId and b.TemplateName = @TemplateName
order by b.[Template]



--select * from [MsgTemplateY] where SystemLanguageId = @SystemLanguageId
--order by [Template]


------------------------------------------------- What is missing ------------------------------------------

select *
from MsgTemplate a inner join SystemLanguage b on b.Available = 1 and b.Id <> 1
	left join MsgTemplateY z on a.Id = z.MsgTemplateId and b.Id = z.SystemLanguageId
where z.Id is null
order by b.Id, a.Id


go


-----------------------------------------------------------System Language Id: 2 End -----------------------------------------------------------------------------------------------------


-----------------------------------------------------------System Language Id: 14 Begin ---------------------------------------------------------------------------------------------------

--select * from [MsgTemplate]
--select * from [MsgTemplateY]
--select * from SystemLanguage


declare @SystemLanguageId int
select @SystemLanguageId = Id
--select *
from SystemLanguage where Id = 14 --[Name] = N'Deutsch' --	de

declare @TemplateName [varchar](256) = ''

declare @MsgDeliveryMethodCodeId int = 0
select @MsgDeliveryMethodCodeId = a.CodeId
--select *
from CodeList a where Category = 'MsgDeliveryMethod' and a.CodeShort = 'Application'

select @TemplateName = 'SupportServiceSummary2'




declare @TblTemplateY as Table
(
	[MsgTemplateId] [int] NOT NULL,
	[SystemLanguageId] [int] NOT NULL,
	[Template] [nvarchar](max) NOT NULL
)

delete @TblTemplateY

insert into @TblTemplateY
(MsgTemplateId, SystemLanguageId, [Template])
select a.MsgTemplateId, @SystemLanguageId, a.[Template]
from (
	select a.*
	from (
	select a.Id as MsgTemplateId,
		case when MsgDeliveryMethodCodeId = @MsgDeliveryMethodCodeId and TemplateName = @TemplateName 
			then N'Anfrage ID'
		else N''
		end as [Template]
	--select *
	from [MsgTemplate] a
	) a where a.[Template] <> ''

	
) a 

--select * from @TblTemplateY

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

delete 
--select * from
[MsgTemplateY] 
where Id in (
	select a.Id from MsgTemplateY a inner join MsgTemplate b on a.MsgTemplateId = b.Id
	where a.SystemLanguageId = @SystemLanguageId and b.MsgDeliveryMethodCodeId = @MsgDeliveryMethodCodeId and b.TemplateName = @TemplateName
) and ( MsgTemplateId not in (select MsgTemplateId from @TblTemplateY)
 )
  

delete 
--select * from
[MsgTemplateY] 
where SystemLanguageId = 1

select * from [MsgTemplateY] a inner join [MsgTemplate] b on a.MsgTemplateId = b.Id
where a.SystemLanguageId = @SystemLanguageId
	and b.MsgDeliveryMethodCodeId = @MsgDeliveryMethodCodeId and b.TemplateName = @TemplateName
order by b.[Template]



--select * from [MsgTemplateY] where SystemLanguageId = @SystemLanguageId
--order by [Template]


------------------------------------------------- What is missing ------------------------------------------

select *
from MsgTemplate a inner join SystemLanguage b on b.Available = 1 and b.Id <> 1
	left join MsgTemplateY z on a.Id = z.MsgTemplateId and b.Id = z.SystemLanguageId
where z.Id is null
order by b.Id, a.Id


go


-----------------------------------------------------------System Language Id: 14 End -----------------------------------------------------------------------------------------------------

