--select * from MsgTemplate
--select * from CodeList where Category = 'MsgDeliveryMethod'

declare @TblCode as Table
(
	[MsgDeliveryMethodCodeId] int NOT NULL,			-- CodeList (Category MsgDeliveryMethod) Mobile Push, Email, Text
	[TemplateName] [varchar](256) NOT NULL,		-- New_Request, New_Interview, Mobile_Phone_Validation
	[Template] [nvarchar](max) NOT NULL
)	


declare @TemplateName [varchar](256) = ''



--select * from CodeList where Category = 'MsgDeliveryMethod' order by SortOrder
--select * from MsgTemplate

delete @TblCode

select @TemplateName = 'PersonPreRegister'

insert into @TblCode	
([MsgDeliveryMethodCodeId], [TemplateName], [Template])
select a.*
from (
	select 3 as [MsgDeliveryMethodCodeId], @TemplateName as [TemplateName], 
		'<p><strong>Welcome aboard!</strong></p>

<p>Click here to install WEYI now:  <a href=''$Link$''>$Link$</a><br />
... and start getting real-time translations from our live interpreters. </p>

<p>Have a friend who could use our help? Simply text them the link above, forward this email, or copy/paste the link. </p>

<p><strong>WEYI</strong>: What language barrier?<br />
<a href=''https://www.facebook.com/pages/WEYI/1620801338137583''>https://www.facebook.com/pages/WEYI/1620801338137583</a><br />
<a href=''https://www.weyimobile.com''>www.weyimobile.com</a><br />
</p>' as [Template]
	

	UNION 

	select 31 as [MsgDeliveryMethodCodeId], @TemplateName as [TemplateName], 
		'WEYI Mobile App' as [Template]

	UNION
	
	select 4 as [MsgDeliveryMethodCodeId], @TemplateName as [TemplateName], 
		'Get realtime translations with WEYI Now! $Link$' as [Template]
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




select * from MsgTemplate where TemplateName = 'PersonPreRegister'
